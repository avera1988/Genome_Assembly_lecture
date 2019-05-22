# Final homework

As a final homework please download the [Homework_reads.tar.gz](https://osu.box.com/s/4ydgkdp2h1cygzvxkvjsg0o21x5ira9n)

1. Decompress the file.
2. Run fastQC and generate the .html plots
3. Run TrimmGalore with at least 2 quality values
4. Assembly these quality reads (from both qualities chosen) using IDBA and SPADES.
5. Run the assembly_stats and generate the statistics file for each assembly.
6. Run the coverage_idba.pl and coverage_spades.pl.
8. Trimm all the contigs less than 1000 nt using the trimm_len.pl contigs.fa 1000 > contigs.1000.fa. 
7. Create a single folder (named as homework_STUDENT_NAME for example: homework_ArturoVeraPonce) and put all the assembled contigs and the coverage.txt files for each of your experiments (this means contigs.fa and contigs.one.1000.fa
from idba and contigs.fasta and contigs.one.1000.fasta from spades) into it, then produce a report in tab format with all the statistics (Genome_Assembly_lecture/Scripts/assembly-stats/assembly-stats  -t contigs1.fa contigs2.fa ...etc. > stats.final.tab).
8. According to the statistics and the coverage select the best assembly and remove the others from this folder.
9. Run prodigal and obtain the BUSCO completeness to this best assembly.  From the busco output folder (i.e run_busco) copy the short_summary_busco.txt into homework_STUDENT_NAME folder. At the end delete all the prodigal (faa, ffn, output) and busco files execpt the short_summary_busco file you have copied to the homework_STUDENT_NAME folder.
10. Please put your FASTQC html files in the homework_STUDENT_NAME folder.
11. At the end your homework_STUDENT_NAME needs to contain: the .html files from fastQC, the .tab report wiht all the statistics, the best assembled contigs in fasta, the covergage.txt from this assembly and the short_summary_busco.txt.
12. Please compress this file using:
 
```console
 $ tar -cxvf homework_STUDENT_NAME.tar.gz homework_comparisson_STUDENT_NAME
```
14. Send your tar.gz file to veraponcedeleon.1@osu.edu (The compressed file should size between 1.5 to 2 Mb).


## The deadline to submit you homework is Friday May 31 11:59 pm, all homeworks getting after this time will no be reviewed.
