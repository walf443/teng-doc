use strict;
use warnings;
use DBI;

my $teng = do('source/create-teng-instanse.pl');

my $row = $teng->insert(user => {
    id => 1,
    name => 'walf443',
    age  => 26,
});

warn Dumper($row);

