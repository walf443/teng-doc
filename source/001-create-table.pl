use strict;
use warnings;
use DBI;
use Teng;

my $dbh = DBI->connect('dbi:SQLite:quickstart.sqlite', '', '', { 
    RaiseError => 1,
    PrintError => 0,
    AutoCommit => 1,
});

$dbh->do(q{
    CREATE TABLE user (
        id INT UNSIGNED NOT NULL,
        name VARCHAR NOT NULL,
        age INT UNSIGNED NOT NULL
    )
});

