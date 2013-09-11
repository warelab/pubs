package WarePubs::Controller::PubToFunding;

use Moose;
use Params::Validate qw(:all);
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WarePubs::Controller::PubToFunding - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

# ----------------------------------------------------------------------

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched WarePubs::Controller::PubToFunding in PubToFunding.');
}

# ----------------------------------------------------------------------
=head2 create
 
Create.
 
=cut
 
sub create :Local {
    my ( $self, $c ) = @_;

    my %required = (
        pub_id     => { regex => qr/^\d+$/ },
        funding_id => { regex => qr/^\d+$/ },
    );

    my $req = $c->req;
    my @params = map { $_, $req->param($_) || '' } keys %required;

    validate( @params, \%required );

    my $PubToFunding = $c->model('DB')->resultset('PubToFunding')->create({
        pub_id       => $req->param('pub_id'),
        funding_id   => $req->param('funding_id'),
    });

    $c->res->redirect( $c->uri_for('/pub/view', $req->param('pub_id') ) );
}

# ----------------------------------------------------------------------
=head2 create_form
 
Show create form.
 
=cut
 
sub create_form :Local {
    my ( $self, $c ) = @_;
    my $req = $c->req;

    my $Pub;
    if ( my $pub_id = $req->param('pub_id') ) {
        $Pub = $c->model('DB')->resultset('Pub')->find($pub_id);
    }
 
    my $Fundings = $c->model('DB')->resultset('Funding')->search(
        undef,
        { order_by => { '-asc' => 'title' } }
    );

    $c->stash(
        pub      => $Pub,
        fundings => $Fundings,
        template => 'pub-to-funding-create-form.tmpl'
    );
}

# ----------------------------------------------------------------------
=head2 create
 
Create.
 
=cut
 
sub delete :Local {
    my ( $self, $c, $pub_to_funding_id ) = @_;

    my $req        = $c->req;
    my $pub_id     = $req->param('pub_id');
    my $funding_id = $req->param('funding_id');

    my $PF;
    if ( $pub_to_funding_id ) {
        $PF = $c->model('DB')->resultset('PubToFunding')->find(
            $pub_to_funding_id
        ) or die "Can't find pub_to_funding id '$pub_to_funding_id'";;
    } 
    else {
        $PF = $c->model('DB')->resultset('PubToFunding')->search({
            pub_id     => $pub_id,
            funding_id => $funding_id,
        }) or 
        die "Can't find pub_to_funding for pub '$pub_id' funding '$funding_id'";
    }

    $pub_id ||= $PF->pub_id;

    $PF->delete;

    $c->res->redirect( $c->uri_for('/pub/view', $pub_id ) );
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
