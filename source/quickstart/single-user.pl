use strict;
use warnings;
use Data::Dumper;

my $teng = do('create-teng-instance.pl')
    or die $@;

my $user = $teng->single(user => { id => 1 });
warn Dumper($user->get_columns);
