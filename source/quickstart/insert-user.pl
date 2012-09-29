use strict;
use warnings;
use utf8;
use DBI;
use Teng;
use Teng::Schema::Loader;
use Data::Dumper;

my $dbh = DBI->connect('dbi:SQLite:quickstart.sqlite', '', '', {
    RaiseError => 1,
    PrintError => 0,
    AutoCommit => 1,
    sqlite_unicode => 1,
});

my $teng = Teng::Schema::Loader->load(
    dbh => $dbh,
    namespace => 'MyApp::DB',
);

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

