use strict;
use warnings;
use DBI;
use Teng;
use Teng::Schema::Loader;
use Data::Dumper;

my $dbh = DBI->connect('dbi:SQLite:quickstart.sqlite', '', '', {
    RaiseError => 1,
    PrintError => 0,
    AutoCommit => 1,
});

my $schema = Teng::Schema::Loader->load(
    dbh => $dbh,
    namespace => 'MyApp::DB',
);

my $teng = Teng->new(
    dbh => $dbh,
    schema => $schema,
);

my $row = $teng->insert(user => {
    id => 1,
    name => 'walf443',
    age  => 26,
});

warn Dumper($row->get_columns);

