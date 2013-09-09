package WarePubs::View::CSV;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::Download::CSV';

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
