#!/usr/bin/perl -w

use strict;
use warnings;
 use Time::HiRes qw( usleep );

my $left_edge_of_window = 627; # (x)
my $top_edge_of_window = 230;  # (y)
my $cps = 24;


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
	move_to($left_edge_of_window + 941 - 624, $top_edge_of_window + 450 - 230, 5);
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

sub choose_lane_one {
	move_to($left_edge_of_window + 1333 - 627, $top_edge_of_window + 276 - 230, 1);
	click();
}
sub choose_lane_two {
	move_to($left_edge_of_window + 1435 - 627, $top_edge_of_window + 270 - 230, 1);
	click();
}
sub choose_lane_three {
	move_to($left_edge_of_window + 1537 - 627, $top_edge_of_window + 270 - 230, 1);
	click();
}

sub jiggle {
 	my $xoff = int(rand(3)) - 1;
	my $yoff = int(rand(3)) - 1;
	`xdotool mousemove_relative --sync -- $xoff $yoff`
}

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

sub random_lane {
	my $v = rand(3);
	if ($v < 1) {
		return choose_lane_one();
	}
	if ($v < 2) {
		return choose_lane_two();
	}
	return choose_lane_three();
}

my $cnt = 0;

while (1==1) {
	$cnt++;
	if($cnt % 60 == 0)  {
		# Give a chance to alt tab and kill the script
		random_lane();
		move_to(100, 100, 0);
		sleep(10);
	}
	if($cnt % 5 == 0 || $cnt == 1) {
		respawn();
		usleep(1e6);

		move_left();
		click();
		usleep(1e6);

		move_bottom();
		click();
		usleep(1e6);

		move_right();
		click();
		usleep(1e6);

		move_top();
	}
	for(my $i = 0; $i < $cps; ++$i) {
		click();
		jiggle() if $i % 3 == 0;
		usleep(1e6 / $cps);
	}
}
