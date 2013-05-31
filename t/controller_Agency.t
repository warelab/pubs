use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WarePubs';
use WarePubs::Controller::Agency;

ok( request('/agency')->is_success, 'Request should succeed' );
done_testing();
