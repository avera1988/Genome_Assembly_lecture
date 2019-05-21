# Genome completeness assessment by single-copy orthologs

Once we have our best genome filtered we can evaluet how complete is our draft (by contigs or scaffolds) running [BUSCO](https://busco.ezlab.org/)

So now let's use those contigs from assembly of reads form quality of Q>=22 and trimmed in a lenght > 1000 nt to perform the completeness prediction.

**BUSCO looks for a certain number of orthologous genes and counts the total of these ortholog genes present in your genome. That way it can estimate the completeness. For example if the database has 10 genes and BUSCO find 9 of them in your genome it scores a completeness of 90 %.**

### As busco uses genes we need to predict the codifying sequences of genes in our genome. BUSCO was developed to find genes in eukaryotesand uses Augustus to predic genes, but augustus is not well suitable to predic genes in prokariotic genenoes. So we are going to use prodigal to predic genes in our genome. In this session we will not disscuss prodigal we are only using as it. In further sessions a more deep explainaton about prodigal will be given.

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

```console
(base) [veraponcedeleon.1@unity-1 BUSCO]$ ~/bin/busco/scripts/run_BUSCO.py -i contig.1000.fa.amino.faa -m prot -l /fs/project/obcp/veraponcedelon.1/database/BUSCOS/bacteria_odb9 -o busco -c 4
```
