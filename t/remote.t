use strict;
use warnings;

use Plack::Loader;
use Test::TCP;
use Plack::Util;
use Test::More tests => 4;
use File::Basename;
use Test::Exception;
use lib 'lib';

my $app = Plack::Util::load_psgi( dirname(__FILE__) . '/../grunt.psgi' );

use_ok('Grunt::Remote');
test_tcp(
    client => sub {
        my $port = shift;
        
        # Start with an invalid action
        {
            throws_ok {
                Grunt::Remote->run(
                    port   => $port,
                    action => 'invalid_action',
                );
            }
            qr/400/, 'Throws 400 error for invalid action';
        }
        
        # Try test_simple
        {
            my $response = Grunt::Remote->run(
                port   => $port,
                action => 'test_simple',
                args   => [ 1 .. 10 ],
            );
            is( $response, <<END_RESPONSE, 'test_simple response' );
Running test_simple..
Test script called with arguments: 1 2 3 4 5 6 7 8 9 10
The end
END_RESPONSE
        }
        
        # Try test_streaming
        {
            my $response = Grunt::Remote->run(
                port   => $port,
                action => 'test_streaming',
                args   => [ 1 .. 10 ],
            );
            is( $response, <<END_RESPONSE, 'test_streaming response' );
Running test_streaming..
Test script called with arguments: 1 2 3 4 5 6 7 8 9 10
Sleeping..
And again..
The end
END_RESPONSE
        }
    },
    server => sub {
        my $port = shift;
        my $server = Plack::Loader->auto( port => $port, host => '127.0.0.1' );
        $server->run($app);
    },
);
