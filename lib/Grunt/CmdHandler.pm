package Grunt::CmdHandler;
use strict;
use warnings;

use parent qw(Tatsumaki::Handler);
use Tatsumaki::Error;
use AnyEvent::Run;
use File::Basename;

__PACKAGE__->asynchronous(1);

# Figure out where the grunt scripts live - this will probably
# need to change for production
my $BIN = dirname(__FILE__) . '/../../bin';

sub get {
    my ( $self, $action ) = @_;
    my @args = $self->request->param('args');

    my $cmd = "$BIN/$action.grunt";
    if (-x $cmd) {
        $self->multipart_xhr_push(1);
        $self->stream_write( { msg => "Running $action.." } );
        $self->run_cmd([$cmd, @args]);
    } else {
        $self->log("Executable not found: $cmd");
        Tatsumaki::Error::HTTP->throw(400, "Unsupported action: $action");
    }
}

# Can't set headers after mxhr started, so just send error message and close the connection
sub error {
    my ($self, $msg) = @_;
    $self->stream_write( { msg => $msg } );
    $self->finish;
}

my $keeper;

sub run_cmd {
    my ( $self, $cmd ) = @_;

    # Note that process ends as soon as AnyEvent::Run object goes out of scope, hence $keeper
    $keeper = AnyEvent::Run->new(
        cmd     => $cmd,
        on_read => $self->async_cb(
            sub {
                my $handle = shift;
                my $text   = $handle->rbuf;
                chomp($text);
                $handle->rbuf = q{};

                # $self->log($text);
                $self->stream_write( { msg => $text } );
            }
        ),
        on_error => $self->async_cb(
            sub {
                my ( $handle, $fatal, $msg ) = @_;
                $self->log( $msg );
                $self->finish;
            }
        ),
    );
}

1;
