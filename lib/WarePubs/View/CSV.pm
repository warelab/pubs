package WarePubs::View::CSV;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::Download::CSV';

sub process {
    my ( $self, $c ) = @_;

    if ( $c->stash->{'format'} eq 'tab' ) {
        $c->res->headers->header( 
            'Content-Type' => 'text/tab-separated-values'
        );
    }

    if ( my $filename = $c->stash->{'filename'} ) {
        $c->res->header( 
            'Content-Disposition' => qq(attachment; filename="$filename")
        );
    }

    $self->SUPER::process( $c );
}

sub render {
    my ( $self, $c, $template, $args ) = @_;
     
    if ( $c->stash->{'format'} eq 'tab' ) {
        $self->config->{'sep_char'} = "\t";
    }
         
    $self->SUPER::render($c, $template, $args);
}

=head1 NAME

WarePubs::View::CSV - Catalyst View

=head1 DESCRIPTION

Catalyst View.

=head1 AUTHOR

Ken Youens-Clark

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
