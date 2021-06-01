# Assembly a Klebsiella pneumonie bacterial genome using Illumina and Nanopore sequencing technologies

## Working with Illumina reads:

First we need to create a directory named SPADES in the Illumina folder and bring the TrimGalored q=30 fastq files.

```console
[avera2020@pc-124-131 RawReads.dir]$ cd /home/avera/Genome_Assembly.May.2021/RawReads.dir/Illumina/
[avera2020@pc-124-131 Illumina]$ ls
Fastqc.dir  k_p.illumina.ERR1015321_1.fastq.gz  k_p.illumina.ERR1015321_2.fastq.gz  TrimGalore.dir
[avera2020@pc-124-131 Illumina]$ mkdir SPADES
[avera2020@pc-124-131 Illumina]$ cd SPADES/
[avera2020@pc-124-131 SPADES]$ ln -s ../TrimGalore.dir/*val*gz .
[avera2020@pc-124-131 SPADES]$ ls -l
total 0
lrwxrwxrwx 1 avera2020 avera2020 55 May 31 11:31 k_p.illumina.ERR1015321_1_val_1.fq.gz -> ../TrimGalore.dir/k_p.illumina.ERR1015321_1_val_1.fq.gz
lrwxrwxrwx 1 avera2020 avera2020 55 May 31 11:31 k_p.illumina.ERR1015321_2_val_2.fq.gz -> ../TrimGalore.dir/k_p.illumina.ERR1015321_2_val_2.fq.gz
 ```
Now load the GenomeAssemblyModule environment and ask for the Spades help
```console
(/home/apps/miniconda3) [avera2020@pc-124-131 SPADES]$ conda activate /home/avera/condaenv/GenomeAssemblyModule/
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 SPADES]$
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 SPADES]$ spades.py --help
SPAdes genome assembler v3.15.2

Usage: spades.py [options] -o <output_dir>(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 SPADES]$ spades.py --help
SPAdes genome assembler v3.15.2

Usage: spades.py [options] -o <output_dir>
```
Running spades: 

```console
nohup spades.py -o Spades.illumina.dir --isolate -t 4 -1 k_p.illumina.ERR1015321_1_val_1.fq.gz -2 k_p.illumina.ERR1015321_2_val_2.fq.gz > spades.log &
```

*As spades will take a time to run, I highly recommend to use the nohoup command and then & to run it in the background. The time command will tell you how long your job takes to complete*

Once finished a new Spades.illumina.dir will be created. Take a look:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 SPADES]$ cd Spades.illumina.dir/
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Spades.illumina.dir]$ ls -l
total 39912
-rw-rw-r-- 1 avera2020 avera2020  5751667 May 31 11:43 assembly_graph_after_simplification.gfa
-rw-rw-r-- 1 avera2020 avera2020 11757371 May 31 11:43 assembly_graph.fastg
-rw-rw-r-- 1 avera2020 avera2020  5780066 May 31 11:43 assembly_graph_with_scaffolds.gfa
-rw-rw-r-- 1 avera2020 avera2020  5809248 May 31 11:43 before_rr.fasta
-rw-rw-r-- 1 avera2020 avera2020  5739942 May 31 11:43 contigs.fasta
-rw-rw-r-- 1 avera2020 avera2020    52544 May 31 11:43 contigs.paths
-rw-rw-r-- 1 avera2020 avera2020      111 May 31 11:35 dataset.info
-rw-rw-r-- 1 avera2020 avera2020      320 May 31 11:35 input_dataset.yaml
drwxrwxr-x 4 avera2020 avera2020     4096 May 31 11:37 K21
drwxrwxr-x 4 avera2020 avera2020     4096 May 31 11:39 K33
drwxrwxr-x 4 avera2020 avera2020     4096 May 31 11:43 K55
drwxrwxr-x 2 avera2020 avera2020     4096 May 31 11:43 misc
-rw-rw-r-- 1 avera2020 avera2020     1558 May 31 11:35 params.txt
drwxrwxr-x 2 avera2020 avera2020     4096 May 31 11:43 pipeline_state
-rw-rw-r-- 1 avera2020 avera2020     3649 May 31 11:35 run_spades.sh
-rw-rw-r-- 1 avera2020 avera2020     4822 May 31 11:35 run_spades.yaml
-rw-rw-r-- 1 avera2020 avera2020  5740750 May 31 11:43 scaffolds.fasta
-rw-rw-r-- 1 avera2020 avera2020    51627 May 31 11:43 scaffolds.paths
-rw-rw-r-- 1 avera2020 avera2020   113735 May 31 11:43 spades.log
drwxrwxr-x 2 avera2020 avera2020     4096 May 31 11:43 tmp
```
 The final assembled contigs are in ```contigs.fasta``` file.
 
 **We can use the assembly-stats tool for taking a look into the basic assembly statistics**

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Spades.illumina.dir]$ assembly-stats contigs.fasta 
stats for contigs.fasta
sum = 5632217, n = 388, ave = 14516.02, largest = 271249
N50 = 121603, n = 16
N60 = 99471, n = 21
N70 = 84939, n = 27
N80 = 61116, n = 35
N90 = 30939, n = 48
N100 = 56, n = 388
N_count = 0
Gaps = 0
```

SPADES prints the coverage of each contigs in the header of the fasta sequence, let's take a look
```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Spades.illumina.dir]$ head -1 contigs.fasta 
>NODE_1_length_271249_cov_63.798167
```
Let's use this and obtain the coverage for SPADES assembly using some perl scripts:

1. Let's be sure that all our sequences are in a one-line format, it means header\nsequences:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Spades.illumina.dir]$ cambia_seqs_unalinea.pl contigs.fasta > contigs.one.fasta
```

2. We can use then the script coverage.spades.pl to calculate the coverage:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Spades.illumina.dir]$ coverage.spades.pl contigs.one.fasta 
contigs.one.fasta coverage=	122.663
```

Acording to the stats there are many contings (388) with a length of 56 this is less than a read so we can remove all those "short" contigs and keep those >= 900 nt using the ```trimm_len.pl``` script 

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Spades.illumina.dir]$ trimm_len.pl contigs.one.fasta 900|sed 's/\t/_/g'  > contigs.900.fasta
```
*As the scritp keep a tab in the header we need to remove it with sed*


Now we can check the coverage stats

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Spades.illumina.dir]$ coverage.spades.pl contigs.900.fasta 
contigs.900.fasta coverage=	110.912
```
The coverage decrease a little bit but let's see the main stats:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Spades.illumina.dir]$ assembly-stats contigs.900.fasta
stats for contigs.900.fasta
sum = 5590285, n = 104, ave = 53752.74, largest = 271249
N50 = 121603, n = 16
N60 = 99471, n = 21
N70 = 84939, n = 27
N80 = 63154, n = 34
N90 = 32499, n = 47
N100 = 923, n = 104
N_count = 0
Gaps = 0
```
Now we reduce the number of contigs from 388 to 104, not much but still useful...

**Visualization of the assembly graph to detect circular replicons and quality value using Bandage**

Please install Bandage in your computer following the [Bandage](https://rrwick.github.io/Bandage/) installation instructions.

An advantage to use Spades as assembler is due to it gives us a file assembly_graph.fastg with all the nodes and edges of the graph. 

**As Bandage is a GUI like software you will need to transfer your data to your computer and use Bandage there.**

```
scp avera2020@148.204.124.131:/home/avera/Genome_Assembly.May.2021/RawReads.dir/Illumina/SPADES/Spades.illumina.dir/assembly_graph.fastg .
```
If you correctly installed Bandage you can either open it clicking in the icon or using your command line as follows: 

```console
$ Bandage --help

  ____                  _                  
 |  _ \                | |                 
 | |_) | __ _ _ __   __| | __ _  __ _  ___ 
 |  _ < / _` | '_ \ / _` |/ _` |/ _` |/ _ \
 | |_) | (_| | | | | (_| | (_| | (_| |  __/
 |____/ \__,_|_| |_|\__,_|\__,_|\__, |\___|
                                 __/ |     
                                |___/      
Version: 0.8.1

Usage:    Bandage <command> [options]
          
Commands: <blank>      Launch the Bandage GUI
          load         Launch the Bandage GUI and load a graph file
          info         Display information about a graph
          image        Generate an image file of a graph
          querypaths   Output graph paths for BLAST queries
          reduce       Save a subgraph of a larger graph
          
Options:  --help       View this help message
          --helpall    View all command line settings
          --version    View Bandage version number
          
Online Bandage help: https://github.com/rrwick/Bandage/wiki
```
We can load the  assembly_graph.fastg

```console
(GenomeAssemblyModule) avera@L003772:Genome_Assembly.May.2021$ Bandage load assembly_graph.fastg
```
An then click to Draw graph

![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/k_pgraph.png)

