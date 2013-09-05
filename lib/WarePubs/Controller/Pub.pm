package WarePubs::Controller::Pub;

use Moose;
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

    my $pub = $c->model('DB')->resultset('Pub')->create({
        foo => 'bar',
    });
 
    $c->forward( $c->uri_for('/pub/view', $pub->id ) );
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

    my $fundings = $c->model('DB')->resultset('Funding')->search(
        { agency_id => $pub->funding->agency_id }, 
        { order_by => { '-asc' => 'title' } }
    );

    $c->stash(
        pub      => $pub,
        agencies => $agencies,
        fundings => $fundings,
        template => 'pub-edit-form.tmpl'
    );
}

# ----------------------------------------------------------------------
=head2 list_service
 
Fetch all pubs.
 
=cut
 
sub list_service :Local {
    my ($self, $c) = @_;
    my $req        = $c->request;
    my $format     = $req->param('format')     || 'json';
    my $order_by   = $req->param('order_by')   || 'title';
    my $sort_order = $req->param('sort_order') || 'asc';

    my $search_params;
    if ( my $filter = $req->param('filter') ) {
        $search_params = [];
        for my $fld ( 
            @{ $c->config->{'search_fields'}{'pubs'} || [ 'title' ] }
        ) {
            push @$search_params, { $fld => { like => "%$filter%" } };
        }
    }

    my $pubs_rs = $c->model('DB')->resultset('Pub')->search_rs(
        $search_params,
        { order_by => { '-' . $sort_order => $order_by } }
    );

    if ( lc $format eq 'html' ) {
        $c->stash( 
            pubs       => $pubs_rs,
            template   => 'pub-list-service.tmpl',
            no_wrapper => 1,
        );
    }
    else {
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
        data       => $req->param('data')       || '',
        cover      => $req->param('cover')      || '',
    });

    $c->res->redirect( $c->uri_for('/pub/view', $pub->id ) );
}

# ----------------------------------------------------------------------
=head2 view
 
Detail for a single pub.
 
=cut
 
sub view :Local {
    my ( $self, $c, $pub_id ) = @_;
 
    my $pub = $c->model('DB')->resultset('Pub')->find($pub_id)
              or die "Bad pub id '$pub_id'\n";

    $c->stash(
        pub      => $pub,
        template => 'pub-view.tmpl'
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
