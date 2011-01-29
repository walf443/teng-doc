use strict;
use warnings;
use Data::Dumper;

my $teng = do('create-teng-instance.pl')
    or die $@;

my $iter = $teng->search_named(q{
    SELECT * FROM user WHERE ( id IN :ids )
}, { ids => [1, 2] }, 'user');

while ( my $row = $iter->next ) {
    warn Dumper($row->get_columns);
}

