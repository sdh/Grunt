use Tatsumaki::Application;
use lib "../lib";
use Grunt::CmdHandler;
use Grunt::MainHandler;
use File::Basename;

my $app = Tatsumaki::Application->new(
    [
        '/run/([\w-]+)' => 'Grunt::CmdHandler',
        '/'             => 'Grunt::MainHandler',
    ]
);
$app->template_path( dirname(__FILE__) . "/templates" );
$app->static_path( dirname(__FILE__) . "/static" );
return $app;
