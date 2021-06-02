# Illumina reads trimming by quality using [Trim galore](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/)

1. Go to the Illumina directory ```/home/user/Genome_Assembly.May.2021/RawReads.dir/Illumina``` and create a TrimGalore directory:

```console
(base) [avera2020@pc-124-131 Illumina]$ mkdir TrimGalore.dir
(base) [avera2020@pc-124-131 Illumina]$ cd TrimGalore.dir/
```

2. Create a symbolic links of the fastq files here:

```console
(base) [avera2020@pc-124-131 TrimGalore.dir]$ ln -s ../*.gz .
(base) [avera2020@pc-124-131 TrimGalore.dir]$ ls -lrth
total 0
lrwxrwxrwx 1 avera2020 avera2020 37 May 31 09:14 k_p.illumina.ERR1015321_2.fastq.gz -> ../k_p.illumina.ERR1015321_2.fastq.gz
lrwxrwxrwx 1 avera2020 avera2020 37 May 31 09:14 k_p.illumina.ERR1015321_1.fastq.gz -> ../k_p.illumina.ERR1015321_1.fastq.gz
```
3. Some time is better to decompress the original file to avoid errors in the pipeline so let's decompress:

```console
[avera2020@pc-124-131 TrimGalore.dir]$ gunzip -f *.gz
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 TrimGalore.dir]$ ls -lrth
total 1.9G
-rw-rw-r-- 1 avera2020 avera2020 929M May 30 14:53 k_p.illumina.ERR1015321_2.fastq
-rw-rw-r-- 1 avera2020 avera2020 929M May 30 14:53 k_p.illumina.ERR1015321_1.fastq
```

4. To run TrimGalore first load the conda enviroment ```/home/avera/condaenv/GenomeAssemblyModule/```

```console
(base) [avera2020@pc-124-131 TrimGalore.dir]$ conda activate /home/avera/condaenv/GenomeAssemblyModule/
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 TrimGalore.dir]$
```
*If the promt chages then the conda environment is properly loaded*

5. Display the help of TrimGalore:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 TrimGalore.dir]$ trim_galore --help

 USAGE:

trim_galore [options] <filename(s)>
```

Now we can run trim galore to filter low quality sequences (Q < 30). However, as we are running in a remote server and sometimes the internet conexion is not stable, it is better if we run this using the ```nohup``` comand and in the background. 


```console
nohup trim_galore -j 4 -q 30 --fastqc --gzip --paired k_p.illumina.ERR1015321_1.fastq k_p.illumina.ERR1015321_2.fastq &
```

**Command explained:**

* nohup: No hang up, it will allow the software to run even if you suddenly logout the server.
* trim_galore -j 4 -q 30 --fastqc --gzip --paired: Run trim galore with 4 cpus, trim all bases below Q 30, run fastqc, compress the results, use paired sequeneces.
* & Run all the commands in the background

A user can monitorate the progress of the job by the [htop](https://htop.dev/) command:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 TrimGalore.dir]$ htop
```
![HTOP](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/htop.png)

At the end trim galore will produce two ```_val_``` fastq file (one per each pair), two trimming report files and two fastQC reports and .zip files:

```console
(/home/avera/condaenv/GenomeAssemblyModule) [avera2020@pc-124-131 TrimGalore.dir]$ ls -lrth
total 210M
lrwxrwxrwx 1 avera2020 avera2020   93 May 31 09:39 k_p.illumina.ERR1015321_1.fastq.gz -> /home/avera/Genome_Assembly.May.2021/RawReads.dir/Illumina/k_p.illumina.ERR1015321_1.fastq.gz
lrwxrwxrwx 1 avera2020 avera2020   37 May 31 09:39 k_p.illumina.ERR1015321_2.fastq.gz -> ../k_p.illumina.ERR1015321_2.fastq.gz
-rw-rw-r-- 1 avera2020 avera2020 3.7K May 31 09:40 k_p.illumina.ERR1015321_1.fastq.gz_trimming_report.txt
-rw-rw-r-- 1 avera2020 avera2020 103M May 31 09:41 k_p.illumina.ERR1015321_1_val_1.fq.gz
-rw-rw-r-- 1 avera2020 avera2020 106M May 31 09:41 k_p.illumina.ERR1015321_2_val_2.fq.gz
-rw-rw-r-- 1 avera2020 avera2020 3.8K May 31 09:41 k_p.illumina.ERR1015321_2.fastq.gz_trimming_report.txt
-rw-rw-r-- 1 avera2020 avera2020 282K May 31 09:42 k_p.illumina.ERR1015321_1_val_1_fastqc.zip
-rw-rw-r-- 1 avera2020 avera2020 619K May 31 09:42 k_p.illumina.ERR1015321_1_val_1_fastqc.html
-rw-rw-r-- 1 avera2020 avera2020 286K May 31 09:43 k_p.illumina.ERR1015321_2_val_2_fastqc.zip
-rw-rw-r-- 1 avera2020 avera2020 626K May 31 09:43 k_p.illumina.ERR1015321_2_val_2_fastqc.html
-rw------- 1 avera2020 avera2020  13K May 31 09:43 nohup.out
```

Again to be able to look the html reports we need to transfer this to our personal computer by SCP:

```console
(base) avera@L003772:TrimGaloreFastqc$ scp avera2020@148.204.124.131:/home/avera/Genome_Assembly.May.2021/RawReads.dir/Illumina/TrimGalore.dir/*.zip .
Password: 
k_p.illumina.ERR1015321_1_val_1_fastqc.zip    100%  282KB 371.1KB/s   00:00    
k_p.illumina.ERR1015321_2_val_2_fastqc.zip    100%  285KB 900.6KB/s   00:00
(base) avera@L003772:TrimGaloreFastqc$ unzip k_p.illumina.ERR1015321_1_val_1_fastqc.zip 
Archive:  k_p.illumina.ERR1015321_1_val_1_fastqc.zip
   creating: k_p.illumina.ERR1015321_1_val_1_fastqc/
   creating: k_p.illumina.ERR1015321_1_val_1_fastqc/Icons/
   creating: k_p.illumina.ERR1015321_1_val_1_fastqc/Images/
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/Icons/fastqc_icon.png  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/Icons/warning.png  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/Icons/error.png  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/Icons/tick.png  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/summary.txt  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/Images/per_base_quality.png  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/Images/per_sequence_quality.png  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/Images/per_base_sequence_content.png  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/Images/per_sequence_gc_content.png  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/Images/per_base_n_content.png  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/Images/sequence_length_distribution.png  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/Images/duplication_levels.png  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/Images/adapter_content.png  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/fastqc_report.html  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/fastqc_data.txt  
  inflating: k_p.illumina.ERR1015321_1_val_1_fastqc/fastqc.fo  
(base) avera@L003772:TrimGaloreFastqc$ unzip k_p.illumina.ERR1015321_2_val_2_fastqc.zip 
Archive:  k_p.illumina.ERR1015321_2_val_2_fastqc.zip
   creating: k_p.illumina.ERR1015321_2_val_2_fastqc/
   creating: k_p.illumina.ERR1015321_2_val_2_fastqc/Icons/
   creating: k_p.illumina.ERR1015321_2_val_2_fastqc/Images/
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/Icons/fastqc_icon.png  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/Icons/warning.png  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/Icons/error.png  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/Icons/tick.png  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/summary.txt  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/Images/per_base_quality.png  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/Images/per_sequence_quality.png  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/Images/per_base_sequence_content.png  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/Images/per_sequence_gc_content.png  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/Images/per_base_n_content.png  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/Images/sequence_length_distribution.png  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/Images/duplication_levels.png  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/Images/adapter_content.png  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/fastqc_report.html  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/fastqc_data.txt  
  inflating: k_p.illumina.ERR1015321_2_val_2_fastqc/fastqc.fo 
  ```

