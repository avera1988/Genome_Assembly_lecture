# Instructions to create FastQC reports using multiple fastq files

1. Conect to 148.204.124.131 server and copy the Raw_reads.tar.gz tarball files to your /home/directory/
```console
$ cp /export/home/avera2020/GenomeAssembly.May2020/Raw_reads.tar.gz /home/myhomedir
```
*If you are not able to access the server, download the [Data](https://osu.box.com/s/tjk874n5k2hgwag64nnl40x4njv5qp9i) to your computer.*

-This is a small genome data set from this [paper](https://aem.asm.org/content/86/8/e00091-20)

2. Open a terminal
3. Create a folder named FastQC
4. Move the Raw_reads.tar.gz file into the new FastQC directory
5. Decompress the tar ball file with tar command

```console
$ mkdir FastQC
$ ls -lrth
total 4.0K
drwxr-xr-x 2 avera avera 4.0K May 16 11:51 FastQC
$ cd FastQC/
$ cp ../Raw_reads.tar.gz  .
$ tar -xzvf Raw_reads.tar.gz 
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
$ fastqc
```
![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/fastqcconsole.png)

*Before call fastqc you need to be sure it is instaled if are in server you can load all the software we will use by doing*

```console
$ conda activate GenomeAssemblyModule
(GenomeAssemblyModule) $
```
*Otherwise you can install all programs using Bioconda*

**In case you are working in 148.204.124.131 server you need to activate all software, in order to not fill the HDD you can activate all programs using a source from my PATH environment variable:**

```console
source /export/home/avera2020/GenomeAssembly.May2020/programsPATH.sh
```
After this please check your PATH has changed:

```console
$ echo $PATH
/export/home/avera2020/miniconda3/bin:/export/home/avera2020/miniconda3/condabin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/pdsh/bin:/opt/rocks/bin:/opt/rocks/sbin:/export/home/avera2020/.local/bin:/export/home/avera2020/bin
```
If you can see something like this it means now you have access to the software

*By doing this you will be able to run all software without install*

**Graphic version is fine for one file, but what happens when we have to deal with multiple files, well you can use the command line**
```console
$ fastqc -h

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
$ fastqc -t 4 -f fastq 51_R1.fastq 51_R2.fastq
 ```
 Check the results 	
 ```Console
$ ls -l
total 13256716
-rw-r--r-- 1 avera avera 2125811128 Apr  8 19:17 214_R1.fastq
-rw-r--r-- 1 avera avera 2125811128 Apr  8 19:17 214_R2.fastq
-rw-r--r-- 1 avera avera 2086066162 Apr  8 19:17 224_R1.fastq
-rw-r--r-- 1 avera avera 2086066162 Apr  8 19:17 224_R2.fastq
-rw-r--r-- 1 avera avera 1888443833 Apr  8 19:17 519_R1.fastq
-rw-r--r-- 1 avera avera 1888443833 Apr  8 19:17 519_R2.fastq
-rw-r--r-- 1 avera avera  686064328 Apr  8 19:17 51_R1.fastq
-rw-rw-rw- 1 avera avera     621267 May  6 16:56 51_R1_fastqc.html
-rw-rw-rw- 1 avera avera     411389 May  6 16:56 51_R1_fastqc.zip
-rw-r--r-- 1 avera avera  686064328 Apr  8 19:17 51_R2.fastq
-rw-rw-rw- 1 avera avera     627128 May  6 16:56 51_R2_fastqc.html
-rw-rw-rw- 1 avera avera     424579 May  6 16:56 51_R2_fastqc.zip 

 ```
 You can open the fastQC report  51_R2_fastqc.html using a web browser like Firefox or Chrome
 
 ### Exercise 1 Produce all fastQC reports for all Illumina fastq files using the command line.
 
 
 
 
