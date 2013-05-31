use utf8;
package WarePubs::Schema::Result::Funding;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WarePubs::Schema::Result::Funding

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

=head1 TABLE: C<funding>

=cut

__PACKAGE__->table("funding");

=head1 ACCESSORS

=head2 funding_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 agency_id

  data_type: 'integer'
  default_value: 1
  is_foreign_key: 1
  is_nullable: 0

=head2 award_number

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 title

  data_type: 'text'
  is_nullable: 1

=head2 abstract

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "funding_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "agency_id",
  {
    data_type      => "integer",
    default_value  => 1,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "award_number",
  { data_type => "char", default_value => "", is_nullable => 0, size => 255 },
  "title",
  { data_type => "text", is_nullable => 1 },
  "abstract",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</funding_id>

=back

=cut

__PACKAGE__->set_primary_key("funding_id");

=head1 RELATIONS

=head2 agency

Type: belongs_to

Related object: L<WarePubs::Schema::Result::Agency>

=cut

__PACKAGE__->belongs_to(
  "agency",
  "WarePubs::Schema::Result::Agency",
  { agency_id => "agency_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 pubs

Type: has_many

Related object: L<WarePubs::Schema::Result::Pub>

=cut

__PACKAGE__->has_many(
  "pubs",
  "WarePubs::Schema::Result::Pub",
  { "foreign.funding_id" => "self.funding_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-05-31 15:02:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8N2NvmBAynMKp8atkxO0PQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
