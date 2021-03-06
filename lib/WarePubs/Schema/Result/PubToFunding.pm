use utf8;
package WarePubs::Schema::Result::PubToFunding;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WarePubs::Schema::Result::PubToFunding

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

=head1 TABLE: C<pub_to_funding>

=cut

__PACKAGE__->table("pub_to_funding");

=head1 ACCESSORS

=head2 pub_to_funding_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'integer'
  default_value: 1
  is_foreign_key: 1
  is_nullable: 0

=head2 funding_id

  data_type: 'integer'
  default_value: 1
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "pub_to_funding_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "pub_id",
  {
    data_type      => "integer",
    default_value  => 1,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "funding_id",
  {
    data_type      => "integer",
    default_value  => 1,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</pub_to_funding_id>

=back

=cut

__PACKAGE__->set_primary_key("pub_to_funding_id");

=head1 RELATIONS

=head2 funding

Type: belongs_to

Related object: L<WarePubs::Schema::Result::Funding>

=cut

__PACKAGE__->belongs_to(
  "funding",
  "WarePubs::Schema::Result::Funding",
  { funding_id => "funding_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 pub

Type: belongs_to

Related object: L<WarePubs::Schema::Result::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "WarePubs::Schema::Result::Pub",
  { pub_id => "pub_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-11 13:43:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3tPsHrp4VNBf50rxY5O96Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
