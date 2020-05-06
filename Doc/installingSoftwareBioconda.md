# All programs we are using during the course can be installed using [Conda](https://docs.conda.io/en/latest/) manager

**The easiest way to do this is by installing [Miniconda](https://docs.conda.io/en/latest/miniconda.html)**

```console
$ curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
$ sh Miniconda3-latest-Linux-x86_64.sh
```

After installation you need to add the Bioconda channel to the channel list

```console
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
```

Now you can install all prgrams using the GenomeAssemblyModuleEnv.yml file from the [Scripts](https://github.com/avera1988/Genome_Assembly_lecture/tree/master/Scripts) folder

```console
$ conda create -f GenomeAssemblyModuleEnv.yml
```
*It takes a while to install*

Activate the environment

```console
$ conda activate GenomeAssemblyModule
```

**All software will be installed and loaded!**
