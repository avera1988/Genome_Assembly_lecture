# Genome assembly using IDBA_UD assembler

### First we need to create a directory named IDBA and move the TrimGalore filtred fastq files.
**As fastq files sometimes are quite large, it is recommendable to use a symbolic (soft) link instead a real (hard) copy**
```console
$ conda activate GenomeAssemblyModule
$ mkdir IDBA
$ cd IDBA/
$ ln -s ../51_val_1.fq .
$ ln -s ../51_val_2.fq .
```
IDBA uses a single fasta file to assembly, so the user needs to concatenate the pair fastq and convert it into a fasta single file; we can do it using the fq2fa from ~/bin/idba/bin/fq2fa: 
```console
 $ fq2fa --merge 51_R1_val_1.fq 51_R2_val_2.fq 51.fasta
$ ls -l
total 691816
-rw-rw-rw- 1 avera avera 708417785 May  6 19:20 51.fasta
lrwxrwxrwx 1 avera avera        17 May  6 19:20 51_R1_val_1.fq -> ../51_R1_val_1.fq
lrwxrwxrwx 1 avera avera        17 May  6 19:20 51_R2_val_2.fq -> ../51_R2_val_2.fq
```
Now we have all the elements to run IDBA_ud, let's check the help message
```console
$ idba_ud

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
nohup time idba_ud -r 51.fasta -o 51.idba.dir --pre_correction --num_threads 4 > idba.log &
```
**This process requires from minutes to hrs to be completed I recommend use nohup and send the process to the background for running. Additionally the time command is helpful showing us how long our process took.**

###As soon as finished IDBA has created a directory (in this case 51.idba.dir ) and the log from nohup command "idba.log.
```console
$ ls
51.fasta  51.idba.dir  51_R1_val_1.fq  51_R2_val_2.fq  idba.log 
$ cd 51.idba.dir/
$ ls
align-100-0  align-40  align-80  contig-100.fa  contig-40.fa  contig-80.fa  end           graph-20.fa  graph-60.fa  kmer                local-contig-40.fa  local-contig-80.fa  scaffold.fa
align-20     align-60  begin     contig-20.fa   contig-60.fa  contig.fa     graph-100.fa  graph-40.fa  graph-80.fa  local-contig-20.fa  local-contig-60.fa  log
```
 **Take a look into the basic assembly statistics**

We can run the assembly.stats.pl script form scripts directory. 
```console
perl ~/Genome_Assembly_lecture/Scripts/assembly.stats.pl contig.fa 
Sample_ID	Genome	Contigs	Mean	Median	N50	Largest	GC(%)	N_count	N(%)	Gap_count
contig.fa	3722537	313	11893	847	72960	219803	30.45		0.00	0 
```
*~ means /home/ dome directory, maybe you need to indicate where the Scripts folder is located in your computer*

These are the basic stats. Also using a more complex scritp from https://github.com/sanger-pathogens/assembly-stats/ we can detect all Nx parameters
```console
[veraponcedeleon.1@u005 DacBIdba]$ 
~/Genome_Assembly_lecture/Scripts/assembly-stats/assembly-stats contig.fa 
stats for contig.fa
sum = 3722537, n = 313, ave = 11893.09, largest = 219803
N50 = 72960, n = 16
N60 = 51801, n = 22
N70 = 40399, n = 30
N80 = 27167, n = 41
N90 = 11091, n = 63
N100 = 211, n = 313
N_count = 0
Gaps = 0 
```

The output of these scripts can be parsed into a txt file:

```console
~/Genome_Assembly_lecture/Scripts/assembly-stats/assembly-stats contig.fa > contigs.stats.txt
```

## Obtain coverage information

We can also see the coverage, as IDBA do not print the coverage in the conting we can extract it using a perl scritp. First let's take a look into an idba contig:

```console
$ head -1 contig.fa 
>contig-100_0 length_219803 read_count_133621
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
perl ~/Genome_Assembly_lecture/Scripts/cambia_seqs_unalinea.pl contig.fa > contig.one.fa
```

Then let's apply the ~/Genome_Assembly_lecture/Scripts/coverage.idga.pl to these new file. As a result it will give us the mean coverage of the assembly

```console
perl ~/Genome_Assembly_lecture/Scripts/coverage.idba.pl contig.one.fa 
contig.one.fa coverage=	49.423
```

This script will generate a contig.one.fa.coverage.txt where the first column has the contig ID, the length and the last column the coverage

```console
head contig.one.fa.coverage.txt
contig-100_0	219803	60.791
contig-100_1	205903	54.280
contig-100_2	171234	52.893
contig-100_3	134051	63.489
contig-100_4	122844	57.025
contig-100_5	115567	58.570
contig-100_6	105381	52.877
contig-100_7	105256	62.898
contig-100_8	98885	57.293
contig-100_9	98560	65.169 
```
Most of the contigs has a coverage above 50X with an average of 49X, lets take a look to those contigs with a coverage lower than this.

```console
$ awk '{if($3 < 49) print}' contig.one.fa.coverage.txt > contigs.lower.40x.txt
$ cat contigs.lower.40x.txt|wc -l
137 
```
There are 137 contings lower than 40x. 

**Considering the average of a bacterial gene length is ~900 nt we can remove those small contigs shorter than 900 nt and compare the coverage again. For this we can use the trimm_len.pl script**

```console
perl ~/Genome_Assembly_lecture/Scripts/trimm_len.pl contig.one.fa 900 > contig.900.fa
```

Then obtain the stats

```console
~/Genome_Assembly_lecture/Scripts/assembly-stats/assembly-stats contig.900.fa 
stats for contig.900.fa
sum = 3644585, n = 148, ave = 24625.57, largest = 219803
N50 = 73987, n = 15
N60 = 57118, n = 21
N70 = 40678, n = 29
N80 = 28401, n = 39
N90 = 13398, n = 57
N100 = 902, n = 148
N_count = 0
Gaps = 0 
```
And the coverage

```console
perl ~/Genome_Assembly_lecture/Scripts/coverage.idba.pl contig.900.fa 
contig.900.fa coverage=	59.497
```

As you can appreciate removing those short contigs improves the assemlby stats and the coverage

**What happen if you trimm the contigs to 1000?
