
Create a Directory and copy the multiple contigs from IDBA
```console
$mkdir Contigs

$ cp ../DacGaloreIdba/contig.fa contig.default.fa
$ cp ../DacGaloreIdba.kmerSteep10/contig.fa contig.10.fa
$ cp ../DacGaloreIdba.kmerSteep30/contig.fa contig.kamer30.fa
```
Obtain stats for all these contigs and save in a txt file
```console
$ ../../../Genome_Assembly_lecture/Scripts/assembly-stats/assembly-stats *.fa > Basic.stats.txt
```

Create a Directory for running Spades
```console
$ mkdir Spades
$ mkdir raw_reads
$ cd raw_reads/
$ ln -s ../../DacBet_*fastq .
```
Running Spades
```console
$ nohup spades.py -1 DacBet_1.fastq -2 DacBet_2.fastq -t 4 -o SpadesRaw &
```


Check stats

```console
$ cd SpadesRaw/
$ ../../../Genome_Assembly_lecture/Scripts/assembly-stats/assembly-stats contigs.fasta
stats for contigs.fasta
sum = 3548373, n = 187, ave = 18975.26, largest = 153868
N50 = 40617, n = 26
N60 = 34224, n = 35
N70 = 29532, n = 46
N80 = 22644, n = 60
N90 = 13604, n = 80
N100 = 56, n = 187
N_count = 0
Gaps = 0
```
Calculate coverage 
```console
$ ../../../Class_May_2019/112019/Genome_Assembly_lecture/Scripts/coverage.spades.pl
$ ../../../Genome_Assembly_lecture/Scripts/coverage.spades.pl contigs.fasta 
contigs.fasta coverage=	46.613
```
Open the graph in Bandage
```console
~/bin/Bandage load assembly_graph.fastg
```
For BUSCO, as Spades did not perform a good assebly we used the Idba file so let's return to IDBA dir
```console
$ cd /112019/Idba/TrimmedReads/Contigs
```
download the bacteria Busco profiles
```console
$ wget https://busco.ezlab.org/datasets/bacteria_odb9.tar.gz
```
decompress
```console
$ tar -xzvf bacteria_odb9.tar.gz
```
Busco uses set of genes so run Prodigal to predict genes
```console
$ prodigal -a contig.1000.fa.amino.faa -d contig.1000.fa.cds.ffn -o prodigal.out -i contig.1000.fa
```
Run busco using this database
```console
~/bin/busco/scripts/run_BUSCO.py -m prot -i contig.1000.fa.amino.faa -l bacteria_odb9 -c 4 -o BuscoBacteria

BUSCO was run in mode: proteins

	C:100.0%[S:98.0%,D:2.0%],F:0.0%,M:0.0%,n:148

	148	Complete BUSCOs (C)
	145	Complete and single-copy BUSCOs (S)
	3	Complete and duplicated BUSCOs (D)
	0	Fragmented BUSCOs (F)
	0	Missing BUSCOs (M)
	148	Total BUSCO groups searched
```
download Beta
```console
$ wget https://busco.ezlab.org/datasets/betaproteobacteria_odb9.tar.gz
```
Decompress
```console
$ tar -xzvf *.tar.gz
```
run busco

```console
~/bin/busco/scripts/run_BUSCO.py -m prot -i contig.1000.fa.amino.faa -l betaproteobacteria_odb9 -c 4 -o BuscoBeta
# BUSCO was run in mode: proteins

	C:96.9%[S:96.6%,D:0.3%],F:1.4%,M:1.7%,n:582

	564	Complete BUSCOs (C)
	562	Complete and single-copy BUSCOs (S)
	2	Complete and duplicated BUSCOs (D)
	8	Fragmented BUSCOs (F)
	10	Missing BUSCOs (M)
	582	Total BUSCO groups searched
```
