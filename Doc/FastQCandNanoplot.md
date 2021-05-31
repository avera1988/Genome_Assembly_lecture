# Instructions to create FastQC reports using multiple Illumina fastq files

1. using the SSH comand conect to 148.204.124.131 server:
```console
$(base) avera@L003772:~$ ssh avera2020@148.204.124.131
Password:
```

2. Create a directory in the ```/home``` folder named: ```/home/user/Genome_Assembly.May.2021```

```console
(base) [avera2020@pc-124-131 ~]$ cd /home
(base) [avera2020@pc-124-131 home]$ cd avera/
(base) [avera2020@pc-124-131 avera]$ mkdir Genome_Assembly.May.2021
(base) [avera2020@pc-124-131 avera]$ ls -1
Genome_Assembly.May.2021
```

3. Copy the RawFiles.dir forme ```/home/avera2020/GenomeAssembly/Data/RawReads.dir``` to your ```directory /home/user/Genome_Assembly.May.2021```

```console
(base) [avera2020@pc-124-131 Genome_Assembly.May.2021]$ cp -r /home/avera/GenomeAssembly/Data/RawReads.dir/ .
(base) [avera2020@pc-124-131 Genome_Assembly.May.2021]$ ls -l
total 4
drwxrwxr-x 4 avera2020 avera2020 4096 May 30 14:53 RawReads.dir
```

4. Take a look of the files in ```RawReads.dir/Illumina``` 
```console
(base) [avera2020@pc-124-131 Genome_Assembly.May.2021]$ cd RawReads.dir/
(base) [avera2020@pc-124-131 RawReads.dir]$ ls
Illumina  Nanopore
(base) [avera2020@pc-124-131 RawReads.dir]$ cd Illumina/
(base) [avera2020@pc-124-131 Illumina]$ ls
k_p.illumina.ERR1015321_1.fastq.gz  k_p.illumina.ERR1015321_2.fastq.gz
```

5. and take a look of the sequences header:

```console
(base) [avera2020@pc-124-131 Illumina]$ zmore k_p.illumina.ERR1015321_1.fastq.gz |head -5
------> k_p.illumina.ERR1015321_1.fastq.gz <------
@ERR1015321.1 1 length=125
TTCTGTGGCTGGTAACTCATCCTGCAATCGGGCAAGACACTGCTGCCAAAGCGAAAGTGACACGGCGGACTCCACTCGAACATAAAATCGATATCAAAGAAAAACAGAAACAATCATGATTGTTG
+ERR1015321.1 1 length=125
BBBBBFBFFBBFFFFFBFFFFFF/BF/<<BFFBF<BFBFF/<<F/<B//</F<<F/<//</FF/FFFF<<FFFFFFFFFFFFFFFF<7<BFBB7/7BFFFFBFFFFFF<FFFFFF<7FFF<FF/B
```

**This is how a fastq sequence looks like:**
* Sequnece name
* Sequence
* \+ plus some information
* Quality

6. To run FASTQC, we need to load a conda environment where all the software are installed to do this type the next lines into your terminal:

```console
(base) [avera2020@pc-124-131 Illumina]$ conda activate /home/avera/condaenv/GenomeAssemblyModule/
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Illumina]$
```
*As you noticed the promt has changed and now it displays ```/home/avera/condaenv/GenomeAssemblyModule``` before your user name, if you are able to see this the conda env is correctly loaded*

## FastQC 

This software is programed in java so it has a graphic user interfase (GUI) like this:
```console
$ fastqc
```
![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/fastqcconsole.png)

However as we will be working in the server sometimes is not convenient to use the GUI but the command-line interfase (CLI):

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Illumina]$ fastqc --help

            FastQC - A high throughput sequence QC analysis tool

SYNOPSIS

	fastqc seqfile1 seqfile2 .. seqfileN

    fastqc [-o output dir] [--(no)extract] [-f fastq|bam|sam] 
           [-c contaminant file] seqfile1 .. seqfileN
```

### Let's create a subdirectory here to run FastQC

1. create directory
```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Illumina]$ mkdir Fastqc.dir
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Illumina]$ cd Fastqc.dir/
```
2. Then let's create a symbolic link (shortcut) of the reads (files) here:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Fastqc.dir]$ ln -s ../*.gz .
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Fastqc.dir]$ ls -lrth
total 0
lrwxrwxrwx 1 avera2020 avera2020 37 May 30 15:06 k_p.illumina.ERR1015321_2.fastq.gz -> ../k_p.illumina.ERR1015321_2.fastq.gz
lrwxrwxrwx 1 avera2020 avera2020 37 May 30 15:06 k_p.illumina.ERR1015321_1.fastq.gz -> ../k_p.illumina.ERR1015321_1.fastq.gz
```

3. Finaly we can run FastQC

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Fastqc.dir]$ fastqc -t 4 --extract -f fastq *.gz
```

4. Now we can check the resulting files:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Fastqc.dir]$ ls -lrth
total 1.8M
lrwxrwxrwx 1 avera2020 avera2020   37 May 30 15:06 k_p.illumina.ERR1015321_2.fastq.gz -> ../k_p.illumina.ERR1015321_2.fastq.gz
lrwxrwxrwx 1 avera2020 avera2020   37 May 30 15:06 k_p.illumina.ERR1015321_1.fastq.gz -> ../k_p.illumina.ERR1015321_1.fastq.gz
-rw-rw-r-- 1 avera2020 avera2020 289K May 30 15:11 k_p.illumina.ERR1015321_1_fastqc.zip
-rw-rw-r-- 1 avera2020 avera2020 604K May 30 15:11 k_p.illumina.ERR1015321_1_fastqc.html
drwxrwxr-x 4 avera2020 avera2020 4.0K May 30 15:11 k_p.illumina.ERR1015321_1_fastqc
-rw-rw-r-- 1 avera2020 avera2020 295K May 30 15:11 k_p.illumina.ERR1015321_2_fastqc.zip
-rw-rw-r-- 1 avera2020 avera2020 616K May 30 15:11 k_p.illumina.ERR1015321_2_fastqc.html
drwxrwxr-x 4 avera2020 avera2020 4.0K May 30 15:11 k_p.illumina.ERR1015321_2_fastqc
```

FastQC will create 3 files:

* An html report
* A directory with all the files and results
* A compressed (zip) file with all this results

5. To be able to look into the report we need to transfer the .zip folder (both) to our PC, we can do this by  the scp command as follow: Open a new termianal in your computer and type:

```console
(base) avera@L003772:Genome_Assembly.May.2021$ scp avera2020@148.204.124.131:/home/avera/Genome_Assembly.May.2021/RawReads.dir/Illumina/Fastqc.dir/*.zip .
Password: 
k_p.illumina.ERR1015321_1_fastqc.zip                                                                                                                        100%  289KB 375.4KB/s   00:00    
k_p.illumina.ERR1015321_2_fastqc.zip                                                                                                                        100%  295KB 937.1KB/s   00:00
(base) avera@L003772:Genome_Assembly.May.2021$ ls -l
total 588
-rw-r--r-- 1 avera avera 295871 May 30 21:17 k_p.illumina.ERR1015321_1_fastqc.zip
-rw-r--r-- 1 avera avera 301804 May 30 21:17 k_p.illumina.ERR1015321_2_fastqc.zip
```

6. Now decompress the zip files:

```console
(base) avera@L003772:Genome_Assembly.May.2021$ unzip k_p.illumina.ERR1015321_1_fastqc.zip 
Archive:  k_p.illumina.ERR1015321_1_fastqc.zip
   creating: k_p.illumina.ERR1015321_1_fastqc/
   creating: k_p.illumina.ERR1015321_1_fastqc/Icons/
   creating: k_p.illumina.ERR1015321_1_fastqc/Images/
  inflating: k_p.illumina.ERR1015321_1_fastqc/Icons/fastqc_icon.png  
  inflating: k_p.illumina.ERR1015321_1_fastqc/Icons/warning.png  
  inflating: k_p.illumina.ERR1015321_1_fastqc/Icons/error.png  
  inflating: k_p.illumina.ERR1015321_1_fastqc/Icons/tick.png  
  inflating: k_p.illumina.ERR1015321_1_fastqc/summary.txt  
  inflating: k_p.illumina.ERR1015321_1_fastqc/Images/per_base_quality.png  
  inflating: k_p.illumina.ERR1015321_1_fastqc/Images/per_sequence_quality.png  
  inflating: k_p.illumina.ERR1015321_1_fastqc/Images/per_base_sequence_content.png  
  inflating: k_p.illumina.ERR1015321_1_fastqc/Images/per_sequence_gc_content.png  
  inflating: k_p.illumina.ERR1015321_1_fastqc/Images/per_base_n_content.png  
  inflating: k_p.illumina.ERR1015321_1_fastqc/Images/sequence_length_distribution.png  
  inflating: k_p.illumina.ERR1015321_1_fastqc/Images/duplication_levels.png  
  inflating: k_p.illumina.ERR1015321_1_fastqc/Images/adapter_content.png  
  inflating: k_p.illumina.ERR1015321_1_fastqc/fastqc_report.html  
  inflating: k_p.illumina.ERR1015321_1_fastqc/fastqc_data.txt  
  inflating: k_p.illumina.ERR1015321_1_fastqc/fastqc.fo  
(base) avera@L003772:Genome_Assembly.May.2021$ unzip k_p.illumina.ERR1015321_2_fastqc.zip 
Archive:  k_p.illumina.ERR1015321_2_fastqc.zip
   creating: k_p.illumina.ERR1015321_2_fastqc/
   creating: k_p.illumina.ERR1015321_2_fastqc/Icons/
   creating: k_p.illumina.ERR1015321_2_fastqc/Images/
  inflating: k_p.illumina.ERR1015321_2_fastqc/Icons/fastqc_icon.png  
  inflating: k_p.illumina.ERR1015321_2_fastqc/Icons/warning.png  
  inflating: k_p.illumina.ERR1015321_2_fastqc/Icons/error.png  
  inflating: k_p.illumina.ERR1015321_2_fastqc/Icons/tick.png  
  inflating: k_p.illumina.ERR1015321_2_fastqc/summary.txt  
  inflating: k_p.illumina.ERR1015321_2_fastqc/Images/per_base_quality.png  
  inflating: k_p.illumina.ERR1015321_2_fastqc/Images/per_sequence_quality.png  
  inflating: k_p.illumina.ERR1015321_2_fastqc/Images/per_base_sequence_content.png  
  inflating: k_p.illumina.ERR1015321_2_fastqc/Images/per_sequence_gc_content.png  
  inflating: k_p.illumina.ERR1015321_2_fastqc/Images/per_base_n_content.png  
  inflating: k_p.illumina.ERR1015321_2_fastqc/Images/sequence_length_distribution.png  
  inflating: k_p.illumina.ERR1015321_2_fastqc/Images/duplication_levels.png  
  inflating: k_p.illumina.ERR1015321_2_fastqc/Images/adapter_content.png  
  inflating: k_p.illumina.ERR1015321_2_fastqc/fastqc_report.html  
  inflating: k_p.illumina.ERR1015321_2_fastqc/fastqc_data.txt  
  inflating: k_p.illumina.ERR1015321_2_fastqc/fastqc.fo
  ```
  
7. You can enter to either the fastq folders generated and use the explorer (e.g Chrome or Firefox) to take a look of the fastqc_report.html:

Main results will show a Basic stats:


![BStats](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/BstatsFQC.png)


A boxplot with the quality per base


![Boxplot](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/per_base_quality.png)


A linear plot of GC content


![GCcontent](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/per_sequence_gc_content.png)



# Using NanoPlot for quality check of Nanopore reads

1. Go to the ```/home/user/Genome_Assembly.May.2021/RawReads.dir/Nanopore``` folder and create a folder named Nanoplot:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 ~]$ cd /home/avera/Genome_Assembly.May.2021/RawReads.dir/Nanopore
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Nanopore]$ 
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Nanopore]$ ls
k_p.nanopre.fastq.gz
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Nanopore]$ mkdir Nanoplot
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Nanopore]$ cd Nanoplot/
```
2. Make a symbolic link of the fastq files:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Nanoplot]$ ln -s ../k_p.nanopre.fastq.gz .
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Nanoplot]$ ls -lrth
total 0
lrwxrwxrwx 1 avera2020 avera2020 23 May 31 11:22 k_p.nanopre.fastq.gz -> ../k_p.nanopre.fastq.gz
```

3. If the conda environment is not loaded doaded it: 

```console
[avera2020@pc-124-131 Nanopore]$ conda activate /home/avera/condaenv/GenomeAssemblyModule/
```

4. Display the NanoPlot help:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Nanoplot]$ NanoPlot --help
usage: NanoPlot [-h] [-v] [-t THREADS] [--verbose] [--store] [--raw] [--huge]
                [-o OUTDIR] [-p PREFIX] [--tsv_stats] [--info_in_report]
                [--maxlength N] [--minlength N] [--drop_outliers]
                [--downsample N] [--loglength] [--percentqual] [--alength]
                [--minqual N] [--runtime_until N] [--readtype {1D,2D,1D2}]
                [--barcoded] [--no_supplementary] [-c COLOR] [-cm COLORMAP]
                [-f {png,jpg,jpeg,webp,svg,pdf,eps,json}]
                [--plots [{kde,hex,dot} [{kde,hex,dot} ...]]]
                [--legacy [{kde,dot,hex} [{kde,dot,hex} ...]]] [--listcolors]
                [--listcolormaps] [--no-N50] [--N50] [--title TITLE]
                [--font_scale FONT_SCALE] [--dpi DPI] [--hide_stats]
                (--fastq file [file ...] | --fasta file [file ...] | --fastq_rich file [file ...] | --fastq_minimal file [file ...] | --summary file [file ...] | --bam file [file ...] | --ubam file [file ...] | --cram file [file ...] | --pickle pickle | --feather file [file ...])

CREATES VARIOUS PLOTS FOR LONG READ SEQUENCING DATA.
```

4. Run NanoPlot:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Nanoplot]$ nohup NanoPlot -t 4 --fastq k_p.nanopre.fastq.gz --plots hex dot &
```

5. Explore the results:

avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Nanoplot]$ ls -lrth
total 1.5M
lrwxrwxrwx 1 avera2020 avera2020   23 May 31 11:22 k_p.nanopre.fastq.gz -> ../k_p.nanopre.fastq.gz
-rw-rw-r-- 1 avera2020 avera2020  815 May 31 11:24 NanoStats.txt
-rw-rw-r-- 1 avera2020 avera2020  15K May 31 11:24 WeightedHistogramReadlength.html
-rw-rw-r-- 1 avera2020 avera2020  42K May 31 11:24 WeightedHistogramReadlength.png
-rw-rw-r-- 1 avera2020 avera2020  19K May 31 11:24 WeightedLogTransformed_HistogramReadlength.html
-rw-rw-r-- 1 avera2020 avera2020  45K May 31 11:24 WeightedLogTransformed_HistogramReadlength.png
-rw-rw-r-- 1 avera2020 avera2020  15K May 31 11:24 Non_weightedHistogramReadlength.html
-rw-rw-r-- 1 avera2020 avera2020  31K May 31 11:24 Non_weightedHistogramReadlength.png
-rw-rw-r-- 1 avera2020 avera2020  15K May 31 11:24 Non_weightedLogTransformed_HistogramReadlength.html
-rw-rw-r-- 1 avera2020 avera2020  46K May 31 11:24 Non_weightedLogTransformed_HistogramReadlength.png
-rw-rw-r-- 1 avera2020 avera2020 147K May 31 11:24 Yield_By_Length.html
-rw-rw-r-- 1 avera2020 avera2020  40K May 31 11:24 Yield_By_Length.png
-rw-rw-r-- 1 avera2020 avera2020 386K May 31 11:24 LengthvsQualityScatterPlot_dot.html
-rw-rw-r-- 1 avera2020 avera2020  47K May 31 11:24 LengthvsQualityScatterPlot_dot.png
-rw-rw-r-- 1 avera2020 avera2020 604K May 31 11:24 NanoPlot-report.html
-rw-rw-r-- 1 avera2020 avera2020 2.4K May 31 11:24 NanoPlot_20210531_1124.log
```
 
 As fastQC, NanoPlot will give us multiple images (png) files and an html report NanoPlot-report.html. However, we can acess to the main stats looking into the NanoStats.txt file:
 
 ```console
 (/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 Nanoplot]$ more NanoStats.txt 
General summary:         
Mean read length:              11,344.4
Mean read quality:                 12.6
Median read length:             6,234.5
Median read quality:               12.8
Number of reads:                7,406.0
Read length N50:               23,135.0
STDEV read length:             14,176.8
Total bases:               84,016,695.0
Number, percentage and megabases of reads above quality cutoffs
>Q5:	7406 (100.0%) 84.0Mb
>Q7:	7406 (100.0%) 84.0Mb
>Q10:	7005 (94.6%) 79.1Mb
>Q12:	5038 (68.0%) 55.1Mb
>Q15:	51 (0.7%) 0.1Mb
Top 5 highest mean basecall quality scores and their read lengths
1:	16.5 (350)
2:	16.1 (429)
3:	15.9 (494)
4:	15.8 (318)
5:	15.8 (406)
Top 5 longest reads and their mean basecall quality score
1:	137298 (11.7)
2:	124322 (12.6)
3:	124087 (12.6)
4:	123291 (13.1)
5:	111837 (13.7)
```
### Could you detec the main differences between Illumina and Nanopore sequencing ???
