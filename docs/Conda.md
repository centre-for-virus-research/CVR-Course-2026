# Conda and ViralRecon Practical
## [Introduction to Viral Bioinformatics Training Course](https://github.com/centre-for-virus-research/CVR-Course-2026)
* Monday 15th - Friday 19th June 2026
* Glasgow, UK
* [MRC-University of Glasgow Centre for Virus Research](https://www.gla.ac.uk/research/az/cvr/)

## Contact

[Richard Orton](https://www.gla.ac.uk/schools/infectionimmunity/staff/richardorton/)   
[MRC-University of Glasgow Centre for Virus Research](https://www.gla.ac.uk/research/az/cvr/)  
464 Bearsden Road  
Glasgow  
G61 1QH  
UK  
E-mail: Richard.Orton@glasgow.ac.uk  

# README

Before installing conda/mamba on a server you should talk to your local system administrator for advice, as different systems have different ways of working, and different permissions. If installing on your own laptop or desktop - make a backup of any critical data first, just in case anything goes wrong.


# Conda

[Conda](https://anaconda.org) is a package and environment manager that is widely used in bioinformatics, data science, and scientific computing. It is a tool that is capable of:

1. Installing software including all of the software's dependencies
2. Creating isolated environments so different projects can use different software versions without conflicts
3. Enables environment 'recipes' to be easily shared to help other people install and run your tools on their systems


## Why is it called conda?

The name **Conda** comes from **Anaconda**, which was the original scientific Python distribution created by the company now called Anaconda⁠.

The ecosystem ended up with a bit of a snake name theme:

* Anaconda = the full distribution (Python + many scientific packages)
* Conda = the package/environment manager that came with Anaconda
* Miniconda = a minimal installation containing just Conda
* Mamba = a faster reimplementation of Conda
* Micromamba = a lightweight version of Mamba

## Installing conda

We will install the **miniforge** version of conda. Miniforge is a modern Conda installation that uses conda-forge (a community-maintained repository or “channel” of Conda packages) by default and includes the fast Mamba implementation.

First we each need to install miniforge into our home directories, so cd into your home directory

```
cd
```

Now download the miniforge installation script using wget (a command-line program for downloading files from the web):

```
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
```

If you list the contents of the directory you should see the downloaded file Miniforge3-Linux-x86_64.sh:

```
ls
```

And now we install miniforge by running the download bash script - this will take a wee while and involves you responding to questions from the installtion script:

```
bash Miniforge3-Linux-x86_64.sh
```

It will ask: **Please, press ENTER to continue** -> You should press the **Enter** key

It will ask: **Do you accept the license terms? [yes|no]** -> You should type **Yes** and then press **Enter**

It will ask: **Confirm install location: [/home4/courseNN/miniforge3] >>>** -> You should press **Enter**

It will ask: **Proceed with initialization? [yes|no]** -> You should type **Yes** and then press **Enter**

You **must** now wait for the installation to finish and for your prompt to return.

Now we have installed miniforge. But we cant really access it unless we logout and log back in again as the install has changed the scripts run at login. However, we can force the startup script to be 'reloaded' now by typing:

```
source ~/.bashrc
```
The above command only needs to be run once after installation, not every time you use conda miniforge. What you should see is your command prompt change from:

**courseNN@alpha2:~$**

To:

**(base) courseNN@alpha2:~$**

Notice the extra **(base)**, this means that we are now located in the base environment of our new conda miniforge installation. When you login your are automatically in the base environment.

We have one more good practice configuration step to do before we start creating our own environments and installing tools and that is to add a few channels and set the priority order:

```
conda config --add channels conda-forge
conda config --add channels bioconda
conda config --set channel_priority strict
```

A conda channel is simply a repository of pre-built software packages. The most important one for bioinformatics is bioconda, and conda-forge is the largest community-maintained repository of Conda packages. Setting channel_priority to strict means that if a certain tool/package is available in more than one of our channels, conda will always prefer the one from the highest priority channel. In our case this is bioconda as when you add a new channel it goes to the top of the priority list.

We can see the channels we have configured/added by typing:

```
conda config --show channels
```

Which should show you:

```
YOU DO NOT NEED TO TYPE THIS - YOU SHOULD SEE IT AFTER TYPING THE ABOVE COMMAND

channels:
  - bioconda
  - conda-forge
```

## Conda environments

We are now all set to create an environment and install some tools. A Conda environment is a self-contained collection of software packages, libraries, and executables that is isolated from other environments on the same system - think of them as separate software workspaces.

Why use environments? Different tools often need different versions of the same software. For example:

* Tool A requires Python 3.10
* Tool B requires Python 3.12
* Tool C requires an older version of BioPython

Installing everything globally can create conflicts, and mean one tool stops working. Conda environments can keep conflicting tools separate.


So, lets a create a new conda environment called 'test-env', we will use mamba to create it as it is faster than conda:

```
mamba create -n test-env
```

You should see a message that says: **Empty environment created at prefix: /home4/courseNN/miniforge3/envs/test-env**

In order to use an environment we need to **activate** it, slightly confusingly although we use mamba to create and install things, we use conda to activate and deactivate environments. Activating an environment modifies your PATH so that executables inside that environment are found before system-wide software.:

```
conda activate test-env
```

You should see your command prompt change from:

**(base) courseNN@alpha2:~$**

To:

**(test-env) courseNN@alpha2:~$**


## Quick Recap

We have now installed the miniforge version of conda/mamba and configured our channels - you only need to do this once. We have now created and activated our first environment called **test-env** and are ready to install some tools/packages


## Installing our first tool - seqtk

Bioconda maintains a website list of available packages/tools to install: [https://bioconda.github.io/conda-package_index.html](https://bioconda.github.io/conda-package_index.html)

The first tool we are going to install is called [seqtk](https://github.com/lh3/seqtk). This is not currently installed on our server, we can check by typing:


```
seqtk
```

You should see a message saying: **Command 'seqtk' not found**

To install seqtk, installation instructions are available on [bioconda](https://anaconda.org/channels/bioconda/packages/seqtk/overview), we type:

```
mamba install -c bioconda seqtk
```

After pressing enter, mamba will display a few dynamic (rapidly updating) messages, followed by a list of packages that need to be installed (seqtk but also the packages that seqtk depends on), but it will eventually ask:

**Confirm changes: [Y/n]** -> Type **Y** then press Enter

Eventually you will see a message saying **Transaction finished** and your command prompt will return

Now if we type **seqtk** we should see seqtk's help message:

```
seqtk
```

A useful command for seeing where a program is actually installed on Linux is the **which** command, if we type:

```
which seqtk
```

You should see something like: **/home4/courseNN/miniforge3/envs/test-env/bin/seqtk** which means seqtk is in the bin folder, of the test-env environemnt, in the envs (environments) folder of the miniforge3 folder in our home directory.

seqtk is a really useful program that can do a range of FASTQ/FASTA file manipulations, I use it alot for subsampling reads so lets try that. First we need to copy some example data, so lets do that:

```
cd

cp -r /home4/VBG_data/Condata .

cd Condata

ls
```

You should see (amongst other things) a FASTQ file called **fmdv.fastq**. Lets randomly subsampe 10,000 reads from this to create a smaller FASTQ file using seqtk:

```
seqtk sample -s 1234 fmdv.fastq 10000 > fmdv_sub.fastq
```
**NB:** here the -s 1234 is a seed we are giving to the random number generator - you could use any number

If we now count the number of lines in each of the FASTQ files you should see that the new fmdv_sub.fastq file has 40,000 lines corresponding to 10,000 reads:

```
wc -l fmdv.fastq

wc -l fmdv_sub.fastq
```

## cd-hit

Now lets install another really useful tool called **cd-hit**. CD-HIT (Cluster Database at High Identity with Tolerance) clusters DNA, RNA, or protein sequences based on sequence identity. It is commonly used to remove redundancy, dereplicate datasets, identify representative sequences, and reduce computational burden before downstream analyses.

```
mamba install -c bioconda cd-hit
```

It will again ask you: **Confirm changes: [Y/n]** -> Type **Y** then press Enter

Check the program works:

```
which cd-hit
```

You should see something like: **/home4/courseNN/miniforge3/envs/test-env/bin/cd-hit**

Now launch the cd-hit help function to check its working:

```
cd-hit
```

If you list the contents of the directory you should see a file called **all_fmdv.fasta**, lets first count the number of seqs in it:

```
grep -c ">" all_fmdv.fasta
```

Now lets run cd-hit, as these are nucleotide sequences we need to use the **cd-hit-est** script of cd-hit. We are going to cluster the sequences down using a threshold of 95% sequence identity, with cd-hit choosing a single sequence to representative each cluster (typically the longest sequence), and output the reduced sequences into a new fasta file:

```
cd-hit-est -i all_fmdv.fasta -o clustered_fmdv.fasta -c 0.95 -aS 1.0 -aL 0.0 -T 4
```
* cd-hit-est - the name of the program for cd-hit clustering of nucleotide sequences
* -i all_fmdv.fasta - the name of the input fasta sequence file
* -o clustered_fmdv.fasta - the name of the output file to create
* -c 0.95 - the clustering threshold: 0.95 = 95%
* -aS 1.0 - when comparing two seqs, the shorter sequence must be 100% covered by the larger sequence.
* -aL 0.0 - no coverage requirement on the longer sequence
* -T 4 - use 4 threads

When cd-hit finishes, it should report things like total seqs, longest and shortest seqs, and importantly number of clusters. You should see something like:

**923  finished        278  clusters**

We can check this by counting the number of seqs in the output fasta file:

```
grep -c ">" clustered_fmdv.fasta
```

The lowest clustering threshold of cd-hit-est is 0.8 (80%) - lets re-run cd-hit at this level:

```
cd-hit-est -i all_fmdv.fasta -o clustered_fmdv.fasta -c 0.8 -aS 1.0 -aL 0.0 -T 4
```

It should result in 17 clusters. Foot-and-mouth-disease virus (FMDV) exists as seven distinct serotypes which are quite diverse at the nucleotide level, each serotype has distinct topotypes and finer grained lineages. The serotypes are:
* O
* A
* C
* Asia 1
* SAT 1
* SAT 2
* SAT 3

If we examine the clusters we should see atleast one represenative for each serotype:

```
grep ">" clustered_fmdv.fasta
```

## Git and cloning - fastq_screen

As amazing as conda/bioconda are, many bioinformatics tools are not available there. However, they may be available on [GitHub](https://github.com). GitHub is a web-based platform for hosting and collaborating on software projects that use Git, a version control system. In general, I would always install via conda/bioconda if it is available there, unless you want a specific version (like a new development version) that is only available via GitHub.

A GitHub repository (usually called a repo) is a project folder stored on GitHub that contains files, code, documentation, and the complete history of changes made to those files. You can download a repo manually, for example, go to [https://github.com/centre-for-virus-research/CVR-Course-2026](https://github.com/centre-for-virus-research/CVR-Course-20260), click on the green "<> Code" button and then select "Download ZIP". However, you can also download it via the command line using the 'git clone' command - a git command that copies an entire repository from GitHub to your computer.

First we need to install git itself into our environment

```
mamba install -c conda-forge git
```

**Confirm changes: [Y/n]** -> Type **Y** then press Enter

We will now try to download a simple tool called [FastQ_screen](https://github.com/StevenWingett/FastQ-Screen) via the command line using git. FastQ screen is a simple application which allows you to search a FASTQ dataset against a panel of different reference sequences to build up a picture of where the sequences in your data originate. FastQ screen can be used to query a FASTQ samples against a panel of hosts, common contaminants, or even viruses.

In order to clone a GitHub repo we first need it's address which can be found when clicking the green "<> Code" button on the repo. In our case the address is: **https://github.com/StevenWingett/FastQ-Screen.git**

```
git clone https://github.com/StevenWingett/FastQ-Screen.git
```

If we now list the contents of our directory we should see a new **FastQ-Screen** sub-directory:

```
ls
```

In the case of Fastq screen, the program comes ready to use (there is fastq_screen executable in the folder) - but not all tools are as easy as this too install and can require compilation and/or installation of other tools that it is dependent on - hence why conda/mamba are so useful. It does however need an extra perl library to draw its pictures so lets install that:

```
mamba install -c conda-forge perl-gdgraph
```
**Confirm changes: [Y/n]** -> Type **Y** then press Enter

As fastq_screen has not be installed into a common place, we need to tell the computer where it is (it's path) when we run it:

```
perl FastQ-Screen/fastq_screen
```
**NB:** Running the script through perl ensures FastQ Screen uses the Perl interpreter from the active Conda environment, rather than the system Perl installation.

Now we are ready to use fastq_screen, if you list the directory contents you should see (1) a FASTQ file called **barcode13.fastq** and (2) a fastq_screen configuration file called **fastq_screen.conf** which I previously made which points to four different viral reference sequences (A) SARS2; (B) EMCV; (C) FLU and (D) MEASLES. We now run fastq_screen using this configuration file on barcode13.fastq:

```
perl FastQ-Screen/fastq_screen --conf fastq_screen.conf --aligner bwa barcode13.fastq
```

We need to open the barcode13_screen.png or barcode13_screen.txt to see the graphical and textual results - what virus is present in the sample?

## Nextflow and ViralRecon

**What is nextflow?** Nextflow is a framework for building and running reproducible bioinformatics pipelines, allowing multi-step analyses to be executed consistently across laptops, HPC clusters, and cloud systems. Nextflow is software for orchestrating multi-step analyses. It knows which tasks depend on each other, runs independent tasks in parallel, and ensures the correct software is available for each step. Nextflow pipelines are written specifically for the Nextflow framework. Existing bash pipelines cannot simply be run inside Nextflow; they generally need to be rewritten as Nextflow workflows. Nextflow is written primarily in Groovy, which is a language that runs on the Java Virtual Machine (JVM).
* [https://www.nextflow.io](https://www.nextflow.io)

**What is ViralRecon?** Viralrecon is an nf-core/Nextflow pipeline for analysing viral sequencing data. It automates the process of turning raw sequencing reads into consensus genomes, variant calls, and quality-control reports.
* [https://nf-co.re/viralrecon/dev/](https://nf-co.re/viralrecon/dev/)

**What is nf-core?** nf-core is a community-driven collection of high-quality bioinformatics pipelines built using Nextflow. The pipelines follow common standards for reproducibility, documentation, software management, and portability across different computing environments. A few of the most popular nf-core pipelines are:

* nf-core/rnaseq -> Bulk RNA-seq analysis
* nf-core/scrnaseq —> preprocessing of single-cell RNA-seq data (10x Genomics, CEL-Seq2, etc.)
* nf-core/viralrecon -> Viral genome reconstruction and variant calling
* nf-core/ampliseq -> Amplicon sequencing (e.g. ARTIC, 16S)
* nf-core/sarek -> Human variant calling (germline and cancer)
* nf-core/mag -> Metagenome assembly and binning
* nf-core/taxprofiler -> Metagenomic taxonomic classification

To install viralrecon we need to create a new mamba environment, we can tell mamba what packages we want installed at the same time as well:

```
mamba create -n viralrecon -c conda-forge -c bioconda nextflow nf-core
```
**Confirm changes: [Y/n]** -> Type **Y** then press Enter

Now lets activate the new environment:

```
conda activate viralrecon
```

We now need to set some specific Nextflow (NXF) settings. These force Nextflow to use a specific version and syntax parser to ensure compatibility with the viralrecon workflow, which was developed and tested with an older version of Nextflow than the one installed by default.

```
export NXF_VER=25.04.7
export NXF_SYNTAX_PARSER=v1
```

If you list the contents of the directory (we should still be in ~/Condata) you will files relating to dengue virus for running with viralrecon:
* deng3.fasta -> a dengue virus genotype 3 reference sequence in FASTA format
* deng_S1_R1.fq.gz & deng_S1_R2.fq.gz -> illumina paired end FASTQ reads for sample 1 (S1), gzipped
* deng_S2_R1.fq.gz & deng_S2_R2.fq.gz  -> illumina paired end FASTQ reads for sample 2 (S2), gzipped

If we next examine the **sample-sheet.csv**, this is central to running viralrecon. It tells the pipeline how many samples we want processed, what to call the output files, and what the input fastq files are. An important prerequisite for analysing FASTQ reads with viralrecon is that the reads must be **gzipped**:

```
cat sample-sheet.csv
```

Viralrecon can do an absolutely diverse range of things and produce an enormous amount of output. Here we have a simple reference alignment of two samples. The samples are dengue virus so not SARS-CoV-2 (so we can skip SARS-CoV-2 functions: --skip_freyja --skip_pangolin --skip_nextclade), are illumina (--platform illumina), are shotgun not amplicon (--protocol metagenomic), we have a suitable reference sequence (--fasta deng3.fasta), and we want to run reference alignment only with no metagenomic analyses (so we can skip --skip_kraken2 --skip_assembly --skip_variants_quast --skip_assembly_quast), and for speed we'll skip multiqc at the end (--skip_multiqc); -process.cpus limits the number of CPU cores that a single task can use, while -process.maxForks limits how many tasks Nextflow can run simultaneously. Overall, we need to run viralrecon via conda (-profile conda) rather than docker - docker is probably better and quicker, but it wont work well for us on the system we are using. As viralrecon can do a diverse range of things, the commands can be long as you need to tell it exactly what you want and don't want to do:

```
nextflow run nf-core/viralrecon -r 3.0.0 -profile conda --input sample-sheet.csv --outdir results --protocol metagenomic --platform illumina --fasta deng3.fasta --variant_caller ivar --consensus_caller ivar -process.cpus 2 -process.maxForks 2 --skip_freyja --skip_pangolin --skip_nextclade --skip_kraken2 --skip_assembly --skip_variants_quast --skip_assembly_quast --skip_multiqc 
```

When it runs, it will list all the steps that it is going to run and constantly update on their progress, at the end you should see a message in green that says something like the below before your command prompt returns:

```
Duration    : 4m 57s
CPU hours   : 0.1
Succeeded   : 34
```

If we list the contents of the directory now, we should see two important folders - **work** and **results**:

```
ls
```

The **work** folder is Nextflow’s cache and working area, where lots of intermediate files are kept. The work folder can often be much larger than the final results folder because it contains intermediate files and cached task outputs. Once you are happy with the results and no longer need to use -resume, it can safely be deleted to reclaim disk space.

The **results** folder is where the results are:

```
cd results

ls
```

* **results/variants/bowtie2/** -> bowtie2 BAM files
* **results/variants/bowtie2/mosdepth/genome/** -> coverage.pdf coverage plots
* **results/variants/bowtie2/samtools_stats/** -> various read stats
* **results/variants/ivar/consensus/ivar/** -> ivar consensus.fa seqeunces





## Nanopore environment

For the upcoming nanopore practial we need a nanopore environment with a couple of extra tools, so lets create a new environment called nanopore-env, this time we need to specify a certain version of python to use as one of the nanopore tools works best with that:

```
mamba create -n nanopore-env python=3.12
```

It we now get mamba to list of environments we should see both our test-env and nanopore-env (as well as the base env):

```
mamba env list
```

Now we need to activate our new nanopore-env so we can install some tools:

```
conda activate nanopore-env
```

The first tool to install is samtools - one of the best and most widely used bioinformatics tools. Although samtools is already installed on the server, we want our own specific version tied to this environment:

```
mamba install -c bioconda samtools
```

**Confirm changes: [Y/n]** -> Type **Y** then press Enter


If we have a number of tools to install we can install them at the same time. We now need the read aligner minimap2, and a couple of utility programs (tabix and bgzip) that are going to be needed by the next tool we will install:

```
mamba install -c bioconda minimap2 htslib nanoplot assembly-stats ivar
```

**Confirm changes: [Y/n]** -> Type **Y** then press Enter

Now we need to install one of the most important tools for nanopore sequencing - medaka. We do not install this via mamba as the developers recommend installing through pip (the package installer for python):

```
python -m pip install medaka
```

And also one extra pip package for plotting by another tool:

```
python -m pip install matplotlib
```

Now lets check medaka works by typing:

```
which medaka_consensus
```

Which should point to somewere like /home4/courseNN/miniforge3/envs/nanopore-env2/bin/medaka_consensus, and finally type:

```
medaka_consensus
```
Which should produce the medaka consensus help info - you can ignore any messages about 'Cannot import pyabpoa, some features may not be available.'

and finally - install Flye:

```
mamba install -c bioconda flye
```

We are now ready to start analysing some nanopore data.

# Other useful conda commands

* Show all packages installed in the active env: mamba list
* Delete an env: mamba env remove -n test-env
* Save a description of the env to a yml file: mamba env export > my_environment.yml


A really nice conda cheatsheet is available here:

[https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf](https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf)






