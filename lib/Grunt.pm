package Grunt;

# ABSTRACT: Plack based webapp for running scripts via a web service

1;

__END__

=head1 DESCRIPTION

Grunt is built using the Tatsumaki web application framework which supports
non-blocking I/O through psgi.streaming and psgi.nonblocking, non-blocking HTTP clients, 
long-poll Comet services and server push.

=head1 SYNOPSIS

 sudo plackup -s AnyEvent -a grunt.psgi

=head1 ACTIONS

Actions are executables inside the gruntbin directory, named <action>.grunt

=head1 USAGE

A web request to:

 /run/test

..will execute gruntbin/test.grunt and return all command output via multipart XHR.

Pass script arguments as query params, e.g. a web request to:

 /run/test?args=first&args=second

..will execute "gruntbin/test.grun first second"

=cut
