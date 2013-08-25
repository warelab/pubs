#!/usr/bin/env perl

use strict;
use warnings;
use DBI;
use Text::RecordParser::Tab;

my $file = shift or die 'No file';
my $p    = Text::RecordParser::Tab->new( $file );
my $db   = DBI->connect('dbi:mysql:warelab_pubs', 'kclark', 'g0p3rl!',
            {RaiseError => 1});
my @flds = qw(
    year authors title journal pubmed url data 
    cover pdf info_115 hide_from_view
);

my $sql  = sprintf( 
    'insert into pub (%s) values (%s)',
    join( ', ', @flds),
    join( ', ', map { '?' } @flds ),
);

while ( my $rec = $p->fetchrow_hashref ) {
    $db->do( $sql, {}, ( map { $rec->{ $_ } || '' } @flds ) );
}

print "Done.\n";
