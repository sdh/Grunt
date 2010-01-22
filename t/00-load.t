#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Grunt' );
}

diag( "Testing Grunt $Grunt::VERSION, Perl $], $^X" );
