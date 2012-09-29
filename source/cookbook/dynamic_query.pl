use strict;
use warnings;
use Data::Dumper;
use Test::More;

my %condition = @ARGV;

my $teng = do('setup_teng_instance.pl')
    or die $@;

my $builder = $teng->sql_builder->new_select;
isa_ok($builder, "SQL::Maker::Select");

$builder->add_from('user');
if ( $condition{name} ) {
    $builder->add_where(name => $condition{name});
}

if ( $condition{age} ) {
    $builder->add_where(age => $condition{age});
}

$builder->add_select('*');
my $iter = $teng->search_by_sql($builder->as_sql, [ $builder->bind ]);
my $sql = $builder->as_sql;
$sql =~ s/\n/ /g;
note q{SQL: "} . $sql . q{"};
note "BIND: " . join ', ', $builder->bind;

done_testing();
