## Quality filter with trim galore

### Create a TrimGalore directory and copy there the illumina fastq.gz files and decompress them

```console
[avera@debian FastQC]$ mkdir TrimGalore
[avera@debian FastQC]$ cd TrimGalore/
[avera@debian TrimGalore]$ cp ../Raw_reads/Illumina/DZSPH5021_V1T_1-22297444/*gz .
[avera@debian TrimGalore]$ cp ../Raw_reads/Illumina/DacBeta/*gz .
[avera@debian TrimGalore]$ ls
DacBet_1.fastq.gz  DacBet_2.fastq.gz  DZSPH5021-V1T-1_S14_L002_R1_001.fastq.gz  DZSPH5021-V1T-1_S14_L002_R2_001.fastq.gz
[avera@debian TrimGalore]$ gzip -d *
[avera@debian TrimGalore]$ ls -lrth
total 3.1G
-rw-r--r-- 1 avera avera 1.5G May 16 16:01 DZSPH5021-V1T-1_S14_L002_R1_001.fastq
-rw-r--r-- 1 avera avera 1.5G May 16 16:01 DZSPH5021-V1T-1_S14_L002_R2_001.fastq
-rw-r--r-- 1 avera avera  84M May 16 16:01 DacBet_1.fastq
-rw-r--r-- 1 avera avera  84M May 16 16:01 DacBet_2.fastq
```

**Let's take a look into the DacBet files**

