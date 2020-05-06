## Quality filter with trim galore

### Create a TrimGalore directory, copy there the illumina files

```console
avera@mark3$ mkdir TrimGalore
ln -s ../51_*fastq .
```
*ln -s creates a "soft" link it means a shortcut to the file this is useful to save space

```console
$ ls -l
total 0
lrwxrwxrwx 1 avera avera 14 May  6 18:33 51_R1.fastq -> ../51_R1.fastq
lrwxrwxrwx 1 avera avera 14 May  6 18:33 51_R2.fastq -> ../51_R2.fastq
```

**Let's take a look into the DacBet files**

```console
head -4 51_R1.fastq
avera@mark3:TrimGalore$ @SN1052:253:C5NPEACXX:8:1101:5987:1956 1:N:0:79
NAGTAATAACAGTGCGGGATGACATAATGAACTACCTTATTGACCAGGGACTTGAAAAAGGAACAGCATTTAAAATAATGGAGTTTGTAAGAAAAGGTAA
+
#1=BDDDFHGGHFHIJJJJJJJJJIJJIIJJIIJIJIJIJJIIIJIIIIIJJJIJJIJIJHHHHFFFEFEDEEDC>CCDDACDACCD?ADCCCCCDD>>C
vera@mark3:TrimGalore$ head -4 51_R2.fastq
@SN1052:253:C5NPEACXX:8:1101:5987:1956 2:N:0:79
CTCTGGCATACATTTCCACTATAATTTCACATATTGCCATTTCAGCTTTTTTCTTTACATCAAGTTTTGGTTCTTTGCTCAATACTGCCAGATGTTCTTT
+
CCCFFFFFHHHGHJJJJIIJJIJIJFJJJJJJJJJJJJJJIDFIIJJJJJGHIIJJGGIHIIJJGIEIEIDHIJIJHHHHGHFFFFFFEECEEEDDEDCD
```
**Now we can run TrimGalore command**

```console
$ trim_galore --paired -j 4 -q 30 --fastqc 51_R1.fastq 51_R2.fastq
```
**And compare the sequences from the original files with these trimmed ones**

 ```console
$ ls -lrth
total 1.2G
lrwxrwxrwx 1 avera avera   14 May  6 18:33 51_R1.fastq -> ../51_R1.fastq
lrwxrwxrwx 1 avera avera   14 May  6 18:33 51_R2.fastq -> ../51_R2.fastq
-rw-rw-rw- 1 avera avera 3.4K May  6 18:35 51_R1.fastq_trimming_report.txt
-rw-rw-rw- 1 avera avera 563M May  6 18:35 51_R2_val_2.fq
-rw-rw-rw- 1 avera avera 573M May  6 18:35 51_R1_val_1.fq
-rw-rw-rw- 1 avera avera 3.6K May  6 18:35 51_R2.fastq_trimming_report.txt
-rw-rw-rw- 1 avera avera 398K May  6 18:35 51_R1_val_1_fastqc.zip
-rw-rw-rw- 1 avera avera 635K May  6 18:35 51_R1_val_1_fastqc.html
-rw-rw-rw- 1 avera avera 413K May  6 18:36 51_R2_val_2_fastqc.zip
-rw-rw-rw- 1 avera avera 643K May  6 18:36 51_R2_val_2_fastqc.html
 ```
 
 ### Exercise 2 Run TrimGalore to all Illumina fastq files 
 
 **Is there any way to do this automatically?
 
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
 Then the loop:
 
 ```console
 $ for i in *.fastq; do time trim_galore -j 4 -q 30 --fastqc $i;done
 ```
 
 Now we have all reads trimmed we can compare the html reports

```console
$ ls -l
```
