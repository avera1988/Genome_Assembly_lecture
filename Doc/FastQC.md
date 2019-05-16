# Instructions to create FastQC reports using multiple fastq files

1. Download the Data folder [Data](https://osu.box.com/s/9yz3cotyv9ghmd3ab3esinc1i0kds6ow)
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
[avera@debian FastQC]$ mv /home/avera/Project/Class/Raw_reads.tar.gz .
[avera@debian FastQC]$ tar -xzvf Raw_reads.tar.gz 
Raw_reads/
Raw_reads/PacBio/
Raw_reads/PacBio/wDacB.fastq
Raw_reads/Illumina/
Raw_reads/Illumina/DZSPH5021_V1T_1-22297444/
Raw_reads/Illumina/DZSPH5021_V1T_1-22297444/DZSPH5021-V1T-1_S14_L002_R2_001.fastq.gz
Raw_reads/Illumina/DZSPH5021_V1T_1-22297444/DZSPH5021-V1T-1_S14_L002_R1_001.fastq.gz
Raw_reads/Illumina/DacBeta/
Raw_reads/Illumina/DacBeta/DacBet_2.fastq.gz
Raw_reads/Illumina/DacBeta/DacBet_1.fastq.gz
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

**Enter to ~/FastQC/Raw_reads/Illumina/DZSPH5021_V1T_1-22297444**

```console
[avera@debian DZSPH5021_V1T_1-22297444]$ pwd
/home/avera/Project/Class/CBG_IPN/FastQC/Raw_reads/Illumina/DZSPH5021_V1T_1-22297444
```

Let's run fastQC for these two files
 ```console
 [avera@debian DZSPH5021_V1T_1-22297444]$ fastqc -t 4 -f fastq DZSPH5021-V1T-1_S14_L002_R1_001.fastq.gz DZSPH5021-V1T-1_S14_L002_R2_001.fastq.gz
 ```
 Check the results 
 ```Console
 [avera@debian DZSPH5021_V1T_1-22297444]$ ls -lrth
total 1.2G
-rw-r--r-- 1 avera avera 583M May 15 15:49 DZSPH5021-V1T-1_S14_L002_R1_001.fastq.gz
-rw-r--r-- 1 avera avera 631M May 15 15:49 DZSPH5021-V1T-1_S14_L002_R2_001.fastq.gz
-rw-r--r-- 1 avera avera 306K May 16 14:14 DZSPH5021-V1T-1_S14_L002_R2_001_fastqc.zip
-rw-r--r-- 1 avera avera 302K May 16 14:14 DZSPH5021-V1T-1_S14_L002_R1_001_fastqc.zip
-rw-r--r-- 1 avera avera 235K May 16 14:14 DZSPH5021-V1T-1_S14_L002_R2_001_fastqc.html
-rw-r--r-- 1 avera avera 231K May 16 14:14 DZSPH5021-V1T-1_S14_L002_R1_001_fastqc.html
 ```
 You can open the fastQC report using a web browser, in my case firefox
 ```console
 [avera@debian DZSPH5021_V1T_1-22297444]$ firefox DZSPH5021-V1T-1_S14_L002_R1_001_fastqc.html
 ```
 ### Exercise 1 Produce a fastQC report for all Illumina and PacBio files using the command line.
 
 
 
 
