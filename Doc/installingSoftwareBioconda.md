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

**As there is a problem with Bandage software running from Bioconda so we need to install it manualy**

1. Go to your GenomeAssemblyModule bin directory and create a directory named Bandage.dir 

```console
$ cd ~/miniconda3/envs/GenomeAssemblyModule/bin/
$ mkdir Bandage.dir
$ cd Bandage.dir/
```

2. Download the binary compiled file from [Bandage](http://rrwick.github.io/Bandage/) website

```console
$ wget https://github.com/rrwick/Bandage/releases/download/v0.8.1/Bandage_Ubuntu_dynamic_v0_8_1.zip
```
3. Unzip the binary file

```console
$ unzip Bandage_Ubuntu_dynamic_v0_8_1.zip
```
4. Create a symbolic link to the bin directory

```console
$ cd ..
$ ln -s Bandage.dir/Bandage .
```
5. Test Bandage
```console

```

Activate the environment

```console
$ conda activate GenomeAssemblyModule
```

**All software will be installed and loaded!**
