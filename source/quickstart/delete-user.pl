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

my $deleted_num_of_rows = $teng->delete(user => { id => [3, 4] });
is $deleted_num_of_rows => 2, 'deleted_num_of_rows should be 2';

done_testing;

