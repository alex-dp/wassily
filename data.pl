use strict;

my @colors = (
	"#ef9a9a", "#ef5350", "#f44336", "#e53935", "#c62828",
	"#9fa8da", "#5c6bc0", "#3f51b5", "#3949ab", "#283593",
	"#80cbc4", "#26a69a", "#009688", "#00897b", "#00695c",
	"#a5d6a7", "#66bb6a", "#4caf50", "#43a047", "#2e7d32",
	"#fff59d", "#ffee58", "#ffeb3b", "#fdd835", "#f9a825",
	"#eeeeee", "#bdbdbd", "#9e9e9e", "#757575", "#424242"
	);

my @quotes = (
	"All hope abandon,\nye who enter here.",
	"While there's life there's hope,\nand only the dead have none.",
	"Hope, withering, fled\nand Mercy sighed farewell.",
	"You burn your hopes.",
	"I hope for nothing.\nI fear nothing.\nI am free."
	);

my $help = "This program randomly generates SVG files.

OPTIONS
w (integer)\timage width
h (integer)\timage height
s (integer)\tstroke width for non-filled polygons
max (integer)\tnumber of shapes
fs (string)\tfont size
txt (string)\tquote to insert
bg (string)\tbackground color
ff (string)\tfont family\n";

sub rand_color {
	return $colors[int(rand scalar(@colors))];
}

sub rand_quote {
	return $quotes[int(rand scalar(@quotes))];
}

sub help {
	return $help;
}