## Quality filter with trim galore

### Create a TrimGalore directory, copy there the illumina files

```console
avera@mark3$ mkdir TrimmGalore
avera@mark3$ cd TrimmGalore
ln -s ../51_*fastq .
```
*ln -s creates a "soft" link it means a shortcut to the file this is useful to save space

```console
$ ls -l
total 0
lrwxrwxrwx 1 avera avera 14 May  6 18:33 51_R1.fastq -> ../51_R1.fastq
lrwxrwxrwx 1 avera avera 14 May  6 18:33 51_R2.fastq -> ../51_R2.fastq
```

**Let's take a look into the fastq files**

```console
head -4 51_R1.fastq
$ @SN1052:253:C5NPEACXX:8:1101:5987:1956 1:N:0:79
NAGTAATAACAGTGCGGGATGACATAATGAACTACCTTATTGACCAGGGACTTGAAAAAGGAACAGCATTTAAAATAATGGAGTTTGTAAGAAAAGGTAA
+
#1=BDDDFHGGHFHIJJJJJJJJJIJJIIJJIIJIJIJIJJIIIJIIIIIJJJIJJIJIJHHHHFFFEFEDEEDC>CCDDACDACCD?ADCCCCCDD>>C
$ head -4 51_R2.fastq
@SN1052:253:C5NPEACXX:8:1101:5987:1956 2:N:0:79
CTCTGGCATACATTTCCACTATAATTTCACATATTGCCATTTCAGCTTTTTTCTTTACATCAAGTTTTGGTTCTTTGCTCAATACTGCCAGATGTTCTTT
+
CCCFFFFFHHHGHJJJJIIJJIJIJFJJJJJJJJJJJJJJIDFIIJJJJJGHIIJJGGIHIIJJGIEIEIDHIJIJHHHHGHFFFFFFEECEEEDDEDCD
```
**Now we can run TrimGalore command**

```console
$ trim_galore -j 4 -q 30 --fastqc --paired 51_R1.fastq 51_R2.fastq
```

*These are paried sequences so remember to add the --paired flag in order to keep pairs*

**And compare the sequences from the original files with these trimmed ones**

 ```console
$ ls
51_R1.fastq                      51_R1_val_1_fastqc.html  51_R1_val_1.fq  51_R2.fastq_trimming_report.txt  51_R2_val_2_fastqc.zip
51_R1.fastq_trimming_report.txt  51_R1_val_1_fastqc.zip   51_R2.fastq     51_R2_val_2_fastqc.html          51_R2_val_2.fq
 ```
This software gave us the "validate" files as _val_ files in this case 51_R1_val_1.fq and 51_R2_val_2.fq

 ### Exercise 2 Run TrimGalore to all Illumina fastq files 
 
 **Is there any way to do this automatically?**
 
 The answer is yes we need to use a *for* loop
 
 Let's create a symbolic links to all files
 
 ```console
$ ln -s ../*fastq .
$ ls -l
total 0
lrwxrwxrwx 1 avera avera 15 May  6 18:39 214_R1.fastq -> ../214_R1.fastq
lrwxrwxrwx 1 avera avera 15 May  6 18:39 214_R2.fastq -> ../214_R2.fastq
lrwxrwxrwx 1 avera avera 15 May  6 18:39 224_R1.fastq -> ../224_R1.fastq
lrwxrwxrwx 1 avera avera 15 May  6 18:39 224_R2.fastq -> ../224_R2.fastq
lrwxrwxrwx 1 avera avera 15 May  6 18:39 519_R1.fastq -> ../519_R1.fastq
lrwxrwxrwx 1 avera avera 15 May  6 18:39 519_R2.fastq -> ../519_R2.fastq
lrwxrwxrwx 1 avera avera 14 May  6 18:39 51_R1.fastq -> ../51_R1.fastq
lrwxrwxrwx 1 avera avera 14 May  6 18:39 51_R2.fastq -> ../51_R2.fastq
 ```
 Then the loop using a base name and then apply trimm_Galore
 
 ```console
 $ for i in *R1.fastq;do name=$(basename $i _R1.fastq) ;trim_galore -j 4 -q 30 --fastqc --paired $name\_R1.fastq $name\_R2.fastq ;done
 ```
 *This [cheatsheet](https://devhints.io/bash) you can find more useful bash commands and loops*
 
 You can see how the loop takes the basename of the file, in this case the number, and then performs the quality and adapter trimming.
  
 Now we have all reads trimmed we can compare the html reports

```console
$ ls
214_R1.fastq                      214_R2_val_2_fastqc.zip           224_R2.fastq_trimming_report.txt  519_R1_val_1.fq                   51_R1_val_1_fastqc.html
214_R1.fastq_trimming_report.txt  214_R2_val_2.fq                   224_R2_val_2_fastqc.html          519_R2.fastq                      51_R1_val_1_fastqc.zip
214_R1_val_1_fastqc.html          224_R1.fastq                      224_R2_val_2_fastqc.zip           519_R2.fastq_trimming_report.txt  51_R1_val_1.fq
214_R1_val_1_fastqc.zip           224_R1.fastq_trimming_report.txt  224_R2_val_2.fq                   519_R2_val_2_fastqc.html          51_R2.fastq
214_R1_val_1.fq                   224_R1_val_1_fastqc.html          519_R1.fastq                      519_R2_val_2_fastqc.zip           51_R2.fastq_trimming_report.txt
214_R2.fastq                      224_R1_val_1_fastqc.zip           519_R1.fastq_trimming_report.txt  519_R2_val_2.fq                   51_R2_val_2_fastqc.html
214_R2.fastq_trimming_report.txt  224_R1_val_1.fq                   519_R1_val_1_fastqc.html          51_R1.fastq                       51_R2_val_2_fastqc.zip
214_R2_val_2_fastqc.html          224_R2.fastq                      519_R1_val_1_fastqc.zip           51_R1.fastq_trimming_report.txt   51_R2_val_2.fq
```
