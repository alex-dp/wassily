#!/usr/bin/perl

use strict;
no warnings;
use feature "switch";
use Getopt::Long;
use List::Util qw[min max];
use v5.24.0;

my @colors = ("#ef9a9a", "#ef5350", "#f44336", "#e53935", "#c62828",
		"#9fa8da", "#5c6bc0", "#3f51b5", "#3949ab", "#283593",
		"#80cbc4", "#26a69a", "#009688", "#00897b", "#00695c",
		"#a5d6a7", "#66bb6a", "#4caf50", "#43a047", "#2e7d32",
		"#fff59d", "#ffee58", "#ffeb3b", "#fdd835", "#f9a825",
		"#eeeeee", "#bdbdbd", "#9e9e9e", "#757575", "#424242");

my @quotes = ("All hope abandon, ye who enter here.",
  "While there's life there's hope, and only the dead have none.",
  "Hope, withering, fled—and Mercy sighed farewell.",
  "You burn your hopes.",
  "I hope for nothing. I fear nothing. I am free.");

my ($width, $height, $stroke, $max_shapes, $help, $fs, $txt) = (100, 100, 2, 20, '', 8, $quotes[int(rand scalar(@quotes))]);
GetOptions ("w=i" => \$width,
	"h=i" => \$height,
	"s=i" => \$stroke,
	"max=i" => \$max_shapes,
	"help" => \$help,
	"fs=s" => \$fs,
	"txt=s" => \$txt);

if (! $help eq '') {
	print "This program randomly generates SVG files.

OPTIONS
w (integer)\timage width
h (integer)\timage height
s (integer)\tstroke width for non-filled polygons
max (integer)\tmaximum number of shapes\n";

	exit();
}

main();

sub main {
	print "<?xml version='1.0'?>
	<svg width='$width' height='$height'>";

	for(1..$max_shapes) {
		print("\n", rand_shape());
	}

	print "<text width='$width' x='" . int(rand $width) / 3 .
		"' y='" . int(rand $height) / 3 .
		"' font-size='$fs' transform='rotate(10 10, " . int(rand 90) . ")'> $txt </text>";
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
				"' rx='" . int(rand $width) / 4 .
				"' ry='" . int(rand $height) / 4 . "'";
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

sub rand_color {
	return $colors[int(rand scalar(@colors))];
}