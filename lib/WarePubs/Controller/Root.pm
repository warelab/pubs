package WarePubs::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(
    namespace    => '',
    json_options => { relaxed => 1 },
);

=head1 NAME

WarePubs::Controller::Root - Root Controller for WarePubs

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

# ---------------------------------------------------------------------- 
=head2 info

info

=cut

sub info :Path :Args(0) {
    my ( $self, $c ) = @_;

    $self->status_ok( 
        $c, 
        entity => { info => 'stuff' } 
    );
}

# ---------------------------------------------------------------------- 
=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash( 
        agencies => [ $c->model('DB::Agency')->all ],
        fundings => [ $c->model('DB::Funding')->all ],
        pubs     => [ $c->model('DB::Pub')->all ],
        template => 'index.tmpl' 
    );
}

# ---------------------------------------------------------------------- 
=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->stash(
        template => '404.tmpl',
    );
    $c->response->status(404);

#    $c->response->body( 'Page not found' );
#    $c->response->status(404);
}

# ---------------------------------------------------------------------- 
=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

#sub end : ActionClass('RenderView') {
#    my ( $self, $c ) = @_;
#
#    if ( $c->req->param('output') eq 'json' ) {
#        $c->forward('WarePubs::View::JSON');
#    }
#    else {
#        $c->forward('WarePubs::View::HTML');
#    }
#}

# ---------------------------------------------------------------------- 
=head1 AUTHOR

Ken Youens-Clark

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
