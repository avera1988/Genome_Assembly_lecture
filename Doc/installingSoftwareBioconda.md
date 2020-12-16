# All programs we are using during the course can be installed using [Conda](https://docs.conda.io/en/latest/) manager

**The easiest way to do this is by installing [Miniconda](https://docs.conda.io/en/latest/miniconda.html)**

```console
$ wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
$ sh Miniconda3-latest-Linux-x86_64.sh
```

After installation you need to add the Bioconda channel to the channel list

```console
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
```

Now we can create and environment and install all software we will use: fastqc, trim-galore, idba, spades and BUSCO, in that particular environment using the following command:

```console
$ conda create -n GenomeAssemblyModule -c bioconda -c conda-forge fastqc trim-galore idba spades busco=4.1.4
```

After solving environment the computer will ask you if you like to proceed, you need to type y and enter:

```console
xorg-renderproto   conda-forge/linux-64::xorg-renderproto-0.11.1-h14c3975_1002
  xorg-xextproto     conda-forge/linux-64::xorg-xextproto-7.3.0-h14c3975_1002
  xorg-xproto        conda-forge/linux-64::xorg-xproto-7.0.31-h7f98852_1007
  xz                 conda-forge/linux-64::xz-5.2.5-h516909a_1
  zlib               conda-forge/linux-64::zlib-1.2.11-h516909a_1010
  zstd               conda-forge/linux-64::zstd-1.4.5-h6597ccf_2


Proceed ([y]/n)? y
````

*It takes a while to install (between 10-30 min depending the computer and internet)*

After this you need to load the environmen:

**Activate the environment**

```console
$ conda activate GenomeAssemblyModule
```

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
$ ./Bandage --help

  ____                  _                  
 |  _ \                | |                 
 | |_) | __ _ _ __   __| | __ _  __ _  ___ 
 |  _ < / _` | '_ \ / _` |/ _` |/ _` |/ _ \
 | |_) | (_| | | | | (_| | (_| | (_| |  __/
 |____/ \__,_|_| |_|\__,_|\__,_|\__, |\___|
                                 __/ |     
                                |___/      
Version: 0.8.1

Usage:    Bandage <command> [options]
```
*Bandage requires Qt 5.2 or later to run, which is included on many modern Linux distributions.However, if you are using WSL (Linux in Windows) you need to install it and modify the strip section*

*If it is not already installed, you can find it through your package manager or from the Qt website: http://www.qt.io/download-open-source/*

Install the qt5 packages with the following commands:

*Ubuntu:*
```console
$ sudo apt-get install qt5-default
$ sudo strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
```

6. If this not work you can always install the graphic version in Windows or Mac:

Check the installation here: https://rrwick.github.io/Bandage/

**Now all software have been installed and loaded!**
