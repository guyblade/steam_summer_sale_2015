#!/usr/bin/perl -w

use strict;
use warnings;

my $left_edge_of_window = 624; # (x)
my $top_edge_of_window = 144;  # (y)

sub move_to {
	my $x = shift;
	my $y = shift;
	my $offset = shift;
	my $xoff = int(rand($offset) - $offset/2.0);
	my $yoff = int(rand($offset) - $offset/2.0);
	my $nx = $x + $xoff;
	my $ny = $y + $yoff;
	`xdotool mousemove --sync $nx $ny`
}

sub click {
	`xdotool click 1`;
}
sub respawn {
	move_to($left_edge_of_window + 955 - 624, $top_edge_of_window + 506 - 144, 2);
	click();
}
sub move_top {
	move_to($left_edge_of_window + 941 - 624, $top_edge_of_window + 219 - 144, 5);
}
sub move_bottom {
	move_to($left_edge_of_window + 950 - 624, $top_edge_of_window + 578 - 144, 5);
}
sub move_left {
	move_to($left_edge_of_window + 834 - 624, $top_edge_of_window + 535 - 144, 5);
}
sub move_right {
	move_to($left_edge_of_window + 1064 - 624, $top_edge_of_window + 535 - 144, 5);
}
sub jiggle {
 	my $xoff = int(rand(4)) - 1;
	my $yoff = int(rand(4)) - 1;
	`xdotool mousemove_relative --sync -- $xoff $yoff`
}

my $cps = 12;

sub move_random {
	my $v = rand(6);
	if ($v < 1) {
		return move_bottom();
	}
	if ($v < 2) {
		return move_left();
	}
	if ($v < 3) {
		return move_right();
	}
	return move_top();
}

while (1==1) {
	move_random();
	for(my $i = 0; $i < $cps; ++$i) {
		click();
		jiggle();
	}
	respawn();
	sleep 1;
}
