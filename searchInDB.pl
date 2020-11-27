#!/usr/bin/perl

##################################
## install DBI and mysql by doing:
##################################
# sudo apt-get install libdbd-mysql-perl
# perl -MCPAN -e shell
#and then...
# install DBI

use strict;
use open qw(:std :utf8);

use DBI;

my $db_host  = '127.0.0.1';
my $db       = 'commerce';
my $db_user  = 'root';
my $db_pass  = 'admin';

my $term=$ARGV[0];
print "searching for $term...\n-------------------\n";
my $search    = qr/$term/;


# https://metacpan.org/pod/DBD::mysql
my $dbh = DBI->connect( "dbi:mysql:dbname=$db;host=$db_host", $db_user, $db_pass,
                        { mysql_enable_utf8mb4 => 1 }
) or die "Can't connect: $DBI::errstr\n";


foreach my $table ( $dbh->tables() ) {
    my $sth = $dbh->prepare("SELECT * FROM $table") or die "Can't prepare: ", $dbh->errstr;

    $sth->execute or die "Can't execute: ", $sth->errstr;

    my @results;

    while (my @row = $sth->fetchrow()) {
        local $_ = join("\t", @row);
        if ( /$search/ ) {
            push @results, $_;
        }
    }

    $sth->finish;

    next unless @results;

    print "*** TABLE $table :\n",
          join("\n---------------\n", @results),
          "\n" . "=" x 20 . "\n";
}

$dbh->disconnect;
