# Read Cleaning and Quality Control Practical

## Contact

[Quan Gu](https://www.gla.ac.uk/schools/infectionimmunity/staff/quangu)  

## Contents

In this session, we will work with two paired-end FASTQ samples and perform basic quality control of the sequencing reads. Step-by-step instructions will be provided for processing the first sample, after which you will apply the same workflow independently to analyse the second sample.
 
We have two samples:

* ERR13712192
* ERR13712193

## 1: Explore the data

We first need to copy the data folder that we will need for this practical into your own home directory.

First, let's make sure we are in the right location on the server by moving into our home directory:

```
cd
```

Now, enter the following command to copy the data folder for the practical. Our data is from the paper: [Faizo AAA et al.(2025)](https://doi.org/10.1371/journal.ppat.1012697).
The link to the original data is https://www.ebi.ac.uk/ena/browser/view/PRJEB80489. To improve the speed of this session, we have also subsampled ~5-10% of the original data for this session. (i.e. *sub.fastq)
We could copy the data to our own directory.

```
cp -r /home4/VBG_data/RNASeq/QC/  .
```

If you list the contents of the new copied QC folder:

```
ls QC
```

You should see the following two subfolders: **ERR13712192** and **ERR13712193**


Now let’s change directory (cd) into the first sample's folder:

```
cd ~/QC/ERR13712192
```

If you list (ls) the contents of this directory you should see a pair of FASTQ reads:

```
ls
```

You should see that there is a set of paired-end reads. In this session, we used the subsampling data (*_sub) to speed up our session.

```
A_NoDrug_R1_sub.fastq.gz 
A_NoDrug_R2_sub.fastq.gz
```

Currently, the files have been zipped (compressed) using the gzip program hence the .gz file extension on the filenames. So, we will first unzip them using the gunzip command:

``` 
gunzip *.gz
```

If you list (ls) the directory contents, you can see the unzipped files:

```
ls *sub.fastq
```
These subsampling data (*_sub)  have been unzipped.

``` 
A_NoDrug_R1_sub.fastq
A_NoDrug_R2_sub.fastq
``` 

One useful thing to check initially is that the R1 and R2 files for each pair contain the same number of reads. If they don’t then it suggests something is wrong, the two files might be out of sync, or one file may be truncated.

Here is the command to count the number of lines in a file:

```
wc -l A_NoDrug_R1_sub.fastq
```

Moreover, you can try the following command:

``` 
awk 'END {print NR/4}' A_NoDrug_R1_sub.fastq
``` 

**Question 1:** Why do these two commands get different results? How many pairs of reads are actually in this sample?


**Optional Task： Get basic reads stats from prinseq:**


A more detailed overview of the FASTQ reads can be viewed by using a program called prinseq, which has a number of stats options which can give us a summary of the number of reads, their average lengths, and how many have an N base:

```
prinseq-lite.pl -stats_info -stats_len -stats_ns -fastq A_NoDrug_R1_sub.fastq -fastq2 A_NoDrug_R2_sub.fastq
```

Command breakdown: we run the prinseq program, which is a Perl script called **prinseq-lite.pl**, and we tell it to output basic stats (**-stats\_info**), length stats (**-stats\_len**) and N base stats (**-stats\_ns**) on the FASTQ file (**-fastq**) and its pair (**-fastq2**)

```
stats_info	bases	576703576
stats_info	reads	4000000
stats_info2	bases	577207062
stats_info2	reads	4000000
stats_len	max	150
stats_len	mean	144.18
stats_len	median	150
stats_len	min	35
stats_len	mode	150
stats_len	modeval	2020866
stats_len	range	116
stats_len	stddev	12.80
stats_len2	max	150
stats_len2	mean	144.30
stats_len2	median	149
stats_len2	min	35
stats_len2	mode	150
stats_len2	modeval	1929048
stats_len2	range	116
stats_len2	stddev	12.49
stats_ns	maxn	100
stats_ns	maxp	100
stats_ns	seqswithn	4941
stats_ns2	maxn	35
stats_ns2	maxp	100
stats_ns2	seqswithn	5829
```

The statistics are split into those for the first FASTQ file of the read pair (e.g. stats\_info, stats\_len, etc) and those for the second FASTQ file of the read pair (e.g. stats\_info2, stats\_len2, etc)

## 2: Quality Control

We are still working in this folder:

```
cd ~/QC/ERR13712192
```
 
We can visually inspect the quality of our paired-end reads by using a tool called FastQC. Enter this command to run **FASTQC** on our paired-end reads:

```
fastqc A_NoDrug_R1_sub.fastq A_NoDrug_R2_sub.fastq
```

If you list the contents of the directory now, you should see two .html files outputted by fastqc which contain the fastqc report

```  
A_NoDrug_R1_sub_fastqc.html  
A_NoDrug_R2_sub_fastqc.html
```  

To open these files, you can use the MobaXterm file browser on the left-hand side to navigate to the folder and download the files locally onto your laptop, or enter:

```
firefox A_NoDrug_R1_sub_fastqc.html 
```
We could see the QC plot.
![](https://github.com/centre-for-virus-research/CVR-Course-2026/blob/main/images/fastqc-perbase.png)

**Question 2.1:** What could we get from this Per-base sequence quality plot? Is it a good sample?  

From the FastQC summary, most modules are "OK", while only Per base sequence content and Per sequence GC content are flagged as “Fail”. 
![](https://github.com/centre-for-virus-research/CVR-Course-2026/blob/main/images/fastqqc.png)

Does this mean the reads are of poor quality?

Not necessarily.

Per-base sequence content shows bias at the beginning of reads, which is expected in RNA-seq due to random priming. The rest of the read is relatively stable, so this warning is generally acceptable.  

Meanwhile, the GC content distribution deviates slightly from the theoretical normal distribution, which is expected in RNA-seq due to transcript-specific GC biases. No major abnormalities or contamination patterns are observed.

Among these modules, "Per Base Sequence Quality" and "Adapter Content" are normally the most important. "Per Base Sequence Quality" detects quality degradation along reads, while  "Adapter Content" detects known adapter sequences remaining in reads. High adapter levels suggest trimming is required.

Here is the summary of each module and what each plot shows.
![](https://github.com/centre-for-virus-research/CVR-Course-2026/blob/main/images/fastqcmodule.png)

**Question 2.2:** We have opened the FASTQC report from the R1 file with the above Firefox command - how would we view the R2 file's fastqc report?

# 3: Trimming the FASTQ reads 
 
Typically, the first thing you want to do with your FASTQ reads is some basic quality control. The primary goal of this is to remove low quality reads and low quality ends of reads from the data, as low quality = high error rate.
 
1. Remove any Illumina adapter sequences that are within the read sequences
2. Trim off poor quality sections from the 5’ ends of reads
3. Remove short reads
4. Remove any sequences with an N (as an N can signify a major quality issue with the read)
 
A common tool used for trimming reads is called **Trim Galore**. The command to run it on our first sample is:

```
trim_galore -q 20 --length 50 --max_n 0 --paired A_NoDrug_R1_sub.fastq  A_NoDrug_R2_sub.fastq
```

Command breakdown: we run the **trim\_galore** program using a quality score threshold (**-q**) of **20**, using a minimum length (**--length**) of **50**, we remove reads that have an N base count (**--max_n**) of greater than **0**, and we run it on the paired end reads (**--paired**).
 
If you now list the contents of the directory, we should see the newly created FASTQ paired files containing our trimmed/filtered reads:
```
ls
```

You should see these trimmed FASTQ files and trimming reports:

```  
A_NoDrug_R1_sub_val_1.fq  
A_NoDrug_R2_sub_val_2.fq
A_NoDrug_R1_sub.fastq_trimming_report.txt
A_NoDrug_R2_sub.fastq_trimming_report.txt
``` 

**Question 3.1:** - How many reads are left after trimming?
**Question 3.2:** - Could you please review the trimming report?  

## 4: Trimming on your own

You should now attempt to apply what you have learnt to the second sample in the QC folder. You can still try the subsampled ones. The tasks:

1) **Copy** into the appropriate folder to work;
2) **Unzip** the reads;
3) Use **prinseq** to count the number of reads and bases, etc. (this step is optional);
4) Run **FASTQC** on the reads and view the results with Firefox (or copy the HTML output to your local machine to view);
5) Run **Trim Galore** on the reads using the same quality and length setting used previously.

**Bonus Question**:

Could you re-run QC steps on the original RNA-Seq data to see how long it takes?
 
## 5: Notes
 
**What quality threshold should you use?** 

There is no simple answer to this question. It depends on many things, including what the objective is (e.g. consensus calling, RNA-Seq vs quasispecies), how much data there is (e.g. viral load), and what sequencing technology was used. In general, for Illumina data, a quality threshold of **20** is used when doing consensus genome sequence generation, but increase this to quality **30** when doing quasispecies low frequency variant analyses. However, if you have a poor run and/or there are not many viral reads in the data, you could try lowering the quality threshold – BUT on the understanding that you are accepting poorer quality data, which may influence your results. It is the same with minimum read length, if you originally had 300 base reads but after trimming, only 30 bases are left, although those remaining 30 bases may be above your quality threshold, 90% of the read was removed due to poor quality – do you trust the rest of it? These are not straightforward questions to answer.
Moreover, if your NGS data is RNA-Seq, a "gentle" trimming method would be applied because the strict trimming will impact the downstream gene expression.

**Additional filtering?** For quasispecies analyses, you can add a prinseq filtering step to remove reads that have an average quality that is less than the threshold (using the -min_qual_mean argument), as trim_galore does not do this (it just trims low-quality sections from reads from the 3’ end)  

**Do we have the help file for FASTQC?** Yes, a help file explaining the different FASTQC plots and analyses is here:

[https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/)
 
