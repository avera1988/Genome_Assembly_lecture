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
nohup trim_galore -j 4 -q 30 --fastqc --gzip --paired k_p.illumina.ERR1015321_1.fastq.gz k_p.illumina.ERR1015321_2.fastq.gz &
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
