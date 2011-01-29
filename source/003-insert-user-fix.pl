use strict;
use warnings;
use utf8;
use DBI;

my $teng = do('source/create-teng-instance.pl')
    or die $@;

my $row = $teng->insert(user => {
    id => 1,
    name => 'walf443',
    age  => 26,
});

warn Dumper($row->get_columns);

my $last_insert_id = $teng->fast_insert(user => {
    id => 2,
    name => 'walf444',
    age  => 30,
});

warn $last_insert_id;

