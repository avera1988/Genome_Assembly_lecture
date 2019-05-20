#!/usr/bin/perl -w 
use strict;
use warnings;

###################################################################
#This program caculates the coverage from spades contigs
#Needs, contigs in one lane and it prints the coverage of each contig and the sequence
#Also it prints a coverage.txt file with the coverage for each contig
#Author: Arturo Vera
#v.1
#06/13/17
#v.2
#May_2019
##########################################################################################


my(@header, $id,$lon, $count, $rounded, $cover, $seq,@coverage);
(my $contigs)=@ARGV;
open (ARCH, $contigs);
#open(FASTA,">$contigs.mod.fasta");
open (COVERAGE, ">$contigs.coverage.txt");
while(<ARCH>){
	chomp; 
	if($_ =~ /^>/){
	 @header=split(/\_/);
	$id= $header[0] =~ s/\>//gr;
	$cover=$header[5];
	$rounded = sprintf("%.3f", $cover);
	#print "$id\_$header[1]\t$rounded\n";
	push(@coverage,$rounded);
	#print COVER "@coverage\n";
  	 print COVERAGE "$id\_$header[1]\t$rounded\n";
   		#print FASTA "$header[0]_$rounded\n$seq\n";
      }
}
my $coverage;
my $acc = 0;
foreach (@coverage){
  $acc += $_;
}
my $len=@coverage;
my $cover_mean =$acc/$len;
my $cover_mean_round =sprintf("%.3f", $cover_mean);
print "$contigs coverage=\t$cover_mean_round\n";
