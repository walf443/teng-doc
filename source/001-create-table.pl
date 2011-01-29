use strict;
use warnings;
use utf8;
use DBI;
use Teng;
use Teng::Schema::Loader;

my $dbh = DBI->connect('dbi:SQLite:quickstart.sqlite', '', '', {
    RaiseError => 1,
    PrintError => 0,
    AutoCommit => 1,
    sqlite_unicode => 1,
});

my $schema = Teng::Schema::Loader->load(
    dbh => $dbh,
    namespace => 'MyApp::DB',
);

my $teng = Teng->new(
    dbh => $dbh,
    schema => $schema,
);

$teng->do(q{
    CREATE TABLE user (
        id INT UNSIGNED NOT NULL,
        name VARCHAR NOT NULL,
        age INT UNSIGNED NOT NULL
    )
});

