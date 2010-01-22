package Grunt::MainHandler;
use parent qw(Tatsumaki::Handler);

use strict;
use warnings;

sub get {
    my $self = shift;
    
    # render via the grunt.html template
    $self->render('grunt.html');
}

1;