# Genome Assembly using IDBA_UD assembler

### First We need to create a directory named IDBA
```console
[veraponcedeleon.1@u016 Class_May_2019]$ mkdir IDBA
[veraponcedeleon.1@u016 Class_May_2019]$ cd IDBA/
ln -s ../TrimGalore/DacBet_1_val_1.fq .
ln -s ../TrimGalore/DacBet_2_val_2.fq .
[veraponcedeleon.1@u016 IDBA]$ cat *.fq > Dac.total.fq
[veraponcedeleon.1@u016 IDBA]$ ~/bin/idba/bin/fq2fa Dac.total.fq Dac.fasta
[veraponcedeleon.1@u016 IDBA]$ nohup time ~/bin/idba/bin/idba_ud -r Dac.fasta -o DacBIdba --pre_correction --num_threads 4 > idba.log &
```
