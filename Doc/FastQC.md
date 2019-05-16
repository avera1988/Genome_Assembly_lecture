# Instructions to create FastQC reports using multiple fastq fasta files

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

