# Nanopore Analysis Practical
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

## Overview

In this practical we will work with a range of viral nanopore datasets, using tools to explore the varying read lengths one can get with Oxford Nanopore Technologies (ONT), minimap2 for read alignment, and medaka for consensus calling. This builds on the previous session focussing on Illumina reference alignment, coverage and consensus calling using bwa, samtools and iVar.

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

# EMCV

Lets start with EMCV. EMCV stands for Encephalomyocarditis virus. It is a small, rodent-borne RNA virus that primarily infects animals but has zoonotic potential to infect humans. EMCV has a positive-sense, single-stranded RNA genome, roughly 7.8 kilobases in length. EMCV is a member of the *Cardiovirus rueckerti* species,  *Cardiovirus* genus, *Picornaviridae* family.

```
cd EMCV

ls
```

First we will use a program called [assembly-stats](https://github.com/sanger-pathogens/assembly-stats) to get details on the number and length of the reads:

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

We can explore the length and quality of the reads in much more details with the tool [NanoPlot](https://github.com/wdecoster/nanoplot):

```
NanoPlot --fastq barcode10.fastq -o emcv-nanoplot
```

This will create a HTML report file which we can open with firefox:

```
firefox emcv-nanoplot/NanoPlot-report.html
```
**NB:** remeber you will need to close firefox down before you get your prompt back

Now we will try aligning the reads to the reference sequences using [minimap2](https://github.com/lh3/minimap2). Minimap2 is a fast sequence aligner that maps sequencing reads to a reference genome and is the standard aligner for Oxford Nanopore data. It is widely used for viral, bacterial, and eukaryotic genome analysis due to its speed, accuracy, and ability to handle long reads efficiently.

```
minimap2 -t 4 -a -x map-ont emcv_ref.fasta barcode10.fastq > barcode10.sam
```

* -a = output SAM format
* -x map-ont = mode for Oxford Nanopore reads
* emcv_ref.fasta = reference genome
* barcode10.fastq = input Nanopore FASTQ reads
* > redirect the output
* into an output file called barcode10.sam

We now sort/convert the SAM to BAM, index it, and remove the SAM - these are the steps you should be familiar with from the Illumina reference alignment practicals:

```
samtools sort barcode10.sam -o barcode10.bam

samtools index barcode10.bam

rm barcode10.sam
```

Nanopore sequencing has a different error profile to short-read technologies such as Illumina, with higher rates of insertion/deletion errors and homopolymer-associated mistakes. As a result, specialised variant calling and consensus tools such as Medaka have been developed to model these errors and produce more accurate consensus sequences from Nanopore data.

However, tools such as iVar can still be run on the BAM file to create a consensus sequence, but the sequence will likely contain a number of errors, such as incorrect indels.

```
samtools mpileup -aa -A -d 0 -Q 0 barcode10.bam | ivar consensus -p barcode10 -t 0.4
```

```
cat barcode10.fa
```

As we are in a standard BAM format, we can also readily create a standard coverage plot is we did in the Illumina session:

```
weeSAM --bam barcode10.bam --html barcode10
```

```
firefox barcode10_html_results/barcode10.html
```
**NB:** remeber you will need to close firefox down before you get your prompt back

OK, so what tool should we use for creating a consensus sequence? [medaka](https://github.com/nanoporetech/medaka) is probably the top choice for this, and is designed by Oxford Nanopore Technolgies (ONT) themselves. A key requirement is to tell medaka what model to use, which reflects the version of flowcell and basecaller that was used during sequencing. Medaka takes the fastq reads and reference sequence as input, and uses minimap2 behind the scenes to do the alignement itself.

```
medaka_consensus -i barcode10.fastq -d emcv_ref.fasta -o medaka_consensus -t 4 -m r941_min_hac_g507
```
* medaka_consensus -> the name of the program
* -i barcode10.fastq -> the input fastq file
* -d emcv_ref.fasta  -> the reference sequence
* -o emcv_medaka_consensus -> output folder name
* -t 4 -> number of threads to use (4)
* -m r941_min_hac_g50 -> the model to use: r941 = R9.4.1 chemistry, min = MinION, hac = high-accuracy basecalling, g507 = guppy basecaller Guppy 5.0.7


If we list the contents on the new emcv_medaka_consensus folder we should see our consensus sequence:

```
ls medaka_consensus
```

```
cat medaka_consensus/consensus.fasta
```

Medaka_consensus is a consensus 'polishing' tool, it can sometimes be a little agressive at calling bases at low coverage regions and there is now way to control this directly i.e. there is no minimum depth function in medaka_consensus and now way to mask sites with Ns at low coverage regions.

However, we can use medaka in a different way to address this, first by calling variants with respect to the reference using **medaka variant**, and then by applying the variants along with a minimum depth using **medaka sequence**:

```
medaka_variant -i barcode10.fastq -o emcv_medaka_variant -m r941_min_hac_variant_g507 -r emcv_ref.fasta -f -x
```

* -i barcode10.fastq -> Input Nanopore FASTQ reads
* -o emcv_medaka-variant -> Output directory where Medaka will write VCFs, HDF files, logs, etc.
* -m r941_min_hac_variant_g507 -> Medaka variant model to use (R9.4.1 MinION HAC reads, Guppy 5.0.7-era model)
* -r emcv_ref.fasta -> Reference FASTA to align against and call variants relative to
* -f -> Force overwrite of an existing output directory
* -x -> Skip creation of large intermediate files that are not required for the final output (saves disk space)

```
medaka sequence --min_depth 20 --fill_char N emcv_medaka_variant/consensus_probs.hdf emcv_ref.fasta emcv_medaka_variant/emcv_consensus.fasta
```

* medaka sequence -> Converts Medaka probabilities into a consensus sequence
* --min_depth 20 -> Require at least 20 reads covering a position before calling a base
* --fill_char N -> Positions below the depth threshold become N
* consensus_probs.hdf -> Medaka’s internal file containing consensus probabilities
* emcv_ref.fasta -> Reference sequence used as the coordinate framework
* emcv_consensus.fasta -> Output consensus FASTA


If we check the consensus sequence out now, there should be a depth masked region at the 5' end due to low coverage
```
cat emcv_medaka_variant/emcv_consensus.fasta
```

## Some additional notes

* Medaka gives consensus sequences the same name as the reference sequence, this may cause warnings for alignment/tree programs that don't like duplicate names. We can change their names via sed using the -i in place flag
* Pipelines such as the [ARTIC pipelines](https://github.com/artic-network/fieldbioinformatics) have a slightly modified way of calling the consensus using medaka
* This sample was not amplicon based and therfore did not require a primer BED file for primer trimming
* There is now a newer mode in medaka called **medaka inference** which takes a BAM file and reference sequence to call a consensus

# Influenza

Now lets try with the Influenza (FLU) sample (barcode01.fastq & flu_ref.fasta), which is a segmented virus. I'll just recap the commands to enter as the explanations of each step are already above:

```
cd ../FLU
```

```
assembly-stats barcode01.fastq 
```

```
NanoPlot --fastq barcode01.fastq -o flu-nanoplot
```

```
minimap2 -t 4 -a -x map-ont flu_ref.fasta barcode01.fastq > barcode01.sam
```

```
samtools sort barcode01.sam -o barcode01.bam
```

```
samtools index barcode01.bam
```

```
rm barcode01.sam
```

```
weeSAM --bam barcode01.bam --html barcode01
```

```
medaka_consensus -i barcode01.fastq -d flu_ref.fasta -o flu_medaka_consensus -t 4 -m r941_min_hac_g507
```

```
medaka_variant -i barcode01.fastq -o flu_medaka_variant -m r941_min_hac_variant_g507 -r emcv_ref.fasta -f -x
```

```
medaka sequence --min_depth 20 --fill_char N flu_medaka_variant/consensus_probs.hdf flu_ref.fasta flu_medaka_variant/emcv_consensus.fasta
```

# HCMV

Human cytomegalovirus (HCMV), family *Herpesviridae*, is a large double-stranded DNA herpesvirus that infects humans. Its genome is approximately 235,000 bp in length and encodes over 150 proteins, making it one of the largest and most genetically complex human viruses.

Try and adapt the previous commands to the HCMV sample - you should see a very different read length profile.

# Extra data

If you have time - and there is no expectation to do this - there is also a FMDV, SARS2 and Measles data set - for both use the "r941_min_hac_g507" in medaka

