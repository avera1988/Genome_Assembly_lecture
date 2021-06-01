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

We now recover the bacterial genome, but it is still quite fragmented (n=104 contigs). But how complete is our genome??

## Genome completeness assessment by single-copy orthologs
[BUSCO](https://busco.ezlab.org/) (Benchmarking Universal Single-Copy Orthologs) is a tool that attempts to provide a quantitative assessment of the completeness in terms of expected gene content of a genome assembly, transcriptome, or annotated gene set. The results are simplified into categories of Complete and single-copy, Complete and duplicated, Fragmented, or Missing BUSCOs.

This software looks for a certain number of orthologous genes (BUSCOs) on a database and compares the total of these ortholog genes present in the genome we would like to evaluate. Then, it estimates the completeness based on the presence, duplication, fragmentation, or absence of these BUSCOS. For example (raw example), if the BUSCO database has 10 genes and the software only finds 9 of them in the query genome it scores completeness of the genome at 90 %.

BUSCO has developed different databases with common universal orthologs clusters for several organisms:
![buscoimg](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/busco.png)

Busco will predict genes in the assembly (by prodigal) and then look for the USCOs of a certain taxonomical lineage using hmmer. It automatically identifies the closest taxonomical lineage and then download the BUSCOs database, however you can indicate and narrow the BUSCOs sarch to a prokaryote or eukaryote database by using the **--auto-lineage-prok** flag.

BUSCO is installed in the server in a different conda environment. So, we need firt to activate the ```BUSCO``` environment as follo:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Spades.illumina.dir]$ conda activate /home/avera/condaenv/BUSCO/
(/home/avera/condaenv/BUSCO) [avera2020@pc-124-131 Spades.illumina.dir]$
```

Now lets display the Busco help:

```console
(/home/avera/condaenv/BUSCO) [avera2020@pc-124-131 Spades.illumina.dir]$ busco --help
usage: busco -i [SEQUENCE_FILE] -l [LINEAGE] -o [OUTPUT_NAME] -m [MODE] [OTHER OPTIONS]

Welcome to BUSCO 5.1.3: the Benchmarking Universal Single-Copy Ortholog assessment tool.
For more detailed usage information, please review the README file provided with this distribution and the BUSCO user guide.
```
We need to indicate the genome.fasta file we are using as a query, the lineage (in this case --auto-lineage-prok), the mode (genome) and the output prefix.

Run BUSCO:

```console
nohup busco -i contigs.900.fasta --auto-lineage-prok -m geno -o Illumina.busco -c 4 &
```

Busco will create two directories:
* Illumina.busco > all results
* busco_downloads > databases and orthologous genes downloaded

Let's take a look into the Results (Illumina.busco) results:

```console
(/home/avera/condaenv/BUSCO) [avera2020@pc-124-131 Spades.illumina.dir]$ cd Illumina.busco/
(/home/avera/condaenv/BUSCO) [avera2020@pc-124-131 Illumina.busco]$ ls
auto_lineage     run_bacteria_odb10                                       short_summary.specific.enterobacterales_odb10.Illumina.busco.txt
logs             run_enterobacterales_odb10
prodigal_output  short_summary.generic.bacteria_odb10.Illumina.busco.txt
```
There are multiplefolders but the main results are in the .txt files as:

* short_summary.generic.bacteria_odb10.Illumina.busco.txt 
* short_summary.specific.enterobacterales_odb10.Illumina.busco.txt

Let's look into these files:

```console
(/home/avera/condaenv/BUSCO) [avera2020@pc-124-131 Illumina.busco]$ more short_summary.generic.bacteria_odb10.Illumina.busco.txt 
# BUSCO version is: 5.1.3 
# The lineage dataset is: bacteria_odb10 (Creation date: 2020-03-06, number of genomes: 4085, number of BUSCOs: 124)
# Summarized benchmarking in BUSCO notation for file /home/avera/Genome_Assembly.May.2021.old/RawReads.dir/Illumina/SPADES/Spades.illumina.dir/con
tigs.900.fasta
# BUSCO was run in mode: genome
# Gene predictor used: prodigal

	***** Results: *****

	C:98.4%[S:98.4%,D:0.0%],F:0.0%,M:1.6%,n:124	   
	122	Complete BUSCOs (C)			   
	122	Complete and single-copy BUSCOs (S)	   
	0	Complete and duplicated BUSCOs (D)	   
	0	Fragmented BUSCOs (F)			   
	2	Missing BUSCOs (M)			   
	124	Total BUSCO groups searched		   

Dependencies and versions:
	hmmsearch: 3.1
	prodigal: 2.6.3
(/home/avera/condaenv/BUSCO) [avera2020@pc-124-131 Illumina.busco]$ more short_summary.specific.enterobacterales_odb10.Illumina.busco.txt 
# BUSCO version is: 5.1.3 
# The lineage dataset is: enterobacterales_odb10 (Creation date: 2021-02-23, number of genomes: 212, number of BUSCOs: 440)
# Summarized benchmarking in BUSCO notation for file /home/avera/Genome_Assembly.May.2021.old/RawReads.dir/Illumina/SPADES/Spades.illumina.dir/con
tigs.900.fasta
# BUSCO was run in mode: genome
# Gene predictor used: prodigal

	***** Results: *****

	C:98.9%[S:98.2%,D:0.7%],F:0.2%,M:0.9%,n:440	   
	435	Complete BUSCOs (C)			   
	432	Complete and single-copy BUSCOs (S)	   
	3	Complete and duplicated BUSCOs (D)	   
	1	Fragmented BUSCOs (F)			   
	4	Missing BUSCOs (M)			   
	440	Total BUSCO groups searched		   

Dependencies and versions:
	hmmsearch: 3.1
	prodigal: 2.6.3
	sepp: 4.4.0

Placement file versions:
	list_of_reference_markers.bacteria_odb10.2019-12-16.txt
	tree.bacteria_odb10.2019-12-16.nwk
	tree_metadata.bacteria_odb10.2019-12-16.txt
	supermatrix.aln.bacteria_odb10.2019-12-16.faa
	mapping_taxids-busco_dataset_name.bacteria_odb10.2019-12-16.txt
	mapping_taxid-lineage.bacteria_odb10.2019-12-16.txt
 ````
 Now we can see that the genome is > 98 % complete acordingly to Busco and it decided that out bacteria belongs to the enterobacteriales order and is 98.9 % complete.
 
 **Before finish lets remove the busco_downloads folder to save space!!!**
 
 
 ## Assembly the Nanopore data
 
 We are using [Unicycler](https://github.com/rrwick/Unicycler) assembler to assembly the Nanopore data. 
 
 ![logo](https://github.com/rrwick/Unicycler/blob/main/misc/logo.png)

**Unicycler is an assembly pipeline for bacterial genomes. It can assemble Illumina-only read sets where it functions as a SPAdes-optimiser. It can also assembly long-read-only sets (PacBio or Nanopore) where it runs a miniasm+Racon pipeline.**


Let's move to the Nanopore data:
```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 ~]$ cd /home/avera/Genome_Assembly.May.2021.old/RawReads.dir/Nanopore/
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Nanopore]$
```
Then create a Unicycler folder and put our reads in it:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Nanopore]$ mkdir Unicyler
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Nanopore]$ cd Unicyler/
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Unicyler]$ ln -s ../k_p.nanopre.fastq.gz .
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Unicyler]$ ls -l
total 0
lrwxrwxrwx 1 avera2020 avera2020 23 May 31 12:01 k_p.nanopre.fastq.gz -> ../k_p.nanopre.fastq.gz
```

Display the unicylcer help:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Unicyler]$ unicycler --help
usage: unicycler [-h] [--help_all] [--version] [-1 SHORT1] [-2 SHORT2] [-s UNPAIRED] [-l LONG] -o OUT [--verbosity VERBOSITY] [--min_fasta_length MIN_FASTA_LENGTH] [--keep KEEP]
                 [-t THREADS] [--mode {conservative,normal,bold}] [--linear_seqs LINEAR_SEQS] [--vcf]

       __
       \ \___
        \ ___\
        //
   ____//      _    _         _                     _
 //_  //\\    | |  | |       |_|                   | |
//  \//  \\   | |  | | _ __   _   ___  _   _   ___ | |  ___  _ __
||  (O)  ||   | |  | || '_ \ | | / __|| | | | / __|| | / _ \| '__|
\\    \_ //   | |__| || | | || || (__ | |_| || (__ | ||  __/| |
 \\_____//     \____/ |_| |_||_| \___| \__, | \___||_| \___||_|
                                        __/ |
                                       |___/

Unicycler: an assembly pipeline for bacterial genomes
```

We can start the assembly then:

```console
nohup unicycler -t 4 -o Unicylcler.nanopore.dir -l k_p.nanopre.fastq.gz > unicylcer.log &
```

Once Unicycler has finished it will create the ```Unicylcler.nanopore.dir```. Let's take a look:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Unicyler]$ cd Unicylcler.nanopore.dir/
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Unicylcler.nanopore.dir]$ ls -l
total 37924
-rw-rw-r-- 1 avera2020 avera2020 16309656 May 31 12:03 001_string_graph.gfa
-rw-rw-r-- 1 avera2020 avera2020  5536912 May 31 12:03 002_unitig_graph.gfa
-rw-rw-r-- 1 avera2020 avera2020  5630892 May 31 12:11 003_racon_polished.gfa
-rw-rw-r-- 1 avera2020 avera2020  5710952 May 31 12:13 assembly.fasta
-rw-rw-r-- 1 avera2020 avera2020  5630892 May 31 12:13 assembly.gfa
-rw-rw-r-- 1 avera2020 avera2020     4201 May 31 12:13 unicycler.log
```

From the multiple files our final assembly is the ```assembly.fasta``` but also generates a graph the ```asembly.gfa```

We can then calculate the assembly-stats

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Unicylcler.nanopore.dir]$ assembly-stats assembly.fasta 
stats for assembly.fasta
sum = 5630486, n = 9, ave = 625609.56, largest = 2197670
N50 = 1090721, n = 2
N60 = 817786, n = 3
N70 = 817786, n = 3
N80 = 524838, n = 4
N90 = 311484, n = 6
N100 = 33187, n = 9
N_count = 0
Gaps = 0
```

**Is there any difference between this assembly and the Illumina one ?**

As with the SPADES we can also claculate the completenes with busco:

```console
nohup busco -i assembly.fasta --auto-lineage-prok -m geno -o Illumina.busco -c 4 &
```

In the mean time let's take a look of our graph assembly in Bandage. Remember to scp your file to your computer:


```console
(base) avera@L003772:Genome_Assembly.May.2021$ scp avera2020@148.204.124.131:/home/avera/Genome_Assembly.May.2021.old/RawReads.dir/Nanopore/Unicyler/Unicylcler.nanopore.dir/assembly.gfa .
Password: 
assembly.gfa                                                                                         100% 5499KB   2.7MB/s   00:02
avera@L003772:Genome_Assembly.May.2021$ Bandage load assembly.gfa
```

And draw the graph:

![Unic](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/graphunic.png)




