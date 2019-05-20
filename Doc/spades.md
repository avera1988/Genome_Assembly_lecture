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
