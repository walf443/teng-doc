use strict;
use warnings;
use utf8;
use DBI;
use Teng;
use Teng::Schema::Loader;
use Data::Dumper;

my $dbh = DBI->connect('dbi:SQLite:', '', '', {
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
        id INT UNSIGNED NOT NULL PRIMARY KEY,
        name VARCHAR NOT NULL,
        age INT UNSIGNED NOT NULL
    )
});

# update schema info.
$schema = Teng::Schema::Loader->load(
    dbh => $dbh,
    namespace => 'MyApp::DB',
);

$teng = Teng->new(
    dbh => $dbh,
    schema => $schema,
);
