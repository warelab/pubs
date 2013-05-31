use utf8;
package WarePubs::Schema::Result::Agency;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WarePubs::Schema::Result::Agency

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<agency>

=cut

__PACKAGE__->table("agency");

=head1 ACCESSORS

=head2 agency_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 agency_name

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 url_template

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "agency_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "agency_name",
  { data_type => "char", default_value => "", is_nullable => 0, size => 255 },
  "url_template",
  { data_type => "char", default_value => "", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</agency_id>

=back

=cut

__PACKAGE__->set_primary_key("agency_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<agency_name>

=over 4

=item * L</agency_name>

=back

=cut

__PACKAGE__->add_unique_constraint("agency_name", ["agency_name"]);

=head1 RELATIONS

=head2 fundings

Type: has_many

Related object: L<WarePubs::Schema::Result::Funding>

=cut

__PACKAGE__->has_many(
  "fundings",
  "WarePubs::Schema::Result::Funding",
  { "foreign.agency_id" => "self.agency_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-05-31 15:02:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+5jaMp9nnhsP2D2tO2pY2g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
