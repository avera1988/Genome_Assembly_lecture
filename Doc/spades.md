# Here you will find the code for using SPADES assembler

### First we need to create a directory named SPADES and move the TrimGalore with q=30   filtred DacBet fastq files.
**As fastq files sometimes are quite large, it is recommendable to use a symbolic (soft) link instead a real (hard) copy**

```console
$ mkdir SPADES
$ ln -s TrimGalore/51*val*fq .
 ```
Now load the GenomeAssemblyModule environment and invoke spades
```console
$ conda activate GenomeAssemblyModule

spades.py --help
SPAdes genome assembler v3.14.0

Usage: spades.py [options] -o <output_dir> 
```
Running spades

```console
$ nohup time spades.py -1 51_R1_val_1.fq -2 51_R2_val_2.fq -t 4 -o 51.spades.dir &
```

*As spades will take a time to run, I highly recommend to use the nohoup command and then & to run it in the background. The time command will tell you how long your job takes to complete*

Once finished a new 51.spades.dir will be created

```console
$ ls
51_R1_val_1.fq  51_R2_val_2.fq  51.spades.dir  nohup.out
$ cd 51.spades.dir/
$ ls
assembly_graph.fastg               before_rr.fasta  contigs.paths  dataset.info        K21  K55   params.txt      run_spades.sh    scaffolds.fasta  spades.log  warnings.log
assembly_graph_with_scaffolds.gfa  contigs.fasta    corrected      input_dataset.yaml  K33  misc  pipeline_state  run_spades.yaml  scaffolds.paths  tmp
```
 **Take a look into the basic assembly statistics**

```console
/Genome_Assembly_lecture/Scripts/assembly-stats/assembly-stats contigs.fasta 
stats for contigs.fasta
sum = 3736674, n = 431, ave = 8669.78, largest = 251295
N50 = 98476, n = 11
N60 = 73669, n = 15
N70 = 60733, n = 20
N80 = 43528, n = 28
N90 = 23983, n = 39
N100 = 56, n = 431
N_count = 0
Gaps = 0
```
We can also see the coverage, such as in IDBA. But with SPADES we have the advantage that the coverage now is printed in the header, let's take a look
```console
head -1 contigs.fasta 
>NODE_1_length_251295_cov_55.065965
```
Following the same idea as in IDBA let's obtain the coverage for SPADES assembly

```console
perl ~/Genome_Assembly_lecture/Scripts/cambia_seqs_unalinea.pl contigs.fasta > contigs.one.fasta
perl ~/Genome_Assembly_lecture/Scripts/coverage.spades.pl contigs.one.fasta 
contigs.one.fasta coverage=	45.969
```

Acording to the stats there are many contings (431) with a length of 56 this is less than a read so we can remove all those short contigs to >= 900 nt 

```console
perl ~/Genome_Assembly_lecture/Scripts/trimm_len.pl contigs.one.fasta 900|sed 's/\t/_/g'  > contigs.900.fasta
```
*As the scritp keep a tab in the header we need to remove it with sed*


Now we can check the coverage stats

```console
perl ~/Genome_Assembly_lecture/Scripts/coverage.spades.pl contigs.900.fasta 
contigs.900.fasta coverage=	71.065
```
Now you can see how the average coverage improves significativelly removing these short contigs

**Visualization of the assembly graph to detect circular replicons and quality value using Bandage**

An advantage to use Spades as assembler is due to it gives us a file assembly_graph.fastg with all the nodes and edges of the graph

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
Bandage l assembly_graph.fastg
```
An then click to Draw graph

![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/Bandage.png)

It shows us the graphic representation of our assembly, we now can play and ask Bandage to show us for example all contigs with a coverage (deep) range between 5 and 20 X


*Click to scope deep range and then set up the min and max to 5.0 and 20.0*


![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/graph.png)

A small circular replicon is appreciated at the botom of the image, this can be a plasmid or virus.

Now let's take a look into an E. coli assembly, a bacteria with plasmids!

![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/BandageEcoli.png)

As you can see there is a big graph and a circular one. This small one could be a plasmid. We can slect a contig and perform a BlastX to know if there is any gene related to replication or plasmid.

![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/BandageBlast.png)

After Blast search it seems this "cicular" graph has conjugative elements genes, suggesting a possible plasmid presence and assembly.

![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/Blast.png)
