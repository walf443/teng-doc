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
    $row->update({ age => \"age + 1"});
}

my $walf445 = $teng->single(user => { id => 3 });
is $walf445->age, 36;

my $walf446 = $teng->single(user => { id => 4 });
is $walf446->age, 41;

done_testing;

