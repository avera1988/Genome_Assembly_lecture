# Here you will find the code for using SPADES assembler

### First we need to create a directory named SPADES and move the TrimGalore with q=30   filtred DacBet fastq files.
**As fastq files sometimes are quite large, it is recommendable to use a symbolic (soft) link instead a real (hard) copy**

```console
(base) [veraponcedeleon.1@u009 Class_May_2019]$ mkdir SPADES
(base) [veraponcedeleon.1@u009 Class_May_2019]$ cd SPADES/
(base) [veraponcedeleon.1@u009 SPADES]$ ln -s ../TrimGalore/*30*fq . .
 ```
 We also need the PacBio files for the hybrid assembly so let's linked here
```console 
(base) [veraponcedeleon.1@u009 SPADES]$ ln -s ../Raw_reads_soft/PacBio/DacBeta.pacBio.fastq .
```

Now if spades is instaled in the PATH we can invocate it by typing spades.py

```console
(base) [veraponcedeleon.1@u009 SPADES]$ spades.py 

SPAdes genome assembler v3.11.1

Usage: /usr/local/SPAdes/3.11.1/bin/spades.py [options] -o <output_dir>
```
Running spades

```console
[veraponcedeleon.1@u009 DacSpades]$ nohup time spades.py -o DacSpades -1 DacBet.30_val_1.fq -2 DacBet.30_val_2.fq -t 4 > spades.log &
```

Once finished a Directory DacSpades will be created

```console
(base) [veraponcedeleon.1@u009 SPADES]$ ls

DacBet.30_val_1.fq  DacBet.30_val_2.fq  DacBeta.pacBio.fastq  DacSpades  spades.log
(base) [veraponcedeleon.1@u009 SPADES]$ cd DacSpades/
(base) [veraponcedeleon.1@u009 DacSpades]$ ls -l
total 17824
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree 7294006 May 20 17:16 assembly_graph.fastg
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree 3568782 May 20 17:16 assembly_graph_with_scaffolds.gfa
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree 3632240 May 20 17:16 before_rr.fasta
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree 3632240 May 20 17:16 contigs.fasta
drwxr-xr-x 3 veraponcedeleon.1 RESEARCH-EEOB-Sabree     204 May 20 17:15 corrected
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree      97 May 20 17:15 dataset.info
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree     240 May 20 17:14 input_dataset.yaml
drwxr-xr-x 3 veraponcedeleon.1 RESEARCH-EEOB-Sabree     226 May 20 17:16 K21
drwxr-xr-x 3 veraponcedeleon.1 RESEARCH-EEOB-Sabree     226 May 20 17:16 K33
drwxr-xr-x 3 veraponcedeleon.1 RESEARCH-EEOB-Sabree     264 May 20 17:16 K55
drwxr-xr-x 2 veraponcedeleon.1 RESEARCH-EEOB-Sabree      10 May 20 17:16 misc
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree    1585 May 20 17:14 params.txt
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree  100910 May 20 17:16 spades.log
drwxr-xr-x 2 veraponcedeleon.1 RESEARCH-EEOB-Sabree      10 May 20 17:16 tmp
-rw-r--r-- 1 veraponcedeleon.1 RESEARCH-EEOB-Sabree     686 May 20 17:16 warnings.log
```
