package WarePubs::Main;
use Mojo::Base 'Mojolicious::Controller';

# ----------------------------------------------------------------------
sub index {
    my $self = shift;

    # Render template "example/welcome.html.tt" with message
    $self->render();
}

1;
