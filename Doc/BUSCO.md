# Genome completeness assessment by single-copy orthologs

Once we have our best genome filtered we can evaluet how complete is our draft (by contigs or scaffolds) running [BUSCO](https://busco.ezlab.org/)

So now let's use those contigs from assembly of reads form quality of Q>=22 and trimmed in a lenght > 1000 nt to perform the completeness prediction.

**BUSCO looks for a certain number of orthologous genes and counts the total of these ortholog genes present in your genome. That way it can estimate the completeness. For example if the database has 10 genes and BUSCO find 9 of them in your genome it scores a completeness of 90 %.**

### As busco uses genes we need to predict the codifying sequences of genes in our genome. BUSCO was developed to find genes in eukaryotes and uses Augustus to predic genes, but augustus is not well suitable to predic genes in prokariotic genenomes. So we are going to use prodigal to predic genes in our genome. In this session we will not disscuss prodigal we are only using as it. In further sessions a more deep explainaton about prodigal will be given.

First let's create a directory and a symbolic link of our contigs

```console
(base) [veraponcedeleon.1@unity-1 DacB20]$ mkdir BUSCO
(base) [veraponcedeleon.1@unity-1 DacB20]$ cd BUSCO/
(base) [veraponcedeleon.1@unity-1 BUSCO]$ ln -s ../contig.1000.fa .
(base) [veraponcedeleon.1@unity-1 BUSCO]$ ls -l
total 0
lrwxrwxrwx 1 veraponcedeleon.1 research-eeob-sabree 17 May 21 16:08 contig.1000.fa -> ../contig.1000.fa
```
Now we need to predic the codifying sequences using prodigal like this

```console
(base) [veraponcedeleon.1@unity-1 BUSCO]$ prodigal -a contig.1000.fa.amino.faa -d contig.1000.fa.cds.ffn -o prodigal.out -i contig.1000.fa
```

Prodigal generates three files: 

* the genes in aminoacid translated contig.1000.fa.amino.faa
* the genes in nucleotid format contig.1000.fa.cds.ffn
* and a general output prodigal.out

```console
(base) [veraponcedeleon.1@unity-1 BUSCO]$ ls
contig.1000.fa  contig.1000.fa.amino.faa  contig.1000.fa.cds.ffn  prodigal.out
```

Let's see the first 2 lines of these files:
```console
head -2 *
==> contig.1000.fa.amino.faa <==
>contig-100_0_1 # 1 # 438 # -1 # ID=1_1;partial=10;start_type=ATG;rbs_motif=None;rbs_spacer=None;gc_cont=0.594
MIHISSQFDSGNIEIRDARDPTNVRLAIRHDAGGVFMQWFHFRLHGVRGQPLRLVIENAG

==> contig.1000.fa.cds.ffn <==
>contig-100_0_1 # 1 # 438 # -1 # ID=1_1;partial=10;start_type=ATG;rbs_motif=None;rbs_spacer=None;gc_cont=0.594
ATGATCCATATCAGCAGCCAGTTCGATAGCGGCAACATCGAGATCCGGGATGCACGGGATCCCACCAACG

==> prodigal.out <==
DEFINITION  seqnum=1;seqlen=38881;seqhdr="contig-100_0 length_38881 read_count_10598	38881";version=Prodigal.v2.6.3;run_type=Single;model="Ab initio";gc_cont=62.67;transl_table=11;uses_sd=1
FEATURES             Location/Qualifiers
```

Now we have the genes and we can use BUSCO to find the orthologs in our genome.

But what orthologs we are looking for? Well BUSCO has developed a common orthologs clusters for different organisims:
![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/busco.png)

So we need to download the closest orthologs group to our genome. In this example we are using a genome of bacteria and we are comparing our genome to bacteria dataset.

Once you have downloaded and decompressed the bacteria dataset 

```console
$ wget https://busco.ezlab.org/datasets/bacteria_odb9.tar.gz .
tar -xzvf bacteria_odb9.tar.gz
```

you can run busco:

*First take a look to the parameters

```console
(base) [veraponcedeleon.1@unity-1 BUSCO]$ ~/bin/busco/scripts/run_BUSCO.py -h
usage: python BUSCO.py -i [SEQUENCE_FILE] -l [LINEAGE] -o [OUTPUT_NAME] -m [MODE] [OTHER OPTIONS]

Welcome to BUSCO 3.0.2: the Benchmarking Universal Single-Copy Ortholog assessment tool.
For more detailed usage information, please review the README file provided with this distribution and the BUSCO user guide.

optional arguments:
  -i FASTA FILE, --in FASTA FILE
                        Input sequence file in FASTA format. Can be an assembled genome or transcriptome (DNA), or protein sequences from an annotated gene set.
  -c N, --cpu N         Specify the number (N=integer) of threads/cores to use.
  -o OUTPUT, --out OUTPUT
                        Give your analysis run a recognisable short name. Output folders and files will be labelled with this name. WARNING: do not provide a path
  -e N, --evalue N      E-value cutoff for BLAST searches. Allowed formats, 0.001 or 1e-03 (Default: 1e-03)
  -m MODE, --mode MODE  Specify which BUSCO analysis mode to run.
                        There are three valid modes:
                        - geno or genome, for genome assemblies (DNA)
                        - tran or transcriptome, for transcriptome assemblies (DNA)
                        - prot or proteins, for annotated gene sets (protein)
  -l LINEAGE, --lineage_path LINEAGE
                        Specify location of the BUSCO lineage data to be used.
                        Visit http://busco.ezlab.org for available lineages.
  -f, --force           Force rewriting of existing files. Must be used when output files with the provided name already exist.
  -r, --restart         Restart an uncompleted run. Not available for the protein mode
  -sp SPECIES, --species SPECIES
                        Name of existing Augustus species gene finding parameters. See Augustus documentation for available options.
  --augustus_parameters AUGUSTUS_PARAMETERS
                        Additional parameters for the fine-tuning of Augustus run. For the species, do not use this option.
                        Use single quotes as follow: '--param1=1 --param2=2', see Augustus documentation for available options.
  -t PATH, --tmp_path PATH
                        Where to store temporary files (Default: ./tmp/)
  --limit REGION_LIMIT  How many candidate regions (contig or transcript) to consider per BUSCO (default: 3)
  --long                Optimization mode Augustus self-training (Default: Off) adds considerably to the run time, but can improve results for some non-model organisms
  -q, --quiet           Disable the info logs, displays only errors
  -z, --tarzip          Tarzip the output folders likely to contain thousands of files
  --blast_single_core   Force tblastn to run on a single core and ignore the --cpu argument for this step only. Useful if inconsistencies when using multiple threads are noticed
  -v, --version         Show this version and exit
  -h, --help            Show this help message and exit
```
Basically we need the genome, the linage (it means the orthologs seqs) the output and if our genome is given as nucleotides (-m geno) or amino acids (-m prot). As we have already predicted the amino acid sequences of our genome, we indicate -m prot this way BUSCO is not running augustus to predict genes.
```console
(base) [veraponcedeleon.1@unity-1 BUSCO]$ ~/bin/busco/scripts/run_BUSCO.py -i contig.1000.fa.amino.faa -m prot -l /fs/project/obcp/veraponcedelon.1/database/BUSCOS/bacteria_odb9 -o busco -c 4
INFO	****************** Start a BUSCO 3.0.2 analysis, current time: 05/21/2019 16:28:15 ******************
INFO	Configuration loaded from /home/veraponcedeleon.1/bin/busco/scripts/../config/config.ini
INFO	Init tools...
INFO	Check dependencies...
INFO	Check input file...
INFO	To reproduce this run: python /home/veraponcedeleon.1/bin/busco/scripts/run_BUSCO.py -i contig.1000.fa.amino.faa -o busco -l /fs/project/obcp/veraponcedelon.1/database/BUSCOS/bacteria_odb9/ -m proteins -c 4
INFO	Mode is: proteins
INFO	The lineage dataset is: bacteria_odb9 (prokaryota)
INFO	Temp directory is ./tmp/
INFO	Running HMMER on the proteins:
INFO	[hmmsearch]	15 of 148 task(s) completed at 05/21/2019 16:28:16
INFO	[hmmsearch]	30 of 148 task(s) completed at 05/21/2019 16:28:16
INFO	[hmmsearch]	45 of 148 task(s) completed at 05/21/2019 16:28:16
INFO	[hmmsearch]	60 of 148 task(s) completed at 05/21/2019 16:28:16
INFO	[hmmsearch]	75 of 148 task(s) completed at 05/21/2019 16:28:16
INFO	[hmmsearch]	89 of 148 task(s) completed at 05/21/2019 16:28:16
INFO	[hmmsearch]	104 of 148 task(s) completed at 05/21/2019 16:28:17
INFO	[hmmsearch]	119 of 148 task(s) completed at 05/21/2019 16:28:17
INFO	[hmmsearch]	134 of 148 task(s) completed at 05/21/2019 16:28:17
INFO	[hmmsearch]	148 of 148 task(s) completed at 05/21/2019 16:28:17
INFO	Results:
INFO	C:95.2%[S:93.2%,D:2.0%],F:2.0%,M:2.8%,n:148
INFO	141 Complete BUSCOs (C)
INFO	138 Complete and single-copy BUSCOs (S)
INFO	3 Complete and duplicated BUSCOs (D)
INFO	3 Fragmented BUSCOs (F)
INFO	4 Missing BUSCOs (M)
INFO	148 Total BUSCO groups searched
INFO	BUSCO analysis done. Total running time: 1.9100420475 seconds
INFO	Results written in /fs/project/obcp/veraponcedelon.1/Class_May_2019/IDBA/DacBQ22/DacB20/BUSCO/run_busco/
```
*I am using 4 cpus this is why -c 4*

**The result is given in the standar output (the screen) as:

* INFO	Results:
* INFO	C:95.2%[S:93.2%,D:2.0%],F:2.0%,M:2.8%,n:148
* INFO	141 Complete BUSCOs (C)
* INFO	138 Complete and single-copy BUSCOs (S)
* INFO	3 Complete and duplicated BUSCOs (D)
* INFO	3 Fragmented BUSCOs (F)
* INFO	4 Missing BUSCOs (M)
* INFO	148 Total BUSCO groups searched

However BUSCO also creates two directories 

```console
(base) [veraponcedeleon.1@unity-1 BUSCO]$ ls
contig.1000.fa  contig.1000.fa.amino.faa  contig.1000.fa.cds.ffn  prodigal.out  run_busco  tmp
```

The run_busco and the tmp there you will find the results as well.

```console
(base) [veraponcedeleon.1@unity-1 BUSCO]$ cd run_busco/
(base) [veraponcedeleon.1@unity-1 run_busco]$ more short_summary_busco.txt 
# BUSCO version is: 3.0.2 
# The lineage dataset is: bacteria_odb9 (Creation date: 2016-11-01, number of species: 3663, number of BUSCOs: 148)
# To reproduce this run: python /home/veraponcedeleon.1/bin/busco/scripts/run_BUSCO.py -i contig.1000.fa.amino.faa -o busco -l /fs/project/obcp/veraponcedelon.1/database/BUSCOS/bacteria_od
b9/ -m proteins -c 4
#
# Summarized benchmarking in BUSCO notation for file contig.1000.fa.amino.faa
# BUSCO was run in mode: proteins

	C:95.2%[S:93.2%,D:2.0%],F:2.0%,M:2.8%,n:148

	141	Complete BUSCOs (C)
	138	Complete and single-copy BUSCOs (S)
	3	Complete and duplicated BUSCOs (D)
	3	Fragmented BUSCOs (F)
	4	Missing BUSCOs (M)
	148	Total BUSCO groups searched
```

**Now we can notice that our genome is not complete, at least using the total bacteria database there are 4 missing orthologs genes not present in this genome.**

If you have more information about the taxonomy of your genome you can use a more narrow sarch for orthologs. In this case I know that DacBet data came from a Beta proteobacteria so I downloaded the Betaproteobacteria BUSCO data set

```console

(base) [veraponcedeleon.1@unity-1 BUSCOS]$ wget https://busco.ezlab.org/datasets/betaproteobacteria_odb9.tar.gz
base) [veraponcedeleon.1@unity-1 BUSCOS]$ tar -xzvf betaproteobacteria_odb9.tar.gz
```

And run busco using this data base

```console
(base) [veraponcedeleon.1@unity-1 BUSCO]$ ~/bin/busco/scripts/run_BUSCO.py -i contig.1000.fa.amino.faa -m prot -l /fs/project/obcp/veraponcedelon.1/database/BUSCOS/betaproteobacteria_odb9 -o beta_bacteria_busco -c 4
INFO	****************** Start a BUSCO 3.0.2 analysis, current time: 05/21/2019 16:36:04 ******************
INFO	Configuration loaded from /home/veraponcedeleon.1/bin/busco/scripts/../config/config.ini
INFO	Init tools...
INFO	Check dependencies...
INFO	Check input file...
INFO	To reproduce this run: python /home/veraponcedeleon.1/bin/busco/scripts/run_BUSCO.py -i contig.1000.fa.amino.faa -o beta_bacteria_busco -l /fs/project/obcp/veraponcedelon.1/database/BUSCOS/betaproteobacteria_odb9/ -m proteins -c 4
INFO	Mode is: proteins
INFO	The lineage dataset is: betaproteobacteria_odb9 (prokaryota)
INFO	Temp directory is ./tmp/
INFO	Running HMMER on the proteins:
INFO	[hmmsearch]	59 of 582 task(s) completed at 05/21/2019 16:36:05
INFO	[hmmsearch]	117 of 582 task(s) completed at 05/21/2019 16:36:06
INFO	[hmmsearch]	175 of 582 task(s) completed at 05/21/2019 16:36:06
INFO	[hmmsearch]	233 of 582 task(s) completed at 05/21/2019 16:36:07
INFO	[hmmsearch]	292 of 582 task(s) completed at 05/21/2019 16:36:08
INFO	[hmmsearch]	350 of 582 task(s) completed at 05/21/2019 16:36:09
INFO	[hmmsearch]	408 of 582 task(s) completed at 05/21/2019 16:36:10
INFO	[hmmsearch]	466 of 582 task(s) completed at 05/21/2019 16:36:10
INFO	[hmmsearch]	524 of 582 task(s) completed at 05/21/2019 16:36:11
INFO	[hmmsearch]	582 of 582 task(s) completed at 05/21/2019 16:36:12
INFO	Results:
INFO	C:93.0%[S:92.8%,D:0.2%],F:4.8%,M:2.2%,n:582
INFO	541 Complete BUSCOs (C)
INFO	540 Complete and single-copy BUSCOs (S)
INFO	1 Complete and duplicated BUSCOs (D)
INFO	28 Fragmented BUSCOs (F)
INFO	13 Missing BUSCOs (M)
INFO	582 Total BUSCO groups searched
INFO	BUSCO analysis done. Total running time: 8.01606297493 seconds
INFO	Results written in /fs/project/obcp/veraponcedelon.1/Class_May_2019/IDBA/DacBQ22/DacB20/BUSCO/run_beta_bacteria_busco/
```

As you see now the BUSCO completeness is less than the previous one, this is due to there are more orthologs to look. 

**Using this we can estimate that our assembly is between 93 - 96 % of completeness.**

