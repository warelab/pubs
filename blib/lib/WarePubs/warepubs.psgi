use strict;
use warnings;

use WarePubs;

my $app = WarePubs->apply_default_middlewares(WarePubs->psgi_app);
$app;

