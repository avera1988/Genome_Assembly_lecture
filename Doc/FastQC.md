# Instructions to create FastQC reports using multiple fastq files

1. Download the Data folder [Data](https://osu.box.com/s/9yz3cotyv9ghmd3ab3esinc1i0kds6ow)

-These are a small data set from [paper](https://academic.oup.com/gbe/article/9/9/2237/4091605)

2. Open a terminal
3. Create a folder named FastQC
4. Move the Data folder into FastQC directory
5. Decompress the tar ball file with tar command

```console
[avera@debian CBG_IPN]$ mkdir FastQC
[avera@debian CBG_IPN]$ ls -lrth
total 4.0K
drwxr-xr-x 2 avera avera 4.0K May 16 11:51 FastQC
[avera@debian CBG_IPN]$ cd FastQC/
[avera@debian FastQC]$ mv ../Raw_reads_soft.tar.gz  .
[avera@debian FastQC]$ tar -xzvf Raw_reads_soft.tar.gz
Raw_reads_soft/
Raw_reads_soft/Illumina/
Raw_reads_soft/Illumina/DacBet_1.fastq
Raw_reads_soft/Illumina/DacBet_2.fastq
Raw_reads_soft/PacBio/
Raw_reads_soft/PacBio/DacBeta.pacBio.fastq
```
### Now we can use FastQC by calling it with:
```console
[avera@debian FastQC]$ fastqc
```
![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/fastqcconsole.png)

**Graphic version is fine for one file, but what happens when we have to deal with multiple files, well you can use the command line**
```console
[avera@debian FastQC]$ fastqc -h

            FastQC - A high throughput sequence QC analysis tool

SYNOPSIS

	fastqc seqfile1 seqfile2 .. seqfileN

    fastqc [-o output dir] [--(no)extract] [-f fastq|bam|sam] 
           [-c contaminant file] seqfile1 .. seqfileN
```

**Enter to ~FastQC/Raw_reads_soft/Illumina/**

```console
[veraponcedeleon.1@unity-1 Illumina]$ pwd
/fs/project/obcp/veraponcedelon.1/Class_May_2019/FastQC/Raw_reads_soft/Illumina
```

Let's run fastQC for these two files
 ```console
[veraponcedeleon.1@unity-1 Illumina]$ fastqc -t 4 -f fastq DacBet_1.fastq DacBet_2.fastq
 ```
 Check the results 
 ```Console
 [veraponcedeleon.1@unity-1 Illumina]$ ls
DacBet_1.fastq  DacBet_1_fastqc.html  DacBet_1_fastqc.zip  DacBet_2.fastq  DacBet_2_fastqc.html  DacBet_2_fastqc.zip
 ```
 You can open the fastQC report using a web browser, in my case firefox
 ```console
[veraponcedeleon.1@unity-1 Illumina]$ firefox DacBet_1_fastqc.html.html
 ```
 ### Exercise 1 Produce all fastQC reports for all Illumina and PacBio fastq from Raw_reads_soft and Raw_reads_heavy files using the command line.
 
 
 
 
