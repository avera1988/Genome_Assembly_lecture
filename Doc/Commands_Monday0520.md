### These are the commands we saw this session.

Creating a directroy and moving Raw_reads file into it
```console
$ mkdir Clase_IPN
$ cd Clase_IPN/
$ mv /media/shared/May/Raw_reads_soft.tar.gz .
```
Decompress

```console
$ tar -xzvf Raw_reads_soft.tar.gz
```
View the header and the first 3 lines

```console
$ cd Raw_reads_soft
$ ls -l
$ cd Illumina/
$ ls -lrth
$head -3 DacBet_1.fastq
```
Running fastQC

```console
$ mkdir FastQC
$ cd FastQC/
$ ln -s ../DacBet_1.fastq .
$ ln -s ../DacBet_2.fastq .
$ mkdir DacFastqc
$ fastqc -t 4 -o DacFastqc -f fastq DacBet_1.fastq DacBet_2.fastq 
$ fastqc -t 4 -o DacFastqc -f fastq *.fastq
$ firefox DacBet_1_fastqc.html
$ firefox DacBet_2_fastqc.html

```

Running TrimGalore

```console
$ mkdir TrimGalore
$ cd TrimGalore/
$ ln -s ../Raw_reads_soft/Illumina/*.fastq .
$ /home/avera/bin/TrimGalore-0.6.0/trim_galore -j 4 -q 30 --path_to_cutadapt /home/avera/.local/bin/cutadapt --fastqc --paired DacBet_1.fastq DacBet_2.fastq
```
