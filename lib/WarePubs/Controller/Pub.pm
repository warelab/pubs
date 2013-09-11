package WarePubs::Controller::Pub;

use Moose;
use DateTime;
use Data::Dump 'dump';
use File::Basename 'fileparse';
use File::Path 'mkpath';
use File::Spec::Functions 'catfile';
use Params::Validate qw(:all);
use Switch;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WarePubs::Controller::Pub - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

# ----------------------------------------------------------------------
=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched WarePubs::Controller::Pub in Pub.');
}

# ----------------------------------------------------------------------
=head2 create
 
Create a pub.
 
=cut
 
sub create :Local {
    my ( $self, $c ) = @_;
    my $req = $c->req;
    my $dt  = DateTime->now;
    my %required =  (
        year     => { 
            regex     => qr/^\d{4}$/,
            callbacks => {
                'year-check' => sub { 
                    my $y = shift;
                    $y < $dt->year + 1 && $y > 1990;
                },
            }
        },
        title    => 1,
        authors  => 1,
        journal  => 1,
    );

    my @params = map { $_, $req->param($_) } keys %required;

    validate( @params, \%required );

    my $pub       = $c->model('DB')->resultset('Pub')->create({
        year      => $req->param('year'),
        title     => $req->param('title'),
        authors   => $req->param('authors'),
        journal   => $req->param('journal'),
        pubmed    => $req->param('pubmed'),
        url       => $req->param('url'),
        data_path => $req->param('data_path'),
        comments  => $req->param('comments'),
    }) or die;

    $c->model('DB')->resultset('PubToFunding')->create({
        pub_id     => $pub->id,
        funding_id => 1, # unknown
    });

    my $dbh = $c->model('DB')->storage->dbh;
    for my $input ( qw[ pdf cover doc_115 ] ) {
        my $upload = $req->upload( $input ) or next;

        my ($filename, $directories, $suffix) 
            = fileparse($upload->filename, qr/\.[^.]*/);

        my $dest_file = join '', $pub->id, $suffix;
        my $dest_dir  = $c->path_to( qw[ root static pubs ], $input );

        if ( !-d $dest_dir ) {
            mkpath( $dest_dir );
        }

        my $dest_path = catfile( $dest_dir, $dest_file );

        if ( !$upload->copy_to( $dest_path ) ) {
            die sprintf( 
                "Can't copy '%s' to '%s'", $upload->filename, $dest_path
            );
        }

        $pub->set_column( $input => $dest_file );
        $pub->update;
    }
 
    $c->res->redirect( $c->uri_for('/pub/view', $pub->id ) );
}

# ----------------------------------------------------------------------
=head2 create_form
 
Show create form.
 
=cut
 
sub create_form :Local {
    my ( $self, $c ) = @_;
 
    $c->stash(
        agencies => [ $c->model('DB')->resultset('Agency')->all ],
        template => 'pub-create-form.tmpl'
    );
}

# ----------------------------------------------------------------------
=head2 delete
 
Delete a pub.
 
=cut
 
sub delete :Local :Args(1) {
    my ( $self, $c, $pub_id ) = @_;
 
    my $Pub = $c->model('DB')->resultset('Pub')->find($pub_id)
              or die "Bad pub id '$pub_id'\n";

    for my $PubFund ( $Pub->pub_to_funding ) {
        $PubFund->delete;
    }

    $Pub->delete;

    $c->res->redirect( $c->uri_for('/pub/list') );
}

# ----------------------------------------------------------------------
=head2 edit_form
 
Edit form for a pub.
 
=cut
 
sub edit_form :Local :Args(1) {
    my ( $self, $c, $pub_id ) = @_;
 
    my $pub = $c->model('DB')->resultset('Pub')->find($pub_id)
        or die "Bad pub id '$pub_id'\n";

    my $agencies = $c->model('DB')->resultset('Agency')->search(
        undef, 
        { order_by => { '-asc' => 'agency_name' } }
    );

#    my $fundings = $c->model('DB')->resultset('PubToFunding')->search(
##        { agency_id => $pub->funding->agency_id }, 
##        { agency_id => $pub->funding->agency_id }, 
#        { order_by => { '-asc' => 'title' } }
#    );

    $c->stash(
        pub      => $pub,
        agencies => $agencies,
#        fundings => $fundings,
        template => 'pub-edit-form.tmpl'
    );
}

# ----------------------------------------------------------------------
=head2 list_service
 
Fetch all pubs.
 
=cut
 
sub list_service :Local {
    my ($self, $c)   = @_;
    my $req          = $c->request;
    my $order_by     = $req->param('order_by')   || 'title';
    my $sort_order   = $req->param('sort_order') || 'asc';
    my $format       = lc $req->param('format')  || 'json';
    my %valid_format = map { $_, 1 } qw[ json html csv tab ];

    if ( !$valid_format{ $format } ) {
        die sprintf( "Invalid format '%s.'  Please choose from %s.",
            $format, join(', ', sort keys %valid_format)
        );
    }

    my $pubs_rs;
    if ( my $funding_id = $req->param('funding_id') ) {
#        $pubs_rs = $c->model('DB')->resultset('Pub')->search_related(
#            'pub_to_fundings',
#            { funding_id => $funding_id }
#        );
        $pubs_rs = $c->model('DB')->resultset('PubToFunding')->search_related(
            'pub',
            { funding_id => $funding_id }
        );
    }
    else {
        my $search_params;
        if ( my $filter = $req->param('filter') ) {
            $search_params = [];
            for my $fld ( 
                @{ $c->config->{'search_fields'}{'pub'} || [ 'title' ] }
            ) {
                push @$search_params, { $fld => { like => "%$filter%" } };
            }
        }

        $pubs_rs = $c->model('DB')->resultset('Pub')->search_rs(
            $search_params,
            { order_by => { '-' . $sort_order => $order_by } }
        );
    }

    switch ($format) {
        case 'html' {
            $c->stash( 
                pubs       => $pubs_rs,
                template   => 'pub-list-service.tmpl',
                no_wrapper => 1,
            );
        }

        case 'json' {
            my @pubs;
            while ( my $pub = $pubs_rs->next ) {
                push @pubs, { 
                    pub     => { $pub->get_inflated_columns },
                    funding => { $pub->funding->get_inflated_columns },
                    agency  => { $pub->funding->agency->get_inflated_columns },
                };
            }
         
            $c->stash( pubs => \@pubs );
            $c->forward('View::JSON');
        }

        else {
            my ( %cols, @header );

            for my $tbl ( qw[ pub funding agency ] ) {
                my @cols = @{ $c->config->{'download_fields'}{ $tbl } || [] };
                push @header, map { "$tbl.$_" } @cols;
                $cols{ $tbl } = [ @cols ];
            }

            my @pubs = ( [ @header ] );

            while ( my $pub = $pubs_rs->next ) {
                my %pub    = $pub->get_columns;
                my %fund   = $pub->funding->get_columns;
                my %agency = $pub->funding->agency->get_columns;

                push @pubs, [
                    ( map { $pub->get_column($_) } @{ $cols{'pub'} } ),
                    ( map { $pub->funding->get_column($_) } @{ $cols{'fund'} }),
                    (
                        map { $pub->funding->agency->get_column($_) }
                          @{ $cols{'agency'} }
                    ),
                ];
            }

            $c->stash( filename => "warelab-pubs.$format" );
            $c->stash( format   => $format );
            $c->stash( csv      => \@pubs );
            $c->forward('View::CSV');
        }

    }
}

# ----------------------------------------------------------------------
=head2 list
 
Look at all pubs.
 
=cut
 
sub list :Local {
    my ($self, $c) = @_;

    $c->stash( template => 'pub-list.tmpl' );
}

# ----------------------------------------------------------------------
=head2 update
 
Update the pub.
 
=cut
 
sub update :Local {
    my ( $self, $c ) = @_;

    my $req     = $c->req;
    my $pub_id  = $req->params->{'pub_id'}  or die 'No pub_id';
    my $title   = $req->params->{'title'}   or die 'No title';
    my $journal = $req->params->{'journal'} or die 'No journal';
    my $pub     = $c->model('DB')->resultset('Pub')->find($pub_id)
                  or die "Can't find pub '$pub_id'\n";
 
    $pub->update({
        title      => $title,
        journal    => $journal,
        funding_id => $req->param('funding_id') || 1,
        year       => $req->param('year')       || '',
        authors    => $req->param('authors')    || '',
        pubmed     => $req->param('pubmed')     || '',
        url        => $req->param('url')        || '',
        data_path  => $req->param('data_path')  || '',
        cover      => $req->param('cover')      || '',
        pdf        => $req->param('pdf')        || '',
    });

    $c->res->redirect( $c->uri_for('/pub/list') );
}

# ----------------------------------------------------------------------
=head2 view
 
Detail for a single pub.
 
=cut
 
sub view :Local {
    my ( $self, $c, $pub_id ) = @_;
 
    my $Pub = $c->model('DB')->resultset('Pub')->find($pub_id)
              or die "Bad pub id '$pub_id'\n";

    my $Funds = $c->model('DB')->resultset('PubToFunding')->search_related(
        'funding',
        { pub_id => $pub_id }
    );

    $c->stash(
        pub      => $Pub,
        template => 'pub-view.tmpl',
        funds    => $Funds,
    );
}

# ----------------------------------------------------------------------
=head1 AUTHOR

Ken Youens-Clark

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
