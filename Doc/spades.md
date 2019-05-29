# Here you will find the code for using SPADES assembler

### First we need to create a directory named SPADES and move the TrimGalore with q=30   filtred DacBet fastq files.
**As fastq files sometimes are quite large, it is recommendable to use a symbolic (soft) link instead a real (hard) copy**

```console
(base) [veraponcedeleon.1@u009 Class_May_2019]$ mkdir SPADES
(base) [veraponcedeleon.1@u009 Class_May_2019]$ cd SPADES/
(base) [veraponcedeleon.1@u009 SPADES]$ ln -s ../TrimGalore/*30*fq . .
 ```
 We also need the PacBio files for the hybrid assembly so let's linked here
```console 
(base) [veraponcedeleon.1@u009 SPADES]$ ln -s ../Raw_reads_soft/PacBio/DacBeta.pacBio.fastq .
```

Now if spades is instaled in the PATH we can invocate it by typing spades.py

```console
(base) [veraponcedeleon.1@u009 SPADES]$ spades.py 

SPAdes genome assembler v3.11.1

Usage: /usr/local/SPAdes/3.11.1/bin/spades.py [options] -o <output_dir>
```
Running spades

```console
[veraponcedeleon.1@u009 DacSpades]$ nohup time spades.py -o DacSpades -1 DacBet.30_val_1.fq -2 DacBet.30_val_2.fq -t 4 > spades.log &
```

Once finished a Directory DacSpades will be created

```console
(base) [veraponcedeleon.1@u009 SPADES]$ ls

DacBet.30_val_1.fq  DacBet.30_val_2.fq  DacBeta.pacBio.fastq  DacSpades  spades.log
(base) [veraponcedeleon.1@u009 SPADES]$ cd DacSpades/
(base) [veraponcedeleon.1@u009 DacSpades]$ ls -l
total 17824
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree 7294006 May 20 17:16 assembly_graph.fastg
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree 3568782 May 20 17:16 assembly_graph_with_scaffolds.gfa
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree 3632240 May 20 17:16 before_rr.fasta
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree 3632240 May 20 17:16 contigs.fasta
drwxr-xr-x 3 veraponcedeleon.1 RESEARCH-EEOB-Sabree     204 May 20 17:15 corrected
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree      97 May 20 17:15 dataset.info
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree     240 May 20 17:14 input_dataset.yaml
drwxr-xr-x 3 veraponcedeleon.1 RESEARCH-EEOB-Sabree     226 May 20 17:16 K21
drwxr-xr-x 3 veraponcedeleon.1 RESEARCH-EEOB-Sabree     226 May 20 17:16 K33
drwxr-xr-x 3 veraponcedeleon.1 RESEARCH-EEOB-Sabree     264 May 20 17:16 K55
drwxr-xr-x 2 veraponcedeleon.1 RESEARCH-EEOB-Sabree      10 May 20 17:16 misc
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree    1585 May 20 17:14 params.txt
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree  100910 May 20 17:16 spades.log
drwxr-xr-x 2 veraponcedeleon.1 RESEARCH-EEOB-Sabree      10 May 20 17:16 tmp
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree     686 May 20 17:16 warnings.log
```
 **Take a look into the basic assembly statistics**

We can run the assembly.stats.pl script form scripts directory.

```console
(base) [veraponcedeleon.1@u009 DacSpades]$ perl ../../scripts/assembly.stats.pl contigs.fasta 

Sample_ID	Genome	Contigs	Mean	Median	N50	Largest	GC(%)	N_count	N(%)	Gap_count
contigs.fasta	3547469	729	4866	2873	10301	38609	62.74		0.00	0

```

These are the basic stats. Also using a more complex scritp from https://github.com/sanger-pathogens/assembly-stats/ we can detect all Nx parameters

```console
(base) [veraponcedeleon.1@u009 DacSpades]$ ../../scripts/assembly-stats/assembly-stats contigs.fasta 
stats for contigs.fasta
sum = 3547469, n = 729, ave = 4866.21, largest = 38609
N50 = 10301, n = 110
N60 = 8367, n = 148
N70 = 6752, n = 195
N80 = 4770, n = 258
N90 = 3093, n = 350
N100 = 56, n = 729
N_count = 0
Gaps = 0
```
We can also see the coverage, such as in IDBA. But with SPADES we have the advantage that the coverage now is printed in the header, let's take a look
```console
(base) [veraponcedeleon.1@u009 DacSpades]$ head contigs.fasta 
>NODE_1_length_4802_cov_7.986939
```
Following the same idea as in IDBA let's obtain the coverage for SPADES assembly

```console
(base) [veraponcedeleon.1@u009 DacSpades]$ ~/scripts/cambia_seqs_unalinea.pl contigs.fasta > contigs.one.fasta
(base) [veraponcedeleon.1@u009 DacSpades]$ perl ../../scripts/coverage.spades.pl contigs.one.fasta 
contigs.one.fasta coverage=	23.099
```

You can see here that using SPADES the average coverage is higher than IDBA's using the same Q value. But the number of contigs are quite big: sum = 3547469, n = 729, ave = 4866.21, largest = 38609

**Remember that SPADES allow us to do an hybrid assembly, let's do it and see if our stats improves or not**

To do this we are going to use the PacBio Dac file so let's be sure you have this file in the SPADES directory:

```console
DacBeta.pacBio.fastq
```

Now we can give to spades de PacBio and Illumina reads as following:

```console
(base) [veraponcedeleon.1@u009 SPADES]$ nohup spades.py -o DacBSpades_hybrid -1 DacBet.30_val_1.fq -2 DacBet.30_val_2.fq --pacbio DacBeta.pacBio.fastq -t 4 > spades.hybrid.log &
(base) [veraponcedeleon.1@u009 SPADES]$ cd DacBSpades_hybrid/
(base) [veraponcedeleon.1@u009 DacBSpades_hybrid]$ ls
assembly_graph.fastg               before_rr.fasta  contigs.paths  dataset.info        K21  K55   params.txt       scaffolds.paths  tmp
assembly_graph_with_scaffolds.gfa  contigs.fasta    corrected      input_dataset.yaml  K33  misc  scaffolds.fasta  spades.log       warnings.log
(base) [veraponcedeleon.1@u009 DacBSpades_hybrid]$ perl ../../scripts/assembly.stats.pl contigs.fasta 
Sample_ID	Genome	Contigs	Mean	Median	N50	Largest	GC(%)	N_count	N(%)	Gap_count
contigs.fasta	3545199	650	5454	3322	10829	38609	62.74		0.00	0
(base) [veraponcedeleon.1@u009 DacBSpades_hybrid]$ ../../scripts/assembly-stats/assembly-stats contigs.fasta 
stats for contigs.fasta
sum = 3545199, n = 650, ave = 5454.15, largest = 38609
N50 = 10829, n = 103
N60 = 9086, n = 139
N70 = 7126, n = 183
N80 = 4989, n = 241
N90 = 3254, n = 329
N100 = 56, n = 650
N_count = 0
Gaps = 0
(base) [veraponcedeleon.1@u009 DacBSpades_hybrid]$ perl ../../scripts/coverage.spades.pl contigs.one.fasta 
contigs.one.fasta coverage=	11.796
(base) [veraponcedeleon.1@u009 DacBSpades_hybrid]$ head contigs.one.fasta.coverage.txt 
NODE_1	8.153
NODE_2	7.873
NODE_3	8.409
NODE_4	7.893
NODE_5	7.668
NODE_6	7.911
NODE_7	8.145
NODE_8	8.031
NODE_9	8.271
NODE_10	7.563
```
As in IDBA we can trimm those short contigs. Remember to convert into a new line the contigs.fasta

```console
$ perl ../../../Genome_Assembly_lecture/Scripts/cambia_seqs_unalinea.pl contigs.fasta > contigs.one.fasta
```
An then we can trimm by length

```console
(base) [veraponcedeleon.1@u032 comparaciones_IDBA_SPADES]$ perl ../../../Genome_Assembly_lecture/Scripts/trimm_len.pl contigs.one.fasta 1000 |sed 's/\t/_/g' > contigs.one.1000
```
*As the scritp keep a tab in the header we need to remove it with sed*


Now we can check the stats

```console
(base) [veraponcedeleon.1@u032 comparaciones_IDBA_SPADES]$ perl ../../../Genome_Assembly_lecture/Scripts/coverage.spades.pl contigs.one.1000
contigs.one.1000 coverage=	8.558
```
