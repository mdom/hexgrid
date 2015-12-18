#!/usr/bin/perl

use strict;
use warnings;

my ( $width, $height ) = @ARGV;

my @shapes = map { [split('',$_)] } ' __ ', '/  \\', '\\__/';

sub draw_hex {
    my ( $grid, $y, $x, $up ) = @_;
    for my $i ( 0 .. 2 ) {
        while ( my ( $idx, $char ) = each $shapes[$i] ) {
            next if $grid->[ $y + $i - $up ]->[ $x + $idx ] ne ' ';
            $grid->[ $y + $i - $up ]->[ $x + $idx ] = $char;
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

my $array = [ map { [ split('', ' ' x ($width*3+1) ) ] } 0 .. $height*3 ];

my ( $y, $x, $up ) = ( 1, 0, 0 );
for ( 1 .. $height ) {
    for ( 1 .. $width ) {
        $up = $up ? 0 : 1;
        draw_hex( $array, $y, $x, $up );
        $x += 3;
    }
    $x = 0;
    $y += 2;
    $up = 0
}

    print_array( $array );

