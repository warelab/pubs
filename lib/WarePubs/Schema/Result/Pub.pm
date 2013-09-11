use utf8;
package WarePubs::Schema::Result::Pub;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WarePubs::Schema::Result::Pub

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

=head1 TABLE: C<pub>

=cut

__PACKAGE__->table("pub");

=head1 ACCESSORS

=head2 pub_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 year

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 title

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 journal

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 pubmed

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 30

=head2 authors

  data_type: 'text'
  is_nullable: 0

=head2 url

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 data

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 info_115

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 hide_from_view

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 cover

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 pdf

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 one15

  data_type: 'char'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "pub_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "year",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "title",
  { data_type => "char", default_value => "", is_nullable => 0, size => 255 },
  "journal",
  { data_type => "char", default_value => "", is_nullable => 0, size => 255 },
  "pubmed",
  { data_type => "char", default_value => "", is_nullable => 0, size => 30 },
  "authors",
  { data_type => "text", is_nullable => 0 },
  "url",
  { data_type => "char", default_value => "", is_nullable => 0, size => 255 },
  "data",
  { data_type => "char", default_value => "", is_nullable => 0, size => 255 },
  "info_115",
  { data_type => "char", default_value => "", is_nullable => 0, size => 255 },
  "hide_from_view",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "cover",
  { data_type => "char", default_value => "", is_nullable => 0, size => 255 },
  "pdf",
  { data_type => "char", default_value => "", is_nullable => 0, size => 255 },
  "one15",
  { data_type => "char", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</pub_id>

=back

=cut

__PACKAGE__->set_primary_key("pub_id");

=head1 RELATIONS

=head2 pub_to_funding

Type: might_have

Related object: L<WarePubs::Schema::Result::PubToFunding>

=cut

__PACKAGE__->might_have(
  "pub_to_funding",
  "WarePubs::Schema::Result::PubToFunding",
  { "foreign.pub_id" => "self.pub_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-11 08:48:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wTkYpq0WgqzksJWZnvUMfw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
