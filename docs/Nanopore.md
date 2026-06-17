

# Setup

First lets copy across some nanopore data into our home directory
```
cd

cp -r /home4/VBG_data/Nanopore .
```

Now we change directory into the Nanopore folder and list it's contents:

```
cd Nanopore

ls *
```

You should see folders for each of the below viruses, each folder contains a FASTQ and reference FASTA file:

* EMCV
* FLU
* FMDV
* HCMV
* Measles
* SARS2

Lets start with EMCV. EMCV stands for Encephalomyocarditis virus. It is a small, rodent-borne RNA virus that primarily infects animals but has zoonotic potential to infect humans. EMCV has a positive-sense, single-stranded RNA genome, roughly 7.8 kilobases in length. EMCV is a member of the *Cardiovirus rueckerti* species,  *Cardiovirus* genus, *Picornaviridae* family.

```
cd EMCV

ls
```

First we will use a program called assembly-stats to get some details on the number and length of the reads:

```
assembly-stats barcode10.fastq 
```

The key outputted  are:

* sum = 33349709 -> total number of bases across all reads in the FASTQ
* n = 55902 -> total number of reads
* ave = 596.57 -> average (mean) length of reads
* largest = 3846 -> longest read

You are hopefully familiar with the term N50 after the metagenomics and de novo assembly lectures. N50 is the sequence length L such that 50% of the total bases are contained in sequences of length L or greater.

In this EMCV sample we have:

* N50 = 649, n = 17317 -> 50% of all the bases in the FASTQ file are contained in reads that are 649 bp or longer.







