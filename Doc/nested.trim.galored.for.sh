#!/bin/bash

#Create a variable of acutal directory
dir=$(pwd)

for i in *1.fastq
	do
	#Getting file name
	name=$(echo $i|cut -d . -f 1|sed 's/_[[:digit:]]//g');
	#Creating a directory for each sample 
	mkdir $name
	#Entering into the directory
	cd $name
	#Generating symbolic links to each file
	ln -s ../$name*fastq .
	#Running the nested for using trim_galore
	for a in {22..30..4}
		do
		/home/avera/bin/TrimGalore-0.6.0/trim_galore -j 4 -q $a --path_to_cutadapt /home/avera/.local/bin/cutadapt --fastqc --basename $name.$a --paired $name\_1.fastq $name\_2.fastq
		done
		#Finish trim galore
	cd $dir
done
