#!/usr/bin/perl
############################
# This script trimm contings by a length 
# Author Arturo Vera
#
#############################

use strict;
use warnings;
@ARGV == 2 or die "Usage: perl $0 fasta_file trimmm_value\n";
my($file, $corte, $header, $long, $seq);
($file, $corte)=@ARGV;
open (ARCH, $file);
while(<ARCH>){
        chomp;
        if($_ =~ /^>/){
        $header=$_;}
        else{
                $long=length($_);
                $seq=$_;
        if($long >= $corte){
                print "$header\t$long\n$seq\n";
                }
        }
}
