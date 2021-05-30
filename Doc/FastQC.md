# Instructions to create FastQC reports using multiple fastq files

1. using the SSH comand conect to 148.204.124.131 server:
```console
$(base) avera@L003772:~$ ssh avera2020@148.204.124.131
Password:
```

2. Create a directory in the ```/home``` folder named: ```/home/user/Genome_Assembly.May.2021```

```bash
(base) [avera2020@pc-124-131 ~]$ cd /home
(base) [avera2020@pc-124-131 home]$ cd avera/
(base) [avera2020@pc-124-131 avera]$ mkdir Genome_Assembly.May.2021
(base) [avera2020@pc-124-131 avera]$ ls -1
Genome_Assembly.May.2021
```

3. Copy the RawFiles.dir forme ```/home/avera2020/GenomeAssembly/Data/RawReads.dir``` to your ```directory /home/user/Genome_Assembly.May.2021```

```bash
(base) [avera2020@pc-124-131 Genome_Assembly.May.2021]$ cp -r /home/avera/GenomeAssembly/Data/RawReads.dir/ .
(base) [avera2020@pc-124-131 Genome_Assembly.May.2021]$ ls -l
total 4
drwxrwxr-x 4 avera2020 avera2020 4096 May 30 14:53 RawReads.dir
```

4. Take a look of the files in ```RawReads.dir/Illumina``` 
```bash
(base) [avera2020@pc-124-131 Genome_Assembly.May.2021]$ cd RawReads.dir/
(base) [avera2020@pc-124-131 RawReads.dir]$ ls
Illumina  Nanopore
(base) [avera2020@pc-124-131 RawReads.dir]$ cd Illumina/
(base) [avera2020@pc-124-131 Illumina]$ ls
k_p.illumina.ERR1015321_1.fastq.gz  k_p.illumina.ERR1015321_2.fastq.gz
```

5. and take a look of the sequences header:

```bash
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
* + plus some information
* Quality
