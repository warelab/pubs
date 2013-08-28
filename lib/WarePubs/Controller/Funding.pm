package WarePubs::Controller::Funding;

use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WarePubs::Controller::Funding - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

# ----------------------------------------------------------------------
=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched WarePubs::Controller::Funding in Funding.');
}

# ----------------------------------------------------------------------
=head2 create_form
 
Show create form.
 
=cut
 
sub create_form :Local {
    my ( $self, $c ) = @_;
 
    $c->stash(
        agencies => [ $c->model('DB')->resultset('Agency')->all ],
        template => 'funding-create-form.tmpl'
    );
}
# ----------------------------------------------------------------------
=head2 list
 
Fetch all fundings.
 
=cut
 
sub list :Local {
    my ($self, $c) = @_;
    my $fundings   = $c->model('DB')->resultset('Funding')->search(
        undef,
        { order_by => { '-asc' => 'title' } }
    );

    $c->stash(
        fundings => $fundings,
        template => 'funding-list.tmpl',
        #current_view => 'JSON',
    );
}

# ----------------------------------------------------------------------
=head2 view
 
Detail for a single funding.
 
=cut
 
sub view :Local {
    my ( $self, $c, $funding_id ) = @_;
 
    $c->stash(
        funding  => $c->model('DB')->resultset('Funding')->find($funding_id),
        template => 'funding-view.tmpl'
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
