#!/usr/bin/perl -w
###############################################################################################
#This script converts multifasta to one line header and one line sequence multifasta
#Author: Alejandro Sanchez-Flores
###############################################################################################

use strict;
my $flag = 0;

while (<>) {
	#print; <STDIN>;
	chomp;
	if (/^>/) {
		
		if ($flag) {
			print "\n";
			$flag = 0;
		}
		my $id = $_; 
		print "$id\n";
		$flag = 1;
		next;
	}
	tr/a-z/A-Z/;
	print;
}
