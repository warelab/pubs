use strict;
use warnings;
use FindBin '$Bin';

use lib "$Bin/lib";
use WarePubs;

my $app = WarePubs->apply_default_middlewares(WarePubs->psgi_app);
$app;

