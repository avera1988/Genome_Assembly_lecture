## Quality filter with trim galore

### Create a TrimGalore directory, copy there the illumina fastq.gz files and decompress all files

```console
[avera@debian FastQC]$ mkdir TrimGalore
[avera@debian FastQC]$ cd TrimGalore/
[avera@debian TrimGalore]$ cp ../Raw_reads/Illumina/*.fastq .
[avera@debian TrimGalore]$ ls -lrth
-rw-r--r-- 1 avera avera  84M May 16 16:01 DacBet_1.fastq
-rw-r--r-- 1 avera avera  84M May 16 16:01 DacBet_2.fastq
```

**Let's take a look into the DacBet files**

```console
[avera@debian TrimGalore]$ head -5 DacBet_1.fastq 
@MG00HS13:1213:HJ5J3BCXY:1:1101:8612:2599
GAATTCCGCCTGACGGCAAACGGCGATAGCCTGGAAGCCCTCGCCAGGGCACTTGCCGTGGATGGCAATTACACCCTCAAGGCGGGCAGCATCGACCGCTT
+
DDDDDIIIIIIIIHHIIIIIIIIIIIIGHHIIIIIIIHIIIHHIIIIFHIIHIIHHIDHIHHHIHHIIGIGIIIIHHIIFGHCHDHHGIIGEHHHHIDHHH
@MG00HS13:1213:HJ5J3BCXY:1:1101:13226:2502
[avera@debian TrimGalore]$ head -5 DacBet_2.fastq 
@MG00HS13:1213:HJ5J3BCXY:1:1101:8612:2599
CGAGAGTTCGAAGTTGCGCGCGCTGCTTTCGCCCCCCGGGAACATCATGGAACCACGCACCCGCCCCTTGAGGGTCGAATCCGGCGCGATCACCACATTGG
+
DBADDGIIIIIIIEHIIIIIIIIIIGHIIIIIHIIIIIIIGHIIIHHIGIHHIHIHICHDHHHIIHIHEHHHIHIIIHIIIIIDHIHHIDHGHHHHHEHHH
@MG00HS13:1213:HJ5J3BCXY:1:1101:13226:2502
```
**Now we can run TrimGalore command**

```console
[avera@debian TrimGalore]$ /home/avera/bin/TrimGalore-0.6.0/trim_galore -j 4 -q 30 --path_to_cutadapt /home/avera/.local/bin/cutadapt --fastqc --paired DacBet_1.fastq DacBet_2.fastq
```
**And compare the sequences from the original files with these trimmed ones**

 ```console
 [avera@debian TrimGalore]$ firefox DacBet_1_val_1_fastqc.html
 [avera@debian TrimGalore]$ firefox DacBet_2_val_2_fastqc.html
 ```
 
 ### Exercise 2 Run TrimGalore to all Illumina fastq files using a quality filter of 22,26 and 30 save the results in different files. Is there any diffence in the fastQC plots?
