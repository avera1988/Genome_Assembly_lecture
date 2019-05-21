# Genome completeness assessment by single-copy orthologs

Once we have our best genome filtered we can evaluet how complete is our draft (by contigs or scaffolds) running [BUSCO](https://busco.ezlab.org/)

So now let's use those contigs from assembly of reads form quality of Q>=22 and trimmed in a lenght > 1000 nt to perform the completeness prediction.

**BUSCO looks for a certain number of orthologous genes and counts the total of these ortholog genes present in your genome. That way it can estimate the completeness. For example if the database has 10 genes and BUSCO find 9 of them in your genome it scores a completeness of 90 %.**

### As busco uses genes we need to predict the codifying sequences of genes in our genome, for this we are going to use prodigal to predic genes. In this session we will not disscuss prodigal we are only using as it. In further sessions a more deep explain about prodigal will be given.

First let's create a directory and a symbolic link of our contigs

```console
(base) [veraponcedeleon.1@unity-1 DacB20]$ mkdir BUSCO
(base) [veraponcedeleon.1@unity-1 DacB20]$ cd BUSCO/
(base) [veraponcedeleon.1@unity-1 BUSCO]$ ln -s ../contig.1000.fa .
(base) [veraponcedeleon.1@unity-1 BUSCO]$ ls -l
total 0
lrwxrwxrwx 1 veraponcedeleon.1 research-eeob-sabree 17 May 21 16:08 contig.1000.fa -> ../contig.1000.fa
```
Now we need to predic the codifying sequences using prodigal like this

```console
(base) [veraponcedeleon.1@unity-1 BUSCO]$ prodigal -a contig.1000.fa.amino.faa -d contig.1000.fa.cds.ffn -o prodigal.out -i contig.1000.fa
```

Prodigal generates three files: 

* the genes in aminoacid translated contig.1000.fa.amino.faa
* the genes in nucleotid format contig.1000.fa.cds.ffn
* and a general output prodigal.out

```console
(base) [veraponcedeleon.1@unity-1 BUSCO]$ ls
contig.1000.fa  contig.1000.fa.amino.faa  contig.1000.fa.cds.ffn  prodigal.out
```

Let's see the first 2 lines of these files:
```console
head -2 *
==> contig.1000.fa.amino.faa <==
>contig-100_0_1 # 1 # 438 # -1 # ID=1_1;partial=10;start_type=ATG;rbs_motif=None;rbs_spacer=None;gc_cont=0.594
MIHISSQFDSGNIEIRDARDPTNVRLAIRHDAGGVFMQWFHFRLHGVRGQPLRLVIENAG

==> contig.1000.fa.cds.ffn <==
>contig-100_0_1 # 1 # 438 # -1 # ID=1_1;partial=10;start_type=ATG;rbs_motif=None;rbs_spacer=None;gc_cont=0.594
ATGATCCATATCAGCAGCCAGTTCGATAGCGGCAACATCGAGATCCGGGATGCACGGGATCCCACCAACG

==> prodigal.out <==
DEFINITION  seqnum=1;seqlen=38881;seqhdr="contig-100_0 length_38881 read_count_10598	38881";version=Prodigal.v2.6.3;run_type=Single;model="Ab initio";gc_cont=62.67;transl_table=11;uses_sd=1
FEATURES             Location/Qualifiers
```

Now we have the genes and we can use BUSCO to find the orthologs in our genome.

But what orthologs we are looking for? Well BUSCO has developed a common orthologs clusters for different organisims:
![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/busco.png)
