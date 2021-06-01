# Genome completeness assessment by single-copy orthologs

Once we have our best genome filtered we can evaluet how complete is our draft (by contigs or scaffolds) running [BUSCO](https://busco.ezlab.org/)

So now let's use those contigs from IDBA assembly trimmed in a lenght >= 900 nt to perform the completeness prediction.

**BUSCO looks for a certain number of orthologous genes and counts the total of these ortholog genes present in your genome. That way it can estimate the completeness. For example if the database has 10 genes and BUSCO finds 9 of them in your genome it scores a completeness of 90 %.**

### As busco uses genes we need to predict the codifying sequences of genes in our genome. BUSCO was developed to find genes in eukaryotes and uses Augustus to predict genes, but augustus is not well suitable to predict genes in prokaryotic genomes. So we are going to use prodigal to predict genes in our genome. In this session we will not disscuss prodigal we are only using as it. In further sessions a more deep explainaton about prodigal will be given.

First let's create a directory and a symbolic link of our contigs

```console
$ mkdir BUSCO
$ cd BUSCO/ 
$ ln -s ../contig.900.fa .
```
Now we need to predict the codifying sequences using prodigal like this

```console
$ prodigal -a contig.900.fa.amino.faa -d contig.900.fa.cds.ffn -o prodigal.out -i contig.900.fa
```

Prodigal generates three files: 

* the genes in aminoacid translated contig.900.fa.amino.faa
* the genes in nucleotid format contig.900.fa.cds.ffn
* and a general output prodigal.out

```console
$ ls
contig.900.fa  contig.900.fa.amino.faa  contig.900.fa.cds.ffn  prodigal.out
```

Let's see the first 2 lines of these files:
```console
$ head -2 *
==> contig.900.fa.amino.faa <==
>contig-100_0_1 # 1 # 5040 # -1 # ID=1_1;partial=10;start_type=ATG;rbs_motif=GGAG/GAGG;rbs_spacer=5-10bp;gc_cont=0.326
MRKNDIEKSLKRFLKRKISYSLSLLIAFMITGGISFGAGITTEEIQETKNDILTRIETER

==> contig.900.fa.cds.ffn <==
>contig-100_0_1 # 1 # 5040 # -1 # ID=1_1;partial=10;start_type=ATG;rbs_motif=GGAG/GAGG;rbs_spacer=5-10bp;gc_cont=0.326
ATGAGAAAAAATGATATTGAAAAATCTTTAAAAAGATTTTTGAAAAGAAAAATTAGTTACTCTCTTTCAC

==> prodigal.out <==
DEFINITION  seqnum=1;seqlen=219803;seqhdr="contig-100_0 length_219803 read_count_133621	219803";version=Prodigal.v2.6.3;run_type=Single;model="Ab initio";gc_cont=30.33;transl_table=11;uses_sd=1
FEATURES             Location/Qualifiers
```

Now we have the genes and we can use BUSCO to find the orthologs in our genome.

But what orthologs we are looking for? Well BUSCO has developed a common orthologs clusters for different organisims:
![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/busco.png)

In previous versions the user has to download the dataset in new Busco version it automatically download the bacteria or euk datasates and compare the buscos. 

Now we can run busco:

*First take a look the parameters*

```console
busco --help
usage: busco -i [SEQUENCE_FILE] -l [LINEAGE] -o [OUTPUT_NAME] -m [MODE] [OTHER OPTIONS]

Welcome to BUSCO 4.0.6: the Benchmarking Universal Single-Copy Ortholog assessment tool.
For more detailed usage information, please review the README file provided with this distribution and the BUSCO user guide.

optional arguments:
  -i FASTA FILE, --in FASTA FILE
                        Input sequence file in FASTA format. Can be an assembled genome or transcriptome (DNA), or protein sequences from an annotated gene set.
  -c N, --cpu N         Specify the number (N=integer) of threads/cores to use.
  -o OUTPUT, --out OUTPUT
                        Give your analysis run a recognisable short name. Output folders and files will be labelled with this name. WARNING: do not provide a path
  --out_path OUTPUT_PATH
                        Optional location for results folder, excluding results folder name. Default is current working directory.
  -e N, --evalue N      E-value cutoff for BLAST searches. Allowed formats, 0.001 or 1e-03 (Default: 1e-03)
  -m MODE, --mode MODE  Specify which BUSCO analysis mode to run.
                        There are three valid modes:
                        - geno or genome, for genome assemblies (DNA)
                        - tran or transcriptome, for transcriptome assemblies (DNA)
                        - prot or proteins, for annotated gene sets (protein)
  -l LINEAGE, --lineage_dataset LINEAGE
                        Specify the name of the BUSCO lineage to be used.
  -f, --force           Force rewriting of existing files. Must be used when output files with the provided name already exist.
  --limit REGION_LIMIT  How many candidate regions (contig or transcript) to consider per BUSCO (default: 3)
  --long                Optimization mode Augustus self-training (Default: Off) adds considerably to the run time, but can improve results for some non-model organisms
  -q, --quiet           Disable the info logs, displays only errors
  --augustus_parameters AUGUSTUS_PARAMETERS
                        Pass additional arguments to Augustus. All arguments should be contained within a single pair of quotation marks, separated by commas. E.g. '--param1=1,--param2=2'
  --augustus_species AUGUSTUS_SPECIES
                        Specify a species for Augustus training.
  --auto-lineage        Run auto-lineage to find optimum lineage path
  --auto-lineage-prok   Run auto-lineage just on non-eukaryote trees to find optimum lineage path
  --auto-lineage-euk    Run auto-placement just on eukaryote tree to find optimum lineage path
  --update-data         Download and replace with last versions all lineages datasets and files necessary to their automated selection
  --offline             To indicate that BUSCO cannot attempt to download files
  --config CONFIG_FILE  Provide a config file
  -v, --version         Show this version and exit
  -h, --help            Show this help message and exit
  --list-datasets       Print the list of available BUSCO datasets

```
Basically we need the genome, the linage (it means the orthologs seqs) the output and if our genome is given as nucleotides (-m geno) or amino acids (-m prot). As we have already predicted the amino acid sequences of our genome, we indicate -m prot this way BUSCO is not running augustus to predict genes. Additionally we can indicate busco to automatically download the prokariotic datasets (*require internet connection*) and calculate the completeness with the --auto-lineage-prok

Run the command:

```console
busco -m prot --auto-lineage-prok -o 51.busco -c 4 -i contig.900.fa.amino.faa 
INFO:	***** Start a BUSCO v4.0.6 analysis, current time: 05/07/2020 15:39:52 *****
INFO:	Configuring BUSCO with /home/avera/miniconda3/envs/GenomeAssemblyModule/config/config.ini
INFO:	Mode is proteins
INFO:	Input file is contig.900.fa.amino.faa
INFO:	Downloading information on latest versions of BUSCO data...
INFO:	No lineage specified. Running lineage auto selector.

INFO:	***** Starting Auto Select Lineage *****
	This process runs BUSCO on the generic lineage datasets for the domains archaea, bacteria and eukaryota. Once the optimal domain is selected, BUSCO automatically attempts to find the most appropriate BUSCO dataset to use based on phylogenetic placement.
	--auto-lineage-euk and --auto-lineage-prok are also available if you know your input assembly is, or is not, an eukaryote. See the user guide for more information.
	A reminder: Busco evaluations are valid when an appropriate dataset is used, i.e., the dataset belongs to the lineage of the species to test. Because of overlapping markers/spurious matches among domains, busco matches in another domain do not necessarily mean that your genome/proteome contains sequences from this domain. However, a high busco score in multiple domains might help you identify possible contaminations.
```
*I am using 4 cpus this is why -c 4*

**The result is given in the standar output (the screen) as:**

INFO:	

	--------------------------------------------------
	|Results from generic domain bacteria_odb10       |
	--------------------------------------------------
	|C:96.8%[S:95.2%,D:1.6%],F:0.8%,M:2.4%,n:124      |
	|120	Complete BUSCOs (C)                       |
	|118	Complete and single-copy BUSCOs (S)       |
	|2	Complete and duplicated BUSCOs (D)        |
	|1	Fragmented BUSCOs (F)                     |
	|3	Missing BUSCOs (M)                        |
	|124	Total BUSCO groups searched               |
	--------------------------------------------------

	--------------------------------------------------
	|Results from dataset mycoplasmatales_odb10       |
	--------------------------------------------------
	|C:79.3%[S:77.0%,D:2.3%],F:1.7%,M:19.0%,n:174     |
	|138	Complete BUSCOs (C)                       |
	|134	Complete and single-copy BUSCOs (S)       |
	|4	Complete and duplicated BUSCOs (D)        |
	|3	Fragmented BUSCOs (F)                     |
	|33	Missing BUSCOs (M)                        |
	|174	Total BUSCO groups searched               |
	--------------------------------------------------
INFO:	BUSCO analysis done. Total running time: 199 seconds
INFO:	Results written in /mnt/c/Users/avera/Ubuntu_files/Project/IPN/BioinfoClass/FastQC/Raw_reads/Illumina/51/IDBA/51.idba.dir/BUSCO/51.busco

However BUSCO also saves all this info into a directory .busco and all the downloads into busco_downloads

```console
$ ls
51.busco  busco_downloads  contig.900.fa  contig.900.fa.amino.faa  contig.900.fa.cds.ffn  prodigal.out
```
Entering to the busco dir
```console
$ cd 51.busco/
$ ls
auto_lineage  logs  run_bacteria_odb10  run_mycoplasmatales_odb10  short_summary.generic.bacteria_odb10.51.busco.txt  short_summary.specific.mycoplasmatales_odb10.51.busco.txt
more short_summary.generic.bacteria_odb10.51.busco.txt 
# BUSCO version is: 4.0.6 
# The lineage dataset is: bacteria_odb10 (Creation date: 2019-06-26, number of species: 4085, number of BUSCOs: 124)
# Summarized benchmarking in BUSCO notation for file contig.900.fa.amino.faa
# BUSCO was run in mode: proteins

	***** Results: *****

	C:96.8%[S:95.2%,D:1.6%],F:0.8%,M:2.4%,n:124	   
	120	Complete BUSCOs (C)			   
	118	Complete and single-copy BUSCOs (S)	   
	2	Complete and duplicated BUSCOs (D)	   
	1	Fragmented BUSCOs (F)			   
	3	Missing BUSCOs (M)			   
	124	Total BUSCO groups searched		
```

**Now we can notice that our genome is not complete, at least using the total bacteria database there are 3 missing orthologs genes not present in this genome also a possible contamination of Mollicutes can be present!**

