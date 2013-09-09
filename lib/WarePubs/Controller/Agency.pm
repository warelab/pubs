package WarePubs::Controller::Agency;

use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WarePubs::Controller::Agency - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

# ----------------------------------------------------------------------
=head2 create
 
Create an agency.
 
=cut
 
sub create :Local {
    my ($self, $c) = @_;

    my $req    = $c->req;
    my $name   = $req->param('agency_name') or die 'No agency name';
    my $url    = $req->param('url_template') || '';
    my ($Agency) = $c->model('DB')->resultset('Agency')->find_or_create({
        agency_name  => $name,
        url_template => $url,
    });

    $c->res->redirect('/agency/view/' . $Agency->id);
}

# ----------------------------------------------------------------------
=head2 create_form
 
Show create form.
 
=cut
 
sub create_form :Local {
    my ($self, $c) = @_;

    $c->stash( template => 'agency-create-form.tmpl' );
}

# ----------------------------------------------------------------------
=head2 update
 
Updates an agency.
 
=cut
 
sub update :Local {
    my ($self, $c) = @_;

    my $req    = $c->req;
    my $id     = $req->param('agency_id')   or die 'No agency id';
    my $name   = $req->param('agency_name') or die 'No agency name';
    my $url    = $req->param('url_template') || '';

    my ($Agency) = $c->model('DB')->resultset('Agency')->find($id)
        or die "Can't find agency id '$id'";

    $Agency->agency_name( $name );
    $Agency->url_template( $url );
    $Agency->update;

    $c->res->redirect('/agency/view/' . $id);
}

# ----------------------------------------------------------------------
=head2 edit_form
 
Detail for a single agency.
 
=cut
 
sub edit_form :Local {
    my ( $self, $c, $agency_id ) = @_;
 
    $c->stash(
        agency   => $c->model('DB')->resultset('Agency')->find($agency_id),
        template => 'agency-edit-form.tmpl',
    );
}
# ----------------------------------------------------------------------
=head2 info

=cut

sub foo :Path :Args(0) {
    my ( $self, $c ) = @_;

    $self->status_ok( $c, { info => 'list, view, etc.' } );
#    $c->response->body('info');
}

# ----------------------------------------------------------------------
=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched WarePubs::Controller::Agency in Agency.');
}

# ----------------------------------------------------------------------
=head2 list
 
Fetch all agencies.
 
=cut
 
sub list :Local {
    my ($self, $c) = @_;

    $c->stash( template => 'agency-list.tmpl' );
}

# ----------------------------------------------------------------------
=head2 list_service
 
Fetch all agencies.
 
=cut
 
sub list_service :Local {
    my ($self, $c) = @_;
    my $req        = $c->request;
    my $format     = $req->param('format')     || 'json';
    my $order_by   = $req->param('order_by')   || 'agency_name';
    my $sort_order = $req->param('sort_order') || 'asc';

    my $search_params;
    if ( my $filter = $req->param('filter') ) {
        $search_params = [];
        for my $fld ( 
            @{ $c->config->{'search_fields'}{'agencies'} || [ 'agency_name' ] }
        ) {
            push @$search_params, { $fld => { like => "%$filter%" } };
        }
    }

    my $agencies_rs = $c->model('DB')->resultset('Agency')->search_rs(
        $search_params,
        { order_by => { '-' . $sort_order => $order_by } }
    );

    if ( lc $format eq 'html' ) {
        $c->stash( 
            agencies   => $agencies_rs,
            template   => 'agency-list-service.tmpl',
            no_wrapper => 1,
        );
    }
    else {
        my @agencies;
        while ( my $agency = $agencies_rs->next ) {
            push @agencies, { $agency->get_inflated_columns };
        }
     
        $c->stash( agencies => \@agencies );
        $c->forward('View::JSON');
    }
}

# ----------------------------------------------------------------------
=head2 view
 
Detail for a single agency.
 
=cut
 
sub view :Local {
    my ( $self, $c, $agency_id ) = @_;
    my ($Agency) = $c->model('DB')->resultset('Agency')->find($agency_id)
        or die "Can't find agency id '$agency_id'";

#warn "fundings = ", ref $Agency->fundings;

    $c->stash(
        agency   => $Agency,
        template => 'agency-view.tmpl',
    );
}

=head1 AUTHOR

Ken Youens-Clark

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
