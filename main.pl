#!/usr/bin/perl

use strict;
no warnings;
use feature "switch";
use Getopt::Long;
use List::Util qw[min max];
use v5.24.0;
require 'data.pl';

my ($width, $height, $stroke, $max_shapes, $help, $fs, $txt, $bg, $ff) =
	(100, 100, 2, 20, '', 8, rand_quote(), rand_color(), "serif");
GetOptions (
	"w=i" => \$width,
	"h=i" => \$height,
	"s=i" => \$stroke,
	"max=i" => \$max_shapes,
	"help" => \$help,
	"fs=s" => \$fs,
	"txt=s" => \$txt,
	"bg=s" => \$bg,
	"ff=s" => \$ff
	);

if (! $help eq '') {
	print help();
	exit();
}

main();

sub main {
	print "<?xml version='1.0'?>
	<svg width='$width' height='$height'>
	<rect height='$height' width='$width' fill='$bg'/>\n";
	for(1..$max_shapes) {
		print("\n", rand_shape());
	}

	my ($beg_y, $incl) = (int(rand $height) / 2, int(rand 90));
	foreach my $part (split('\n', $txt)) {
		print "<text font-family='$ff' x='" . int(rand $width) / 2 .
		"' y='$beg_y' " .
		"font-size='$fs' transform='rotate($incl " . $width / 2 . " " . $height / 2 .
		") skewX(" . (int(rand 90)-45) . ")'> $part </text>";

		$beg_y += $fs;
	}

	print "\n</svg>";
}

sub rand_shape {
	my $shape = int(rand 4);
	my $text = "";

	given ($shape) {
		when (0) {		#Rectangle
			$text = "<rect x='" . int(rand $width) .
				"' y='" . int(rand $height) .
				"' width='" . int(rand $width) / 2 .
				"' height='" . int(rand $height) / 2 . "'";
		}
		when (1) {		#Circle
			$text = "<circle cx='" . int(rand $width) .
				"' cy='" . int(rand $height) .
				"' r='" . int(rand min($width, $height)) / 4 . "'";
		}
		when (2) {		#Ellipse
			$text = "<ellipse cx='" . int(rand $width) .
				"' cy='" . int(rand $height) .
				"' rx='" . int(rand $width) / 2 .
				"' ry='" . int(rand $height) / 2 . "'";
		}
		when (3) {		#Polyline
			$text = "<polyline points='";
			for (1..int(rand 6) + 3) {
				$text = $text . int(rand $width) . " " . int(rand $height) . ", ";
			}
			$text = $text . "'";
		}
	}

	if (int(rand 2) == 0 and $shape != 3) {
		$text = $text . " fill='" . rand_color() . "'/>";
	} else {
		$text = $text . " fill='none' stroke-width='$stroke' stroke='" . rand_color() . "'/>";
	}
	return $text;
}