package WarePubs::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tmpl',
    render_die => 1,
    # Set the location for TT files
    INCLUDE_PATH => [ WarePubs->path_to( qw/ root templates / ) ],
    # Set to 1 for detailed timer stats in your HTML as comments
    TIMER              => 0,
    # This is your wrapper template located in the 'root/src'
    WRAPPER => 'wrapper.tmpl',
);

=head1 NAME

WarePubs::View::HTML - TT View for WarePubs

=head1 DESCRIPTION

TT View for WarePubs.

=head1 SEE ALSO

L<WarePubs>

=head1 AUTHOR

Ken Youens-Clark

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
