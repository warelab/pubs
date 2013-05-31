use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WarePubs';
use WarePubs::Controller::Pub;

ok( request('/pub')->is_success, 'Request should succeed' );
done_testing();
