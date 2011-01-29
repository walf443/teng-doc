use strict;
use warnings;
use Data::Dumper;

my $teng = do('source/create-teng-instance.pl')
    or die $@;

my $iter = $teng->search(user => {});
while ( my $row = $iter->next ) {
    warn Dumper($row->get_columns);
}
