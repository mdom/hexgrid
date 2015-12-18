#!/usr/bin/perl

use strict;
use warnings;

my ( $width, $height ) = @ARGV;

my @shapes = ( ' __ ', '/  \\', '\\__/' );

sub draw_hex {
    my ( $grid, $y, $x, $up ) = @_;
    for my $i ( 0 .. 2 ) {
        my @chars = split '', $shapes[$i];
        while ( my ( $idx, $char ) = each @chars ) {
            my $value = $grid->[ $y + $i - $up ]->[ $x + $idx ];
            next if defined $value and $value ne ' ';
            $grid->[ $y + $i - $up ]->[ $x + $idx ] = $char;
        }
    }
    return;
}

sub print_array {
    my $array = shift;
    for my $row (@$array) {
        print join( '', map { defined($_) ? $_ : ' ' } @$row ) . "\n";
    }
    return;
}

my @array;

my ( $y, $x, $up ) = ( 1, 0, 0 );
for ( 1 .. $height ) {
    for ( 1 .. $width ) {
        draw_hex( \@array, $y, $x, $up );
        $up = $up ? 0 : 1;
        $x += 3;
    }
    $x = 0;
    $y += 2;
    $up = 0
}

    print_array( \@array );

