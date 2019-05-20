# Genome assembly using IDBA_UD assembler

### First we need to create a directory named IDBA and move the TrimGalore filtred DacBet q > 30 fastq files.
**As fastq files sometimes are quite large, it is recommendable to use a symbolic (soft) link instead a real (hard) copy**
```console
[veraponcedeleon.1@u016 Class_May_2019]$ mkdir IDBA
[veraponcedeleon.1@u016 Class_May_2019]$ cd IDBA/
[veraponcedeleon.1@u009 IDBA]$ ln -s ../TrimGalore/*30*fq .
```
IDBA uses a fasta file to assembly, the user needs to concatenate the pair fastq files we can do it using the command cat: 
```console
[veraponcedeleon.1@u016 IDBA]$ cat *.fq > Dac.total.fq
```
As IDBA do not work with fastq files, we need to transform this file into fasta using a IDBA fq2fa script 
```Console
[veraponcedeleon.1@u016 IDBA]$ ~/bin/idba/bin/fq2fa Dac.total.fq Dac.fasta
```
*~symbol means my_home_directory, as I have installed IDBA in my home bin path I used it; remember to use your own path*

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
[veraponcedeleon.1@u016 IDBA]$ nohup time ~/bin/idba/bin/idba_ud -r Dac.fasta -o DacBIdba --pre_correction --num_threads 4 > idba.log &
```
*This process requires from minutes to hrs to be completed I recommend use nohup and send the process to the background for running. Additionaly the time command is helpful to show us how long our process took. 

###As soon as finished IDBA has created a directory (in this case DacBIdba) and the log from nohup command "idba.log2.
```console
(base) [veraponcedeleon.1@unity-1 IDBA]$ ls
DacBet_1_val_1.fq  DacBet_2_val_2.fq  DacBIdba  Dac.fasta  Dac.total.fq  idba.log
(base) [veraponcedeleon.1@u005 IDBA]$ cd DacBIdba/
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
contig.fa	3511207	578	6074	3994	10241	34647	62.75		0.00	0

```

These are the basic stats. Also using a more complex scritp from https://github.com/sanger-pathogens/assembly-stats/ we can detect all Nx parameters
```console
[veraponcedeleon.1@u005 DacBIdba]$ /fs/project/obcp/veraponcedelon.1/Class_May_2019/scripts/assembly-stats/assembly-stats contig.fa
stats for contig.fa
sum = 3511207, n = 578, ave = 6074.75, largest = 34647
N50 = 10241, n = 114
N60 = 8080, n = 152
N70 = 6530, n = 200
N80 = 4550, n = 266
N90 = 2948, n = 362
N100 = 394, n = 578
N_count = 0
Gaps = 0
```

We can also see the coverage, as IDBA do not print the coverage in the conting we can extract it using a perl scritp. First let's take a look into an idba contig:

```console
(base) [veraponcedeleon.1@u009 DacBIdba]$ head -1 contig.fa 
>contig-100_0 length_34647 read_count_4234
```
In this header we have the contig length and the number of reads per each contig. 

*Remembering the coverage formula:

**Coverage:
C = nl/L
C=Coverage
n=Number of reads
l=Read length
L=Genome size (length) in bases
**

  
**These are only the basic statistics. As we can see there are a small contigs (< 500 nt), this is not even a half of most bacterial genenes (~ 1000 nt). 





