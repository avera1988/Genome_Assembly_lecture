# Instructions to create FastQC reports using multiple fastq files

1. Conect to 148.204.124.131 server and copy the Illumina files to your home/directory
Download the Data folder [Data](https://osu.box.com/s/fwt94wix99q9fv3t78ni6ch0ph5hiy9r)

-This is a small data set from [paper](https://aem.asm.org/content/86/8/e00091-20)

2. Open a terminal
3. Create a folder named FastQC
4. Move the Data folder into FastQC directory
5. Decompress the tar ball file with tar command

```console
[avera]$ mkdir FastQC
[avera]$ ls -lrth
total 4.0K
drwxr-xr-x 2 avera avera 4.0K May 16 11:51 FastQC
[avera@]$ cd FastQC/
[avera@]$ mv ../Raw_reads.tar.gz  .
[avera@]$ tar -xzvf Raw_reads.tar.gz 
Raw_reads/
Raw_reads/Illumina/
Raw_reads/Illumina/214_R1.fastq
Raw_reads/Illumina/214_R2.fastq
Raw_reads/Illumina/224_R1.fastq
Raw_reads/Illumina/224_R2.fastq
Raw_reads/Illumina/519_R1.fastq
Raw_reads/Illumina/519_R2.fastq
Raw_reads/Illumina/51_R1.fastq
Raw_reads/Illumina/51_R2.fastq

```
### Now we can use FastQC by calling it with:
```console
[avera]$ fastqc
```
![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/fastqcconsole.png)

**Graphic version is fine for one file, but what happens when we have to deal with multiple files, well you can use the command line**
```console
[avera]$ fastqc -h

            FastQC - A high throughput sequence QC analysis tool

SYNOPSIS

	fastqc seqfile1 seqfile2 .. seqfileN

    fastqc [-o output dir] [--(no)extract] [-f fastq|bam|sam] 
           [-c contaminant file] seqfile1 .. seqfileN
```

**Enter to ~FastQC/Raw_reads/Illumina/**

```console
$ ls
214_R1.fastq  214_R2.fastq  224_R1.fastq  224_R2.fastq  519_R1.fastq  519_R2.fastq  51_R1.fastq  51_R2.fastq
```

Let's run fastQC for these two files
 ```console
[avera]$ fastqc -t 4 -f fastq 51_R1.fastq 51_R2.fastq
 ```
 Check the results 	
 ```Console
 [avera]$ ls

 ```
 You can open the fastQC report using a web browser, in my case firefox
 ```console
[avera]$ firefox 51*html
 ```
 ### Exercise 1 Produce all fastQC reports for all Illumina fastq from Raw_reads_soft files using the command line.
 
 
 
 
