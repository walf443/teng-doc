use strict;
use warnings;
use utf8;
use DBI;

my $teng = do('source/create-teng-instance.pl');

my $row = $teng->insert(user => {
    id => 1,
    name => 'walf443',
    age  => 26,
});

warn Dumper($row->get_columns);

