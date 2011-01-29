use strict;
use warnings;
use Filesys::Notify::Simple;

my $watcher = Filesys::Notify::Simple->new([ 'source/' ]);

while ( 1 ) {
    $watcher->wait(sub {
       system('make html');
    });
}

