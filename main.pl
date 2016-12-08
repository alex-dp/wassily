#!/usr/bin/perl

use strict;
no warnings;				#output goes to stdout
use feature "switch";
use Getopt::Long;
use List::Util qw[min max];
use v5.21.1;
require 'data.pl';

my ($width, $height, $stroke, $max_shapes, $help, $fs, $txt, $bg, $ff, $op) =
	(100, 100, 2, 20, '', 8, rand_quote(), rand_color(), "serif", 1.0);
GetOptions (
	"w=i" => \$width,
	"h=i" => \$height,
	"s=i" => \$stroke,
	"max=i" => \$max_shapes,
	"help" => \$help,
	"fs=i" => \$fs,
	"txt=s" => \$txt,
	"bg=s" => \$bg,
	"ff=s" => \$ff,
	"op=f" => \$op
	);

if (! $help eq '') {
	print help();
	exit();
}

main();

sub main {
	print "<?xml version='1.0'?>
<svg width='$width' height='$height'>
\t<rect height='$height' width='$width' fill='$bg'/>\n";
	for(1..$max_shapes) {
		print("\n\t", rand_shape());
	}

	my ($beg_y, $incl) = (randy() / 2, int(rand 90));
	foreach my $part (split('\n', $txt)) {
		print "\n\t<text font-family='$ff' x='" . randx() / 2 .
		"' y='$beg_y' " .
		"font-size='$fs' transform='rotate($incl " . $width / 2 . " " . $height / 2 .
		") skewX(" . (int(rand 90)-45) . ")'> $part </text>";

		$beg_y += $fs;
	}

	print "\n</svg>";
}

sub rand_shape {
	my $shape = int(rand 5);
	my $text = "";

	given ($shape) {
		when (0) {		#Rectangle
			$text = "<rect x='" . randx() .
				"' y='" . randy() .
				"' width='" . randx() / 2 .
				"' height='" . randy() / 2 . "'";
		}
		when (1) {		#Circle
			$text = "<circle cx='" . randx() .
				"' cy='" . randy() .
				"' r='" . int(rand min($width, $height)) / 4 . "'";
		}
		when (2) {		#Ellipse
			$text = "<ellipse cx='" . randx() .
				"' cy='" . randy() .
				"' rx='" . randx() / 2 .
				"' ry='" . randy() / 2 . "'";
		}
		when (3) {		#Polyline, made as a straight path
			$text = "<path d='M ";
			for my $i (1..int(rand 6) + 3) {
				if ($i != 1) { $text .= "L "; }
				$text .= randx() . " " . randy() . " ";
			}
			$text .= "'";
		}
		when (4) {		#Curve path
			$text = "<path d='M " . randx() . " " . randy();
			for (1..int rand 4) {
				$text .= " Q";
				for (1..2) {
					$text .= " " . randx() . " " . randy();
				}
			}
			$text .= "'";
		}
	}

	if (int(rand 3) == 0 and $shape < 3) {
		$text .= " fill='" . rand_color() . "' fill-opacity='$op'/>";
	} else {
		$text .= " fill='none' stroke-width='$stroke' stroke='" . rand_color() . "' stroke-opacity='$op'/>";
	}
	return $text;
}

sub randx {
	return int(rand $width);
}

sub randy {
	return int(rand $height);
}