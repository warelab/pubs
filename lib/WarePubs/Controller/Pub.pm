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
        template => 'pub-create-form.tmpl'
    );
}

# ----------------------------------------------------------------------
=head2 list
 
Fetch all pubs.
 
=cut
 
sub list :Local {
    my ($self, $c) = @_;
 
    $c->stash(
        pubs     => [ $c->model('DB::Pub')->all ],
        template => 'pub-list.tmpl',
    );
}

# ----------------------------------------------------------------------
=head2 update
 
Update the pub.
 
=cut
 
sub update :Local {
    my ( $self, $c ) = @_;

    my $pub_id  = $c->request->params->{'pub_id'}  or die 'No pub_id';
    my $title   = $c->request->params->{'title'}   or die 'No title';
    my $journal = $c->request->params->{'journal'} or die 'No journal';
    my $pub     = $c->model('DB')->resultset('Pub')->find($pub_id)
                  or die "Can't find pub '$pub_id'\n";
 
    $pub->update(
        title   => $title,
        journal => $journal,
    );

    $c->forward( $c->uri_for('/pub/view', $pub->id ) );
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
