use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WarePubs';
use WarePubs::Controller::PubToFunding;

ok( request('/pubtofunding')->is_success, 'Request should succeed' );
done_testing();
