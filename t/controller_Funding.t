use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WarePubs';
use WarePubs::Controller::Funding;

ok( request('/funding')->is_success, 'Request should succeed' );
done_testing();
