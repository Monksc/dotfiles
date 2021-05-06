#!/usr/local/bin/perl

use Time::Piece;

$num_args = $#ARGV + 1;
if (!($num_args == 3 || $num_args == 4)) {
    print "Usage dateconverter <date> <dateformat> <newformat> [hoursdiferance]\n";
    exit;
}

$hoursdif -4;
if ($num_args == 4) {
    $hoursdif = $ARGV[3];
}

my $dt = Time::Piece->strptime($ARGV[0], $ARGV[1]);
$dt += $hoursdif * 60 * 60;
print $dt->strftime($ARGV[2]);
