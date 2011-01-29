use strict;
use warnings;
use Data::Dumper;

my $teng = do('create-teng-instance.pl')
    or die $@;

my $iter = $teng->search(user => { id => [1, 2] });
while ( my $row = $iter->next ) {
    warn Dumper($row->get_columns);
}
