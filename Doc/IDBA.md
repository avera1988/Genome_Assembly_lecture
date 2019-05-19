# Genome Assembly using IDBA_UD assembler

### First we need to create a directory named IDBA and move the TrimGalore filtred DacBet fastq files.
**As fastq files sometimes are quite large, it is recommendable to use a symbolic (soft) link instead a real (hard) copy**
```console
[veraponcedeleon.1@u016 Class_May_2019]$ mkdir IDBA
[veraponcedeleon.1@u016 Class_May_2019]$ cd IDBA/
ln -s ../TrimGalore/DacBet_1_val_1.fq .
ln -s ../TrimGalore/DacBet_2_val_2.fq .
```
IDBA uses a fasta file to assembly, the user needs to concatenate the pair fastq files 
```console
[veraponcedeleon.1@u016 IDBA]$ cat *.fq > Dac.total.fq
[veraponcedeleon.1@u016 IDBA]$ ~/bin/idba/bin/fq2fa Dac.total.fq Dac.fasta
[veraponcedeleon.1@u016 IDBA]$ nohup time ~/bin/idba/bin/idba_ud -r Dac.fasta -o DacBIdba --pre_correction --num_threads 4 > idba.log &
```
