#!/usr/bin/env perl

use strict;
use warnings;
use DBI;
use Text::RecordParser::Tab;

my $file    = shift or die 'No file';
my $db_name = shift or die 'No db name';
my $p       = Text::RecordParser::Tab->new( $file );
my $db      = DBI->connect(
    "dbi:mysql:$db_name", 'kclark', 'g0p3rl!',
    { RaiseError => 1 }
);

my @flds = qw(
    year authors title journal pubmed url data_path
    cover pdf comments hide_from_view
);

my $sql  = sprintf( 
    'insert into pub (%s) values (%s)',
    join( ', ', @flds),
    join( ', ', map { '?' } @flds ),
);

while ( my $rec = $p->fetchrow_hashref ) {
    $db->do( $sql, {}, ( map { $rec->{ $_ } || '' } @flds ) );
}

$db->do(
    q[
        insert into pub_to_funding (pub_id, funding_id) 
        select pub_id, '1' from pub
    ]
);

print "Done.\n";
