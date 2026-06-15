# Consensus and Variant Calling Practical
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

We have now aligned each of our samples (S1 and S2) to the Wuhan-Hu-1 (NC_045512.2) SARS-CoV-2 reference genome sequence, and now we want to call a consensus sequence.

What is a consensus sequence? At each genome position in the SAM/BAM alignment file, call the most frequent nucleotide (or insertion/deletion) observed in all of the reads aligned at the position. 

In this practical, we will use a tool called [iVar](https://andersen-lab.github.io/ivar/html/manualpage.html) to call the consensus sequence, which utilises the [mpileup](http://www.htslib.org/doc/samtools-mpileup.html) function of samtools.

**NB:** the server we are using (alpha2) has a conflict/error when running ivar by default, to resolve it please **COPY** and **PASTE** the below command into your terminal window and hit the enter button:

```
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/software/htslib-v1.12/lib
```

# 1: Consensus calling

First, lets work on Sample1, so we need to change directory (cd) into the correct folder:

```
cd ~/Richard/Sample1
```

And now call the consenus for the sample using iVar:

```
samtools mpileup -aa -A -d 0 -Q 0 S1.bam | ivar consensus -p S1 -t 0.4
```

Breaking this command down, there are two parts:

1. samtools [mpileup](http://www.htslib.org/doc/samtools-mpileup.html) which essentially outputs the base and indel counts for each genome position
	* **-aa** = output data for absolutely all positions (even zero coverage ones)
	* **-A** = count orphan reads (reads whose pair did not map)
	* **-d 0** = override the maximum depth (default is 8000 which is typically too low for viruses)
	* **-Q 0** = minimum base quality, 0 essentially means all the data
2. ivar [consensus](https://andersen-lab.github.io/ivar/html/manualpage.html) - this calls the consensus - the output of the samtools mpileup command is piped `|` directly into ivar
	* -p S1 = prefix with which to name the output file
	* -t 0.4 = the minimum frequency threshold that a base must match to be used in calling the consensus base at a position. In this case, an ambiguity code will be used if more than one base is > 40% (0.4). See [iVar manual](https://andersen-lab.github.io/ivar/html/manualpage.html)

By default, iVar consensus uses a minimum depth (-m) of 10 and a minimum base quality (-q) of 20 to call the consensus; these defaults can be changed by using the appropriate arguments. If a genome position has a depth less than the minimum, an 'N' base will be used in the consensus sequence by default.

iVar will output some basic statistics to the screen such as:

```
#DO NOT ENTER THIS - IT IS AN EXAMPLE OF AN IVAR OUTPUT:
Minimum Quality: 20
Threshold: 0.4
Minimum depth: 10
Regions with depth less than minimum depth covered by: N
[mpileup] 1 samples in 1 input files
[mpileup] Max depth set to maximum value (2147483647)
Reference length: 29903
Positions with 0 depth: 0
Positions with depth below 10: 4
```

and when it has finished (and your prompt returns) you should see our consensus sequence (S1.fa) in the directory:

```
ls
```

You can view via the sequence itself command line:

```
cat S1.fa 
```

# 2: Variant calling with iVar

Viruses, and in particular RNA viruses, can exist as complex populations consisting of numerous variants present at a spectrum of frequencies – the so called viral quasispecies. Although we have created a consensus sequence (which typically considers mutations at a frequency >50% in the sample) using iVar, we do not yet know anything about the mutations within the sample - although that information is embedded within the consensus sequence. Furthermore, it is often necessary to go beyond the consensus, and investigate the spectrum of low frequency mutations present in the sample.

iVar itself can be used to call variants (using the [iVar variants](https://andersen-lab.github.io/ivar/html/manualpage.html) command), and annotate variants in terms of amino acid changes if the reference's GFF file is supplied (this can normally be downloaded directly from GenBank). Full definitions of the General Feature Format (GFF) format are available here:

* [https://www.ncbi.nlm.nih.gov/datasets/docs/v2/reference-docs/file-formats/annotation-files/about-ncbi-gff3/](
https://www.ncbi.nlm.nih.gov/datasets/docs/v2/reference-docs/file-formats/annotation-files/about-ncbi-gff3/)
* [https://www.ensembl.org/info/website/upload/gff3.html](https://www.ensembl.org/info/website/upload/gff3.html)


The command to call variants with iVar is very similar to the consensus command:

```
samtools mpileup -aa -A -d 0 -Q 0 S1.bam | ivar variants -r ../Refs/sars2_ref.fasta -p S1_variants
```

Breaking this command down, there are two parts:

1. samtools [mpileup](http://www.htslib.org/doc/samtools-mpileup.html) which essentially outputs the base and indel counts for each genome position
	* **-aa** = output data for absolutely all positions (even zero coverage ones)
	* **-A** = count orphan reads (reads whose pair did not map)
	* **-d 0** = override the maximum depth (default is 8000 which is typically too low for viruses)
	* **-Q 0** = minimum base quality, 0 essentially means all the data
2. ivar [variants](https://andersen-lab.github.io/ivar/html/manualpage.html) - this calls the variants - the output of the samtools mpileup command is piped `|` directly into ivar
	* -p S1_variants = prefix with which to name the output file
	* -r ../Refs/sars2_ref.fasta = the reference file name, iVar needs it this time

If you list the directory contents you should see our new output file S1_variants.tsv (a tab separated text file).

```
ls
```

and now view the file:

```
cat S1_variants.tsv
```

***
**Question 1** - how many variants/mutations are in the S1_variants file? Hint - each variant is on its own line
***

By default, iVar will apply a minimum variant frequency threshold of 0.03 (3%), any variant below this will not be reported by default. However, we can vary this with the -t argument. 

First, lets increase the frequency to 0.5 (50%):

```
samtools mpileup -aa -A -d 0 -Q 0 S1.bam | ivar variants -r ../Refs/sars2_ref.fasta -p S1_variants50 -t 0.5
```

***
**Question 2** - how many variants/mutations are in the new S1_variants50.tsv file? Is it more or less than before? Why?
***

Next, lets decrease the frequency to 0.005 (0.5%):

```
samtools mpileup -aa -A -d 0 -Q 0 S1.bam | ivar variants -r ../Refs/sars2_ref.fasta -p S1_variants05 -t 0.005
```

***
**Question 2** - how many variants/mutations are in the new S1_variants05 file? Is it more or less than before? Why?
***

It is up to us to determine what the minimum frequency of the variant calling should be - there is no blanket rule. I previously worked on charcterising RT-PCR and NGS errors in next generation sequencing and we came up with a 0.5% threshold where we would not trust anything below this. BUT - this is highly dependent on the sample processing (RT, PCR etc) and sequencing error rate. The lower you go, the more uncertain the results without further validation - e.g. replicates, lab validation.

# 2: Variant annotation with iVar

In order to annotate the functional affect of a mutation (e.g. if it causes an amino acid change) iVar needs a GFF3 file which essentially descibes where each ORF on the genome starts and ends, so that iVar can determine the codon position of each mutate. We can run iVar variants with the GFF3 file:

```
samtools mpileup -aa -A -d 0 -Q 0 -f ../Refs/sars2_ref.fasta S1.bam | ivar variants -r ../Refs/sars2_ref.fasta -p S1_variants_anno -t 0.5 -g ../Refs/sars2_ref.gff3 
```
**NB:** note the add gff3 file supplied via the -g argument

If we list the directory contents we should see our new S1_variants_anno.tsv file:

```
ls
```

If we view the file we should now see that we have data in the AA and CODON columns for REF and ALT. Note - mutations in non-coding regions 

```
S1_variants_anno.tsv
```

# 4: Consensus and Variant Calling on your own

You now need to apply what you have to Sample2. First you should change directory to the sample's folder, and then adapt the previous commands to work with the new sample i.e. you will need to change the BAM and output file names, but keep the reference file names the same.

# 5: Extra section - Variant Calling with LoFreq and SnpEff

Now we will be using a slightly more advanced variant caller called [LoFreq](https://github.com/CSB5/lofreq) to call the low (and high) frequency variants present in the sample BAM file. LoFreq uses numerous statistical methods and tests to attempt to distinguish true low frequency viral variants from sequence errors. It requires a sample BAM file and corresponding reference sequence that it was aligned to, and creates a [VCF](https://samtools.github.io/hts-specs/VCFv4.2.pdf) file as an output.

First, lets make sure we are in the correct folder to work on Sample1:

```
cd ~/Richard/Sample1
```

To use LoFreq enter this command:

```
/software/lofreq_star-v2.1.2/bin/lofreq call -f ../Refs/sars2_ref.fasta -o S1.vcf S1.bam
```

Breaking this command down:

* **/software/lofreq_star-v2.1.2/bin/lofreq**: the name (and path on alpha2) of the program we are using
* **call**: the name of the function within LoFreq we are using – call variants
* **-f**: ../Refs/sars2_ref.fasta: the reference file name and location (path)
* **-o S1.vcf**: the output VCF file name to create
* **S1**.bam: the input BAM file name

Now lets open the VCF file created by LoFreq:

```
more S1.vcf
```

The outputted VCF file consists of the following fields:

* CHROM: the chromosome – in this case the SARS-CoV-2 ref sequence NC_045512.2
* POS: the position on the chromosome the variant is at
* ID: a ‘.’ but LoFreq can be run with a database of known variants to annotate this field
* REF: the reference base at this position
* ALT: the alternate base (the mutated base) at this position
* QUAL: LoFreq’s quality score for the variant
* FILTER: whether it passed LoFreq’s filters e.g. PASS
* INFO: Detailed Information
	* DP=1248; depth = 1248
	* AF=0.995192; Alt Frequency (Mutation Frequency) = 99.5%
	* SB=0; Strand Bias test p-value
	* DP4=0,1,604,638: Coverage of the ref base in Fwd and Rev, and the alt base in Fwd and Rev

***
### Questions

**Question** – how many consenus level (i.e AF > 0.5) and subconsenus (i.e. AF < 0.5) are there in the sample? what genome positions are the sub-consensus mutations?
***

Now you task is to run LoFreq to characterise the mutations in Sample 2?

# 5.1: Extra Data

If you are looking for something extra to do, there are additional data sets located in the folder:

### ~/Richard/Ebola/

You will find a set of (gzipped) FASTQ paired end read files, and a reference FASTA sequence to align them to.

The reads are from a patient from the ebola epidemic in West Africa 2014 {Gire et al, 2014} [https://www.ncbi.nlm.nih.gov/pubmed/25214632](https://www.ncbi.nlm.nih.gov/pubmed/25214632)

The reference ebola sequence is from a 2007 outbreak in Democratic Republic of Congo. 

Try aligning the reads to the reference yourself.

### ~/Richard/Dengue

This is a simulated Dengue virus sample, but we do not know what genotype it is and therefore what reference alignment to use. Align the paired end FASTQ reads to the two provided reference sequences (genotype1 and genotype3), count the number of mapped reads and create a coverage plot to determine which genotype is the best reference.

### ~/Richard/Mystery/

This is a mystery sample, combine all the given references sequences in the folder into one file using the “cat” command, align the reads to that combined reference (after indexing) and then determine what the virus in the sample is.

