package WarePubs::Controller::Agency;

use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }
#BEGIN { extends 'Catalyst::Controller::REST'; }

=head1 NAME

WarePubs::Controller::Agency - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

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
    my $agencies   = $c->model('DB')->resultset('Agency')->search(
        undef,
        { order_by => { '-asc' => 'agency_name' } }
    );

    $c->stash(
        agencies => $agencies,
        template => 'agency-list.tmpl',
    );
}

# ----------------------------------------------------------------------
=head2 view
 
Detail for a single agency.
 
=cut
 
sub view :Local {
    my ( $self, $c, $agency_id ) = @_;
 
    $c->stash(
        agency   => $c->model('DB')->resultset('Agency')->find($agency_id),
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
