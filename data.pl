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
	"I hope for nothing.\nI fear nothing.\nI am free.",
	"Why do people have\nto be this lonely?",
	"Memories need to be shared",
	"Solitude is fine",
	"It never felt right",
	"Of all sad words\nthe saddest are these\n'It might have been'",
	"Hate is too great a burden to bear",
	"We've learned to rush\nbut not to wait",
	"not only to love his enemies\nbut also to hate his friends",
	"a lack of friendship\nmakes unhappy marriages",
	"'Yes, Piglet?'\n'Nothing', said Piglet\n'I just wanted to be sure of you.'",
	"death is but the next great adventure",
	"Pity the living",
	"Death ends a life\nnot a relationship",
	"A lot of you cared\njust not enough",
	"Nobody thinks\nor feels\nor cares any more",
	"it has found no remedy\nfor the worst of them all",
	"nothing more\nthan a tiny speck",
	"Allow me to interject"
	);

my $help = "This program randomly generates SVG files.

OPTIONS
w (integer)\timage width (100)
h (integer)\timage height (100)
s (integer)\tstroke width for non-filled polygons (2)
max (integer)\tnumber of shapes (20)
fs (string)\tfont size (8)
txt (string)\tquote to insert (randomly chosen among " . scalar(@quotes) . ")
bg (string)\tbackground color (randomly chosen among " . scalar(@colors) . ")
ff (string)\tfont family (serif)
op (float)\tglobal shape opacity (1, fully opaque)\n";

sub rand_color {
	return $colors[int(rand scalar(@colors))];
}

sub rand_quote {
	return $quotes[int(rand scalar(@quotes))];
}

sub help {
	return $help;
}