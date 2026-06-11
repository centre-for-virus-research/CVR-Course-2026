# K-mer Based Metagenomics Practical

## Introduction to Viral Bioinformatics Training Course
* Monday 15th - Friday 19th June 2026
* MRC-University of Glasgow Centre for Virus Research
* University of Glasgow, Garscube Campus, Glasgow, G61 1QH

### Instructor
[Joseph Hughes](https://www.gla.ac.uk/schools/infectionimmunity/staff/josephhughes/)

---

## Overview

Metagenomics is the study of genetic material recovered directly from environmental or clinical samples, without first culturing any individual organism. This approach allows us to detect and characterise **all organisms** present in a sample — bacteria, viruses, fungi, and host — in a single experiment.

In this practical we will use a **k-mer based** classification approach to rapidly assign sequencing reads to taxa. This is much faster than de novo assembly based methods and works well for large metagenomic datasets.

### Learning Objectives

By the end of this session you will be able to:

1. Explain what a k-mer is and how k-mer databases are used for classification
2. Remove human host reads from a metagenomic dataset
3. Run Kraken2 to classify metagenomic reads
4. Interpret a Kraken2 report
5. Visualise results interactively using a Krona plot

---

## 1: What is a K-mer?

A **k-mer** is simply a sequence of exactly **k** nucleotides. For any sequence, you can generate all possible k-mers by sliding a window of size k along the sequence one position at a time.

For example, for the sequence `ATGCATG` with k=3:

```
ATGCATG
^^^          ATG
 ^^^         TGC
  ^^^        GCA
   ^^^       CAT
    ^^^      ATG
```

This gives k-mers: `ATG, TGC, GCA, CAT, ATG`

### How Kraken2 Uses K-mers

[Kraken2](https://ccb.jhu.edu/software/kraken2/) works by:

1. **Building a database**: For every known genome in the database (bacteria, viruses, human, etc.), all k-mers are extracted and recorded, along with which organism they came from. If a k-mer appears in multiple species, it is assigned to their **lowest common ancestor (LCA)** in the taxonomy tree.

2. **Classifying reads**: When you give Kraken2 a sequencing read, it breaks it into k-mers and looks each one up in the database. The read is classified based on the organism whose k-mers best match.

This makes Kraken2 extremely fast because database lookup is essentially instantaneous.

### Minimizers

To keep the database to a manageable size, Kraken2 uses **minimizers** instead of storing every individual k-mer. A minimizer is a representative k-mer chosen from a larger window (a "j-mer"), selected by a defined rule. This reduces storage by roughly 7-fold without significantly affecting accuracy. You'll see "minimizer" counts in the Kraken2 output.

---

## 2: Setup

**Make sure you are logged into the alpha2 server with MobaXterm.**

In this practical we will be working with Illumina metagenomic datasets that have been published and are available on the [NCBI Short Read Archive (SRA)](https://www.ncbi.nlm.nih.gov/sra). There are two samples:

* **Pangolin** — from a Malayan pangolin virome study
* **Biting Midge** — from a study of viral diversity in *Culicoides species* (Scotland)

We will use [Kraken2](https://ccb.jhu.edu/software/kraken2/) with the "standard" database (RefSeq archaea, bacteria, viruses, plasmids, and the human reference genome GRCh38; downloaded 2023-06-05).


We will broadly follow the published protocol:

> **Metagenome analysis using the Kraken software suite**  
> Lu et al. (2022). *Nature Protocols* 17, 2815–2839  
> [https://www.nature.com/articles/s41596-022-00738-y](https://www.nature.com/articles/s41596-022-00738-y)

### Copy the data

First change to your home directory:

```bash
cd
```

Copy the Kmer data folder to your home directory:

```bash
cp -r /home4/VBG_data/Kmer2026 .
```

Change into the Pangolin sample folder:

```bash
cd ~/Kmer2026/Pangolin/
```

List the contents to see the files:

```bash
ls
```

You should see paired-end FASTQ files:

**subsampled_R1.fastq.gz** 
**subsampled_R2.fastq.gz**  

---

## 3: Removing Host Reads

Although the Kraken2 database contains the human genome, it doesn't have that of a pangolin. As the pangolin is the dominant organism in the sample, it is good practice to remove host reads **before** classification to speed up Kraken2 by removing the dominant host fraction.

We will use [bowtie2](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml) to align the reads to the pangolin genome, and then extract only the reads that **did not align** (i.e. the non-host reads).

A bowtie2 index of the pangolin genome is already available on the server.

### 3.1: Align to the Pangolin Genome

```bash
bowtie2 -x /db/wgs/Pangolin/NCBI_GCF_040802235.1/bowtie2/GCF_040802235.1_MJ_LKY_genomic -1 subsampled_R1.fastq.gz -2 subsampled_R2.fastq.gz -S Pangolin.sam -p 8
```

**Command breakdown:**

| Flag | Meaning |
|------|---------|
| `-x /db/wgs/Pangolin/...` | The pangolin genome bowtie2 index |
| `-1 subsampled_R1.fastq.gz` | Read 1 of the pair |
| `-2 subsampled_R2.fastq.gz` | Read 2 of the pair |
| `-S Pangolin.sam` | Output alignment file (SAM format) |
| `-p 8` | Use 8 CPU threads |

When finished, bowtie2 will print alignment summary statistics to the terminal. Check the output file was created:

```bash
ls
```

You should now see a file called `Pangolin.sam`.

### 3.2: Extract Non-Host Reads

We now extract the **unmapped reads** (SAM flag 4 = unmapped) using samtools:

```bash
samtools fastq -1 nonhost_1.fastq -2 nonhost_2.fastq -f 4 -s singleton.fastq Pangolin.sam
```

**Command breakdown:**

| Flag | Meaning |
|------|---------|
| `-1 nonhost_1.fastq` | Write read 1 of unmapped pairs here |
| `-2 nonhost_2.fastq` | Write read 2 of unmapped pairs here |
| `-f 4` | Only include reads with the **unmapped** flag |
| `-s singleton.fastq` | Write unpaired reads here |
| `Pangolin.sam` | Input SAM file |


> **Note:** SAM/BAM files need to be sorted by read name when extracting paired-end reads. The SAM file produced by bowtie2 already has pairs adjacent, so we can skip a sort step here.

Check the non-host files were created:

```bash
ls
```

Confirm they actually contain data by counting the lines (each read in FASTQ = 4 lines):

```bash
wc -l nonhost_1.fastq nonhost_2.fastq
```

If you see millions of lines, the host-removal worked. We can now delete the large SAM file to save disk space:

```bash
rm Pangolin.sam
```

---

***
### Question 1
How many non-host reads are in each file? (Hint: divide the line count by 4)
***

---

## 4: Running Kraken2

Now we classify the non-host reads using Kraken2:

```bash
/software/kraken2-v2.1.1/kraken2 \
  --db /home4/VBG_data/k2_standard_20230605 \
  --threads 8 \
  --minimum-hit-groups 3 \
  --report-minimizer-data \
  --paired nonhost_1.fastq nonhost_2.fastq \
  --output kraken_output_Pangolin.txt \
  --report kraken_report_Pangolin.txt
```

> **Note:** The backslash `\` at the end of each line is a **line continuation** — it tells bash the command continues on the next line. This just makes long commands easier to read; you can also type the whole command on one line.

**Command breakdown:**

| Flag | Meaning |
|------|---------|
| `--db /home4/VBG_data/k2_standard_20230605` | The Kraken2 reference database |
| `--threads 8` | Use 8 CPU threads |
| `--minimum-hit-groups 3` | Require ≥3 hit groups for a classification (reduces false positives) |
| `--report-minimizer-data` | Include unique k-mer counts in the report |
| `--paired nonhost_1.fastq nonhost_2.fastq` | The two paired-end input files |
| `--output kraken_output_Pangolin.txt` | Per-read classification output |
| `--report kraken_report_Pangolin.txt` | Human-readable summary report |

> **Note on `--minimum-hit-groups`:** Hit groups are overlapping k-mers sharing the same minimizer. Requiring 3 (rather than the default 2) hit groups improves classification accuracy by reducing false positives, at a small cost in sensitivity.

Kraken2 will print progress to the screen and finish with a summary.

---

## 5: Interpreting the Kraken2 Report

The `kraken_report_Pangolin.txt` file is the key output. It is a tab-separated file with one line per taxon. Look at it:

```bash
head -n 30 kraken_report_Pangolin.txt
```

The columns are:

| Column | Meaning |
|--------|---------|
| 1 | **% of reads** covered by the clade rooted at this taxon |
| 2 | **Number of reads** in the clade (includes descendants) |
| 3 | **Number of reads** assigned directly to this taxon |
| 4 | Number of minimizers in all reads assigned to this clade |
| 5 | Estimated number of **distinct** minimizers (helps spot false positives) |
| 6 | **Rank code**: U=Unclassified, D=Domain, K=Kingdom, P=Phylum, C=Class, O=Order, F=Family, G=Genus, S=Species |
| 7 | NCBI taxonomy ID |
| 8 | Indented scientific name |

> **Tip on interpreting columns 4 and 5:** If column 4 (total minimizers) is high but column 5 (distinct minimizers) is very low, this suggests the reads are all hitting the same small region of the reference — which can indicate a false positive classification. A genuine viral infection should show reads distributed across the whole genome (many distinct minimizers).

To focus on virus-level classifications, you can filter the report:

```bash
grep -P "\tS\t" kraken_report_Pangolin.txt | grep -v "^  0" | sort -t$'\t' -k2 -rn | head -n 20
```

This shows the top 20 species-level classifications ranked by read count.

---

***
### Question 2
What are the top viral species classified in the pangolin sample? (Hint: filter for virus-related lines)
***

---

## 6: Visualising Results with a Krona Plot

A more visual way to explore the results is via a **Krona plot** — an interactive, hierarchical pie chart that can be viewed in any web browser.

```bash
ktImportTaxonomy -q 2 -t 3 -s 4 kraken_output_Pangolin.txt -o kraken_krona_Pangolin.html -tax /db/kronatools/taxonomy
```

**Command breakdown:**

| Flag | Meaning |
|------|---------|
| `-q 2` | Column 2 = query (read) ID |
| `-t 3` | Column 3 = taxonomy ID |
| `-s 4` | Column 4 = score (used for colouring) |
| `kraken_output_Pangolin.txt` | The per-read Kraken2 output |
| `-o kraken_krona_Pangolin.html` | Output HTML file |
| `-tax /db/kronatools/taxonomy` | NCBI taxonomy files for Krona |

List your directory to confirm the HTML file was created:

```bash
ls
```

Open it with Firefox:

```bash
firefox kraken_krona_Pangolin.html
```

> **Tip:** You can also download the file via the MobaXterm file browser on the left-hand side and open it in any browser on your local machine.

### How to Read a Krona Plot

A Krona plot uses **multilevel pie charts** to visualise the taxonomic composition of your sample:

- The **innermost ring** represents the broadest taxonomic levels (e.g. Bacteria, Viruses, Eukaryota)
- Each ring further out represents more specific levels
- The **size of each slice** corresponds to the number of reads assigned to that taxon and its descendants
- **Double-click** any slice to zoom in and explore that taxon
- **Click** a slice to see the read count (top right corner, labelled "count") — this is also a hyperlink to a file with all read IDs assigned to that taxon
- Change colouring via the controls in the top right

---

***
### Question 3
Which virus has the highest read count in the pangolin sample? What family does it belong to?

### Question 4
Click on the virus you identified in Question 3. What is the NCBI taxonomy ID? Click the link — what can you find out about this virus?
***

---

## 7: Background — The Pangolin Sample

The pangolin sample comes from a paper investigating the virome of Malayan pangolins:

> **Viral Metagenomics Revealed Sendai Virus and Coronavirus Infection of Malayan Pangolins (Manis javanica)**  
> *(Liu P et al., Viruses, 2019 Oct 24;11(11))*

This study identified Sendai virus and Coronaviruses in pangolins, highlighting the importance of metagenomic sequencing for wildlife surveillance and identifying potential zoonotic risks.

---

## 8: Kraken2 on the Midge Sample

If you have time, process the second sample — the biting midge — which does **not** require host read removal for this exercise.

Change into the midge data folder:

```bash
cd ~/Kmer2026/MidgePool1
ls
```

The sample is from:

> **Metaviromics Reveals Unknown Viral Diversity in the Biting Midge *Culicoides impunctatus***  
> Modha et al. (2019). *Viruses* 11(9): 865.  
> [https://www.mdpi.com/1999-4915/11/9/865](https://www.mdpi.com/1999-4915/11/9/865)

Adapt the Kraken2 command from Section 4 (skip the bowtie2 host removal step) and generate a Krona plot.

***
### Question 5
What viruses are present in the biting midge sample? Can you identify any of the novel viruses described in the paper?
***


---

## Summary

| Tool | Purpose |
|------|---------|
| `bowtie2` | Align reads to a host genome for host removal |
| `samtools fastq -f 4` | Extract unmapped (non-host) reads |
| `kraken2` | Classify reads using k-mer database |
| `ktImportTaxonomy` | Generate Krona interactive visualisation |

**Key concepts:**
- A **k-mer** is a fixed-length subsequence; k-mer matching is the basis of Kraken2's speed
- **Minimizers** are representative k-mers used to compress the database
- The **minimum-hit-groups** threshold controls the trade-off between sensitivity and specificity
- **Distinct minimizers** (column 5 of the report) help distinguish genuine classifications from false positives
- Metagenomic sequencing can identify novel pathogens without prior knowledge of what is in a sample
