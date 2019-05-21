# Genome assembly using IDBA_UD assembler

### First we need to create a directory named IDBA and move the TrimGalore filtred DacBet with a quality value (q > 30) fastq files.
**As fastq files sometimes are quite large, it is recommendable to use a symbolic (soft) link instead a real (hard) copy**
```console
[veraponcedeleon.1@u016 Class_May_2019]$ mkdir IDBA
[veraponcedeleon.1@u016 Class_May_2019]$ cd IDBA/
[veraponcedeleon.1@u009 IDBA]$ ln -s ../TrimGalore/DacBet.30_val_1.fq .
[veraponcedeleon.1@u009 IDBA]$ ln -s ../TrimGalore/DacBet.30_val_2.fq .
```
IDBA uses a single fasta file to assembly, so the user needs to concatenate the pair fastq and convert it into a fasta single file; we can do it using the fq2fa from ~/bin/idba/bin/fq2fa: 
```console
[veraponcedeleon.1@u016 IDBA]$ /home/veraponcedeleon.1/bin/idba/bin/fq2fa --merge DacBet.30_val_1.fq DacBet.30_val_2.fq DacBet.fa
```
**In my case my fastq files are named as DacBet.30_val_1.fq DacBet.30_val_2.fq remember you need to use your own fastq files!!! If you are using the default trimGalored your files are named as: DacBet_val_1.fq DacBet_val_2.fq, check for these files when you run your data**

Now we have all the elements to run IDBA_ud, let's check the help message
```console
(base) [veraponcedeleon.1@unity-1 DacBIdba]$ ~/bin/idba/bin/idba_ud

not enough parameters
IDBA-UD - Iterative de Bruijn Graph Assembler for sequencing data with highly uneven depth.
Usage: idba_ud -r read.fa -o output_dir
Allowed Options:
  -o, --out arg (=out)                   output directory
  -r, --read arg                         fasta read file (<=128)
      --read_level_2 arg                 paired-end reads fasta for second level scaffolds
      --read_level_3 arg                 paired-end reads fasta for third level scaffolds
      --read_level_4 arg                 paired-end reads fasta for fourth level scaffolds
      --read_level_5 arg                 paired-end reads fasta for fifth level scaffolds
  -l, --long_read arg                    fasta long read file (>128)
      --mink arg (=20)                   minimum k value (<=124)
      --maxk arg (=100)                  maximum k value (<=124)
      --step arg (=20)                   increment of k-mer of each iteration
      --inner_mink arg (=10)             inner minimum k value
      --inner_step arg (=5)              inner increment of k-mer
      --prefix arg (=3)                  prefix length used to build sub k-mer table
      --min_count arg (=2)               minimum multiplicity for filtering k-mer when building the graph
      --min_support arg (=1)             minimum supoort in each iteration
      --num_threads arg (=0)             number of threads
      --seed_kmer arg (=30)              seed kmer size for alignment
      --min_contig arg (=200)            minimum size of contig
      --similar arg (=0.95)              similarity for alignment
      --max_mismatch arg (=3)            max mismatch of error correction
      --min_pairs arg (=3)               minimum number of pairs
      --no_bubble                        do not merge bubble
      --no_local                         do not use local assembly
      --no_coverage                      do not iterate on coverage
      --no_correct                       do not do correction
      --pre_correction                   perform pre-correction before assembly

```
Running IDBA with Dac.fasta file:
```console
[veraponcedeleon.1@u016 IDBA]$ nohup time ~/bin/idba/bin/idba_ud -r DacBet.fa -o DacBIDBA --pre_correction --num_threads 4 > idba.log &
```
**This process requires from minutes to hrs to be completed I recommend use nohup and send the process to the background for running. Additionally the time command is helpful to show us how long our process took.**

*~ Means my home this is why some times you see this symbol in my commands.

###As soon as finished IDBA has created a directory (in this case DacBIdba) and the log from nohup command "idba.log2.
```console
(base) [veraponcedeleon.1@u005 IDBA]$ ls
DacBet.30_val_1.fq  DacBet.30_val_2.fq  DacBet.fa  DacBIDBA  idba.log
(base) [veraponcedeleon.1@u005 IDBA]$ cd DacBIDBA/
(base) [veraponcedeleon.1@u005 DacBIdba]$ ls
align-100-0  align-60  contig-100.fa  contig-60.fa  graph-100.fa  graph-60.fa  local-contig-20.fa  local-contig-80.fa
align-20     align-80  contig-20.fa   contig-80.fa  graph-20.fa   graph-80.fa  local-contig-40.fa  log
align-40     begin     contig-40.fa   contig.fa     graph-40.fa   kmer         local-contig-60.fa
```
 **Take a look into the basic assembly statistics**

We can run the assembly.stats.pl script form scripts directory. 
```console
[veraponcedeleon.1@u005 DacBIdba]$ perl /fs/project/obcp/veraponcedelon.1/Class_May_2019/scripts/assembly.stats.pl contig.fa
Sample_ID	Genome	Contigs	Mean	Median	N50	Largest	GC(%)	N_count	N(%)	Gap_count
contig.fa	3525841	539	6541	4498	10950	34671	62.76		0.00	0

```

These are the basic stats. Also using a more complex scritp from https://github.com/sanger-pathogens/assembly-stats/ we can detect all Nx parameters
```console
[veraponcedeleon.1@u005 DacBIdba]$ /fs/project/obcp/veraponcedelon.1/Class_May_2019/scripts/assembly-stats/assembly-stats contig.fa
stats for contig.fa
sum = 3525841, n = 539, ave = 6541.45, largest = 34671
N50 = 10950, n = 110
N60 = 8933, n = 146
N70 = 7001, n = 191
N80 = 4971, n = 250
N90 = 3237, n = 337
N100 = 389, n = 539
N_count = 0
Gaps = 0
```

The output of these scripts can be parsed into a txt file:

```console
perl /fs/project/obcp/veraponcedelon.1/Class_May_2019/scripts/assembly.stats.pl contig.fa > stats.perl.assembly.txt
/fs/project/obcp/veraponcedelon.1/Class_May_2019/scripts/assembly-stats/assembly-stats contig.fa > stats.assembly.txt
```

We can also see the coverage, as IDBA do not print the coverage in the conting we can extract it using a perl scritp. First let's take a look into an idba contig:

```console
(base) [veraponcedeleon.1@u009 DacBIdba]$ head -1 contig.fa 
>contig-100_0 length_34647 read_count_4234
```
In this header we have the contig length and the number of reads per each contig. 

*Remembering the coverage formula:

**Coverage:**


*C = nl/L*

C=Coverage

n=Number of reads

l=Read length

L=Genome fragment size (length) in bases

As we have all the elements to calculate the coverage in the conting header let's obtain a coverage table.

**First we need to transforme the contigs.fa into a single lane fasta file, it means a header and the next line the sequnce. We can do it using the perl scripts/cambia_seqs_unalinea.pl

```console
(base) [veraponcedeleon.1@u009 DacBIdba]$ perl ~/scripts/cambia_seqs_unalinea.pl contig.fa > contig.one.fa
```

Then let's apply the ~/scripts/covergae.idba.pl to these new file. As a result it will give us the mean coverage of the assembly

```console
(base) [veraponcedeleon.1@u009 DacBIdba]$ perl ../../scripts/coverage.idba.pl contig.one.fa 
contig.one.fa coverage=	13.461
```

This script will generate a contig.one.fa.coverage.txt where the first column has the contig ID, the length and the last column the coverage

```console
(base) [veraponcedeleon.1@u009 DacBIdba]$ head contig.one.fa.coverage.txt 
contig-100_0	34647	12.220
contig-100_1	30833	11.968
contig-100_2	29559	13.001
contig-100_3	26892	12.282
contig-100_4	26710	12.857
contig-100_5	26669	11.883
contig-100_6	25574	12.814
contig-100_7	25430	18.962
contig-100_8	24685	11.902
contig-100_9	24004	11.594
```

### As we can see we have low coverage and a hihg number of contigs (>500) to report a genome anoucement of Bacterial genome, NCBI request up to 200 contigs. Let's try using an other q filter value, I'm using now a Q>=22.

```console
(base) [veraponcedeleon.1@u009 DacBIdba]$ cd ..
(base) [veraponcedeleon.1@u009 IDBA]$ mkdir DacBQ22
(base) [veraponcedeleon.1@u009 IDBA]$ cd DacBQ22/
(base) [veraponcedeleon.1@u009 DacBQ22]$ ln -s ../../TrimGalore/*22*fq .
(base) [veraponcedeleon.1@u009 DacBQ22]$ ~/bin/idba/bin/fq2fa --merge DacBet.22_val_1.fq DacBet.22_val_2.fq Dac.fasta
(base) [veraponcedeleon.1@u009 DacBQ22]$ nohup ~/bin/idba/bin/idba_ud -o DacB20 -r Dac.fasta --num_threads 4 --pre_correction > idba.log &
(base) [veraponcedeleon.1@u009 DacBQ22]$ cd DacB20/
(base) [veraponcedeleon.1@u009 DacB20]$ ls

align-100-0  align-40  align-80  contig-100.fa  contig-40.fa  contig-80.fa  graph-100.fa  graph-40.fa  graph-80.fa  local-contig-20.fa  local-contig-60.fa  log
align-20     align-60  begin     contig-20.fa   contig-60.fa  contig.fa     graph-20.fa   graph-60.fa  kmer         local-contig-40.fa  local-contig-80.fa
(base) [veraponcedeleon.1@u009 DacB20]$ perl ../../../scripts/assembly.stats.pl contig.fa 
Sample_ID	Genome	Contigs	Mean	Median	N50	Largest	GC(%)	N_count	N(%)	Gap_count
contig.fa	3530166	442	7986	5761	12891	38881	62.75		0.00	0
(base) [veraponcedeleon.1@u009 DacB20]$ ../../../scripts/assembly-stats/assembly-stats contig.fa 
stats for contig.fa
sum = 3530166, n = 442, ave = 7986.80, largest = 38881
N50 = 12891, n = 92
N60 = 11028, n = 121
N70 = 8118, n = 158
N80 = 6539, n = 206
N90 = 4000, n = 275
N100 = 511, n = 442
N_count = 0
Gaps = 0
(base) [veraponcedeleon.1@u009 DacB20]$ ~/scripts/cambia_seqs_unalinea.pl contig.fa > contig.one.fa
(base) [veraponcedeleon.1@u009 DacB20]$ perl ../../../scripts/coverage.idba.pl contig.one.fa 
contig.one.fa coverage=	28.488
(base) [veraponcedeleon.1@u009 DacB20]$ head contig.one.fa.coverage.txt 
contig-100_0	38881	27.258
contig-100_1	37751	28.142
contig-100_2	34671	26.795
contig-100_3	34147	28.231
contig-100_4	33348	26.160
contig-100_5	33014	26.849
contig-100_6	30867	26.170
contig-100_7	28217	25.977
contig-100_8	27822	25.512
contig-100_9	27119	27.929
```

**Using this new data set we can apreciate how the number of contigs (fragmentation) decreased sum = 3530166, n = 442, ave = 7986.80, largest = 38881; and also the N90 is higher N90 = 4000, n = 275. Lastly the coverage is so much better: contig.one.fa coverage=	28.488**

We can look into the contig.one.fa.coverage.txt file and see the length and the coverage, lets find those contigs with a coverage less than 20x

```console
(base) [veraponcedeleon.1@unity-1 DacB20]$ awk '{if($3 < 20) print $0 }' contig.one.fa.coverage.txt 
contig-100_396	1269	18.913
contig-100_399	1167	16.795
contig-100_401	1132	16.608
contig-100_409	982	16.090
contig-100_410	950	19.158
contig-100_411	938	19.616
contig-100_413	883	18.800
contig-100_419	806	18.362
contig-100_422	737	19.539
contig-100_423	710	16.901
contig-100_424	709	18.618
contig-100_428	640	15.938
contig-100_433	594	18.519
contig-100_434	567	19.048
contig-100_435	560	8.571
contig-100_437	528	9.470
contig-100_438	527	15.180
contig-100_439	525	15.238
contig-100_441	511	16.438
```
How many?

```console
(base) [veraponcedeleon.1@unity-1 DacB20]$ awk '{if($3 < 20) print $0 }' contig.one.fa.coverage.txt |wc -l
19
```
**As you see from these 19 contigs with low quality most of them are less than 1000 nt in length.**

Even thoug these contigs are much better we still have contigs less than the lenght of a normal bacterial gene (~1000 nt) we can trimm those "short contigs" and see if our genome improves. To do this let's use the script/trimm_len.pl

```console
(base) [veraponcedeleon.1@unity-1 DacB20]$ perl ../../../scripts/trimm_len.pl

Usage: perl ../../../scripts/trimm_len.pl fasta_file trimmm_value
(base) [veraponcedeleon.1@unity-1 DacB20]$ perl ../../../scripts/trimm_len.pl contig.one.fa 1000 > contig.1000.fa
```

I am using a trimm value of 1000 due to the average gen of bacteria genes you can modify this parameter.

Now we can compare the statistics of the original contig.one.fa and the contig.900.fa

```console
(base) [veraponcedeleon.1@unity-1 DacB20]$ ../../../scripts/assembly-stats/assembly-stats contig.one.fa contig.1000.fa 
stats for contig.one.fa
sum = 3530166, n = 442, ave = 7986.80, largest = 38881
N50 = 12891, n = 92
N60 = 11028, n = 121
N70 = 8118, n = 158
N80 = 6539, n = 206
N90 = 4000, n = 275
N100 = 511, n = 442
N_count = 0
Gaps = 0
-------------------------------------------------------------------------------
stats for contig.1000.fa
sum = 3506760, n = 409, ave = 8573.99, largest = 38881
N50 = 12896, n = 91
N60 = 11032, n = 120
N70 = 8301, n = 156
N80 = 6601, n = 203
N90 = 4196, n = 270
N100 = 1009, n = 409
N_count = 0
Gaps = 0
```

Let's check the coverage:

```console
(base) [veraponcedeleon.1@unity-1 DacB20]$ perl ../../../scripts/coverage.idba.pl contig.1000.fa 
contig.1000.fa coverage=	26.528
```

What do you think the average coverage is less than the original one?

Now let's see again those coverage from contigs less than 20x
```console
(base) [veraponcedeleon.1@unity-1 DacB20]$ awk '{if($3 < 20) print $0 }' contig.1000.fa.coverage.txt 
contig-100_396	1269	18.913
contig-100_399	1167	16.795
contig-100_401	1132	16.608
````
There are only 3 genes with a "low qual". Now you can see why is important to do this kind of quality check. 
