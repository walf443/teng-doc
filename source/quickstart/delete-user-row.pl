use strict;
use warnings;
use Data::Dumper;
use Test::More;

my $teng = do('create-teng-instance.pl')
    or die $@;

$teng->fast_insert(user => {
    id => 3,
    name => 'walf445',
    age  => 35,
});

$teng->fast_insert(user => {
    id => 4,
    name => 'walf446',
    age  => 40,
});

my $iter = $teng->search(user => {
    id => [3, 4],
});

while ( my $row = $iter->next ) {
    $row->delete;
}

