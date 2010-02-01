package Grunt::Remote;

use strict;
use Params::Validate qw(:all);
use LWP::UserAgent;

=head1 NAME

Grunt::Remote

=head1 DESCRIPTION

Calls Grunt actions over HTTP

=head1 SYNOPSIS

Grunt::Remote->run( 
    host   => '127.0.0.1',
    port   => 5000,
    action => 'test_simple',
    args   => [ 'a' .. 'z' ]
);

=cut

sub run {
    my $class = shift;
    my %args  = validate(
        @_,
        {
            action => 1,
            port   => { default => 5000 },
            host   => { default => '127.0.0.1' },
            args   => 0,
        }
    );

    my $url = "http://$args{host}:$args{port}/run/$args{action}";
    my $response = LWP::UserAgent->new->post( $url, { args => $args{args} } );
    die $response->status_line if !$response->is_success;
    return $response->content;
}

1;
