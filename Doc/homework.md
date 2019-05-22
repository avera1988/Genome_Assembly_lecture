# Final homework

Aa a final homework please donwlonad the [Homework_reads.tar.gz](https://osu.box.com/s/4ydgkdp2h1cygzvxkvjsg0o21x5ira9n)

1. Decompress the file.
2. Run fastQC and generate the .html plots
3. Run TrimmGalore with at least 2 quality values
4. Assembly your high quality reads using IDBA and SPADES.
5. Run the assembly_stats and generate the statistics file for each assembly.
6. Run the coverage_idba.pl and coverage_spades.pl.
8. Trimm the short contigs using the trimm_len.pl 
7. In a single folder (named as a homework_STUDENT_NAME) and put all the assembled contigs files for each of your experiments (it means contigs.fa and contigs.one.1000.fa
from idba and contigs.fasta and contigs.one.1000.fasta for spades). And produce a report in tab format of all the statistics.
8. According to the statistics select the best assembly and remove the others from this folder.
9. Run prodigal and obtain the BUSCO completeness to this best assembly from the busco output folder (i.e run_busco) copy the short_summary_busco.txt into homework_STUDENT_NAME folder. At the end delete all the prodigal (faa, ffn, output) and busco files execpt the short_summary_busco file you have copied.
10. Please put your FASTQC html for the raw reads and the TrimGalored treated files in the homework_STUDENT_NAME folder.
11. At the end your homework_STUDENT_NAME needs to contain: the .html files from fastQC the .tab report wiht all the statistics, the best assembled contigs in fasta, and the short_summary_busco.txt.
12. Please compress this file using:
 
```console
 $ tar -cxvf homework_STUDENT_NAME.tar.gz homework_comparisson_STUDENT_NAME
```
14. Send your tar.gz file to veraponcedeleon.1@osu.edu (The compressed file should size between 1.5 to 2 Mb).


##The deadline to submit you homework is Friday 31 11:59 pm, all homeworks send it after this time will no be reviewed.
