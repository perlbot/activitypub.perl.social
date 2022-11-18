#!/usr/bin/env perl

use strict;
use warnings;
use YAML ();

my $conf = YAML::LoadFile("config.yaml.tmpl");

$conf->{"db-type"} = $ENV{GTS_DB_TYPE};
$conf->{"db-address"} = $ENV{GTS_DB_ADDRESS};
$conf->{"db-port"} = $ENV{GTS_DB_PORT};
$conf->{"db-user"} = $ENV{GTS_DB_USER};
$conf->{"db-password"} = $ENV{GTS_DB_PASSWORD};
$conf->{"db-database"} = $ENV{GTS_DB_DATABASE};

YAML::DumpFile("config.yaml");

