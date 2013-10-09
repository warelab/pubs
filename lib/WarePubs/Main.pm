package WarePubs::Main;
use Mojo::Base 'Mojolicious::Controller';

# ----------------------------------------------------------------------  
sub index {
    my $self = shift;

    # Render template "example/welcome.html.ep" with message
    $self->render(
        pubs     => [ $self->schema->resultset('Pub')->search()->all()     ],
        agencies => [ $self->schema->resultset('Agency')->search()->all()  ],
        funding  => [ $self->schema->resultset('Funding')->search()->all() ],
    );
}

1;
