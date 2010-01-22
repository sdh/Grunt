# N.B. Test with an actual server via: 
#  env PLACK_TEST_IMPL=Server prove

use strict;
use warnings;

use Plack::Test;
use Plack::Util;
use Test::More;
use HTTP::Request::Common;
use File::Basename;

my $app = Plack::Util::load_psgi( dirname(__FILE__) . '/../grunt.psgi' );

test_psgi $app, sub {
    my $cb = shift;

    my $res = $cb->(GET '/run/test_simple');
    is $res->code, 200;
    like $res->content, qr/Test script called with arguments:\\n/s, 'without arguments';
};

test_psgi $app, sub {
    my $cb = shift;

    my $res = $cb->(GET '/run/test_simple?args=first&args=second');
    is $res->code, 200;
    like $res->content, qr/Test script called with arguments: first second\\n/s, 'with arguments';
};

done_testing;