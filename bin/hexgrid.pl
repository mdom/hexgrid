#!/usr/bin/perl

use strict;
use warnings;

my ( $width, $height ) = @ARGV;

my @shapes = map { [ split( '', $_ ) ] } ' __ ', '/  \\', '\\__/';

sub draw_hex {
    my ( $grid, $y, $x, $up ) = @_;
    while ( my ( $row, $shape ) = each @shapes ) {
        while ( my ( $idx, $char ) = each $shape ) {
            next if $grid->[ $y + $row - $up ]->[ $x + $idx ] ne ' ';
            $grid->[ $y + $row - $up ]->[ $x + $idx ] = $char;
        }
    }
    return;
}

sub print_array {
    my $array = shift;
    for my $row (@$array) {
        print join( '', @$row ) . "\n";
    }
    return;
}

my $array =
  [ map { [ split( '', ' ' x ( $width * 3 + 1 ) ) ] } 0 .. $height * 3 ];

my ( $y, $x, $up ) = ( 1, 0, 0 );
for ( 1 .. $height ) {
    for ( 1 .. $width ) {
        draw_hex( $array, $y, $x, $up );
        $x += 3;
        $up = !$up;
    }
    $y += 2;
    $x = 0;
}

print_array($array);

