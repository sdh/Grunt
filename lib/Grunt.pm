package Grunt;

use warnings;
use strict;

=head1 NAME

Grunt - Plack based webapp for running scripts via a web service

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 DESCRIPTION

Grunt is built using the Tatsumaki web application framework which supports
non-blocking I/O through psgi.streaming and psgi.nonblocking, non-blocking HTTP clients, 
long-poll Comet services and server push.

=head1 SYNOPSIS

 sudo plackup -s AnyEvent -a grunt.psgi

=head1 ACTIONS

Actions are executables inside the bin directory, named <action>.grunt

=head1 USAGE

A web request to:

 /run/test

..will execute bin/test.grunt and return all command output via multipart XHR.

Pass script arguments as query params, e.g. a web request to:

 /run/test?args=first&args=second

..will execute "bin/test.grun first second"

=head1 AUTHOR

Patrick Donelan, C<< <pat at patspam.com> >>

=head1 SEE ALSO

http://github.com/sdh/Grunt

=head1 COPYRIGHT & LICENSE

Copyright 2010 Patrick Donelan.

=cut

1;