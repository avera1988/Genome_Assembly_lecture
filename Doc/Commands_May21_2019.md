### Here are the commands used in this session. You can also look the IDBA.md [link](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/Doc/IDBA.md)

Creating the directory and short cut to the files

```console
mkdir assembly
cd assembly/
mkdir IDBA
ln -s /fs/project/obcp/veraponcedelon.1/Class_May_2019/TrimGalore/*30*.fq .
```
Merging files and converting to fastq

```console
/home/veraponcedeleon.1/bin/idba/bin/fq2fa --merge DacBet.30_val_1.fq DacBet.30_val_2.fq DacBet.fa
```

Running idba in default mode

```console
/home/veraponcedeleon.1/bin/idba/bin/idba_ud -r DacBet.fa -o DacBIdba --pre_correction --num_threads 4
```

Running with nohup and send it to the background (useful to run it on a server)

```console
nohup ~/bin/idba/bin/idba_ud -r DacBet.fa -o DacBIDBA --pre_correction --num_threads 4 > idba.log &
````

Entering to idba output directory and performing stats (Please downlad the [scripts](https://github.com/avera1988/Genome_Assembly_lecture/tree/master/Scripts) directory and follow the instructions from README.md before running this)

```console
cp /fs/project/obcp/veraponcedelon.1/Class_May_2019/scripts/assembly.stats.pl .
perl assembly.stats.pl
/fs/project/obcp/veraponcedelon.1/Class_May_2019/scripts/assembly-stats/assembly-stats contig.fa
```

Sending the stats to txt files

```console
perl /fs/project/obcp/veraponcedelon.1/Class_May_2019/scripts/assembly.stats.pl contig.fa > stats.perl.assembly.txt
/fs/project/obcp/veraponcedelon.1/Class_May_2019/scripts/assembly-stats/assembly-stats contig.fa > stats.assembly.txt
```
