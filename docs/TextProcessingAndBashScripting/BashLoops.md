# Bash Conditions & Loops

## Introduction to Viral Bioinformatics Training Course
* Monday 15th - Friday 19th June 2026
* MRC-University of Glasgow Centre for Virus Research
* University of Glasgow, Garscube Campus, Glasgow, G61 1QH

### Instructor
[Joseph Hughes](https://www.gla.ac.uk/schools/infectionimmunity/staff/josephhughes/)

---

## Overview

Previously you learnt how to write simple bash scripts that process a single file. In this session, you will learn how to write scripts that can process **many files automatically** using loops and conditionals.

The end goal of this week is to write a bash script that runs a full reference assembly pipeline on multiple samples in a loop — without ever typing the same command twice. This session gives you the building blocks to do that.

### Learning Objectives

By the end of this session you will be able to:

1. Use `for`, `while`, and `until` loops to repeat commands
2. Use `if`/`elif`/`else` conditionals to make decisions in scripts
3. Test file and string conditions
4. Use integer arithmetic in bash
5. Loop over files in a directory and process each one automatically
6. Write a script that automates read quality control for multiple samples

---

## Setup

Make sure you are in your `BashDatasets` directory:

```bash
cd ~/BashDatasets
ls
```

You should see the files from the previous session, plus the `fastq_data/` directory.

---

## 1: `for` Loops

Loops allow you to repeat a set of commands many times. The most common loop in bioinformatics scripts is the `for` loop.

### 1.1 Basic `for` Loop Syntax

```bash
for name in Alice Bob Charlie
do
  echo $name
done
```

You can also define the list as an array, which handles names containing spaces correctly:

```bash
names=("Alice" "Bob" "Charlie Brown")
for name in "${names[@]}"
do
  echo $name
done
```

Loop over a range of numbers:

```bash
for number in {1..5}
do
  echo $number
done
```

### 1.2 Looping Over Files

The most useful application for bioinformatics: loop over files matching a pattern:

```bash
for file in fastq_data/paired_end/*.fq
do
  echo $file
done
```

This will print the path of every `.fq` file in the `fastq_data/paired_end` directory.

---

**Task 1:** Write a `for` loop that loops through all files in the current directory (`~/BashDatasets`) and prints each filename along with its line count.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
for file in ./*
do
  wc -l "$file"
done
  ```
</details>

**Task 2:** Make a bash script that uses a `for` loop to print numbers from 50 to 55.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
for number in {50..55}
do
  echo $number
done
  ```
</details>

---

## 2: `while` and `until` Loops

### 2.1 `while` Loop

A `while` loop repeats as long as a condition is **true**. Common numeric comparison operators:

| Operator | Meaning |
|----------|---------|
| `-lt` | less than |
| `-gt` | greater than |
| `-le` | less than or equal to |
| `-ge` | greater than or equal to |
| `-eq` | equal to |
| `-ne` | not equal to |

```bash
i=1
while [ $i -lt 10 ]
do
  echo $i
  ((i++))
done
```

### 2.2 `until` Loop

The `until` loop is the semantic inverse: it repeats until a condition becomes **true** (i.e. while the condition is false):

```bash
i=1
until [ $i -ge 10 ]
do
  echo $i
  ((i++))
done
```

Both loops produce the same output above.

---

**Task 3:** Print the numbers 10 to 15 using either a `for` or a `while` loop.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
for number in {10..15}
do
  echo $number
done
  ```

  Or using while:
  ```bash
#!/bin/bash
i=10
while [ $i -le 15 ]
do
  echo $i
  ((i++))
done
  ```
</details>

---

## 3: `if`/`elif`/`else` Conditionals

### 3.1 Basic if Statement

An `if` statement executes commands only when a condition is met. **The spaces next to the square brackets are part of the syntax — do not omit them.**

```bash
i=1
if [ $i -eq 1 ]; then
  echo "i equals 1"
else
  echo "i does not equal 1"
fi
```

All `if` blocks end with `fi`. Use `elif` for multiple conditions:

```bash
i=5
if [ $i -lt 3 ]; then
  echo "less than 3"
elif [ $i -lt 7 ]; then
  echo "between 3 and 6"
else
  echo "7 or more"
fi
```

### 3.2 Using `$2` to Switch Pipeline Modes

A very useful pattern in pipeline scripts is to pass a **mode** or **setting** as a second argument (`$2`) and use `if`/`elif` to decide which branch to run. For example, a script could support two modes: `reads` (run Kraken2 directly on reads) or `contigs` (first assemble with SPAdes, then classify contigs):

```bash
#!/bin/bash
# Usage: ./pipeline.sh <data_dir> <mode>
# mode can be: reads  OR  contigs

DATA_DIR=$1
SETTING=$2

echo "Data directory: $DATA_DIR"
echo "Mode: $SETTING"

if [ "$SETTING" == "contigs" ]; then
  echo "Running assembly-first pipeline"
  # ... assemble with SPAdes, then classify contigs ...
elif [ "$SETTING" == "reads" ]; then
  echo "Running read-classification pipeline"
  # ... classify reads directly ...
else
  echo "Error: unknown mode '$SETTING'. Use 'reads' or 'contigs'."
  exit 1
fi
```

You would call this with:
```bash
./pipeline.sh /home4/VBG_data/Kmer/Human/ reads
./pipeline.sh /home4/VBG_data/Kmer/Human/ contigs
```

The `exit 1` command stops the script immediately with an error status if the user provides an unrecognised mode — a good habit in real scripts.

### 3.3 String Conditions

```bash
name="Influenza"
virus="SARS-CoV-2"

# Single brackets: use = for equality
if [ "$name" = "$virus" ]; then
  echo "same virus"
else
  echo "different viruses"
fi

# Double brackets: use == for equality, supports wildcards
if [[ "$name" == "Influenza" ]]; then
  echo "this is influenza"
fi
```

### 3.4 Checking if a String Contains a Substring

Double brackets support wildcard patterns, making it easy to check if a filename contains a keyword:

```bash
filename="illumina_sample1.fastq.gz"

if [[ "$filename" == *"illumina"* ]]; then
  echo "This is an Illumina file"
fi
```

This is very useful when you want to apply different settings depending on the file type — as you'll see in the tasks below.

### 3.5 File Test Conditions

You can also test properties of files:

| Condition | Meaning |
|-----------|---------|
| `[ -f "$file" ]` | Is `$file` a regular file? |
| `[ -d "$dir" ]` | Is `$dir` a directory? |
| `[ -e "$path" ]` | Does `$path` exist? |
| `[ -s "$file" ]` | Is `$file` non-empty? |

```bash
file="metadata.csv"
if [ -f "$file" ]; then
  echo "$file exists"
else
  echo "$file not found"
fi
```

---

**Task 4:** Write a script that accepts a filename as a command-line argument. Use an `if` statement to check whether the file exists. If it does, print the number of lines. If it doesn't, print an error message.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
file="$1"
if [ -f "$file" ]; then
  echo "$file has $(wc -l < "$file") lines"
else
  echo "Error: $file not found"
fi
  ```
</details>

---

## 4: String Manipulation in Scripts

In the Text processing tutorial you learnt the key string manipulation techniques. Here we revisit them in the context of loops, because **naming output files correctly** is one of the trickiest parts of writing automated pipelines.

### 4.1 Recap: Parameter Expansion

```bash
# Remove suffix
filename="sample1.fastq.gz"
stem="${filename%.fastq.gz}"   # sample1

# Remove prefix (shortest match from start)
echo "${filename#*.}"          # fastq.gz

# basename: strip directory path
path="/home4/VBG_data/BashDatasets/fastq_data/sample1.fastq.gz"
filename=$(basename "$path")   # sample1.fastq.gz
stem="${filename%.fastq.gz}"   # sample1
```

### 4.2 Using String Manipulation Inside a Loop

The real power comes from combining loops with parameter expansion so that each iteration produces correctly named output files:

```bash
for file in fastq_data/*.fastq.gz
do
  filename=$(basename "$file")
  stem="${filename%.fastq.gz}"
  echo "Input:  $file"
  echo "Output: ${stem}_results.txt"
done
```

### 4.3 Building Output Paths from Variables

Inside a pipeline loop you frequently need to build paths by embedding multiple variables together. Enclose variable names in `{}` curly braces when they are followed immediately by text to avoid ambiguity:

```bash
sample="SRR1748193"
outdir="results/${sample}"
logfile="${outdir}/${sample}_log.txt"
bam="${outdir}/${sample}.bam"

echo "Results go in: $outdir"
echo "Log file:      $logfile"
echo "BAM file:      $bam"
```

Output:
```
Results go in: results/SRR1748193
Log file:      results/SRR1748193/SRR1748193_log.txt
BAM file:      results/SRR1748193/SRR1748193.bam
```



---

**Task 5:** Write a script that loops through each file in the `BashDatasets/` directory (not subdirectories) and for each file prints:
1. The full file path
2. The filename only (no path)
3. The stem (no path, no extension)
4. The extension

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
for file in ~/BashDatasets/*; do
  [ -f "$file" ] || continue   # skip directories

  filename=$(basename "$file")
  ext="${filename##*.}"
  stem="${filename%.*}"

  echo "Full path: $file"
  echo "Filename:  $filename"
  echo "Stem:      $stem"
  echo "Extension: $ext"
  echo "---"
done
  ```
</details>

---

## 5: Integer Arithmetic

Use `$(( ))` for integer arithmetic in bash:

```bash
a=5
b=3
echo $((a + b))   # 8
echo $((a - b))   # 2
echo $((a * b))   # 15
echo $((a / b))   # 1  (integer division, no decimals)
echo $((a % b))   # 2  (remainder/modulus)
```

This is useful for example to calculate the number of reads in a FASTQ file (each read = 4 lines):

```bash
#!/bin/bash
file="$1"
lines=$(wc -l < "$file")
reads=$((lines / 4))
echo "Number of reads in $file: $reads"
```

---

**Task 6:** Write a script called `count_reads.sh` that accepts a (uncompressed) FASTQ file as input and prints the number of reads it contains.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
file="$1"
lines=$(wc -l < "$file")
reads=$((lines / 4))
echo "Number of reads in '$file': $reads"
  ```
</details>

---

## 6: Creating Output Directories and Log Files

When writing scripts that generate results, it is good practice to create a dedicated output directory for each sample. The `-p` flag tells `mkdir` to create parent directories as needed and **not complain if the directory already exists** — making it safe to use inside loops:

```bash
mkdir -p results/sample1
```

Inside a loop, you can do this automatically:

```bash
for r1 in fastq_data/paired_end/*_1.fq; do
  filename=$(basename "$r1")
  stem="${filename%_0_1.fq}"
  mkdir -p "results/$stem"
  echo "Created results/$stem"
done
```



---

## 7: Automating Read Quality Control

Now we bring everything together. We will write a script to automate quality control for multiple FASTQ files.

We will use two tools:
- **FastQC** — generates quality reports for FASTQ files
- **TrimGalore!** — trims adapter sequences and low-quality bases; can also detect adaptor type automatically

```bash
fastqc filename.fastq.gz            # run FastQC
trim_galore [flags] filename.fastq.gz   # run TrimGalore!
```

TrimGalore can auto-detect adaptors, but it can also be told explicitly:
- `--illumina` for standard Illumina TruSeq adapters
- `--nextera` for Nextera transposase adapters

### 7.1 Single-End Files

**Task 7:** Write a bash script that loops through each `.fastq.gz` file in `fastq_data/` (not the `paired_end` subdirectory), runs `fastqc` on each file, then runs `trim_galore` using the correct adaptor flag based on whether the filename contains `illumina` or `nextera`. Store output for each sample in a directory called `results/<stem>/`.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash

DATA_DIR="fastq_data"
RESULTS_DIR="results"
mkdir -p "$RESULTS_DIR"

for file in "$DATA_DIR"/*.fastq.gz; do
  filename=$(basename "$file")
  stem="${filename%.fastq.gz}"
  outdir="$RESULTS_DIR/$stem"
  mkdir -p "$outdir"

  echo "Processing: $filename"

  # Run FastQC before trimming
  fastqc "$file" --outdir "$outdir"

  # Determine adaptor type from filename and trim
  if [[ "$filename" == *illumina* ]]; then
    echo "Detected Illumina adapters"
    trim_galore --illumina "$file" --output_dir "$outdir"

  elif [[ "$filename" == *nextera* ]]; then
    echo "Detected Nextera adapters"
    trim_galore --nextera "$file" --output_dir "$outdir"

  else
    echo "Unknown adapter type — using auto-detection"
    trim_galore "$file" --output_dir "$outdir"
  fi

  echo "Done: $stem"
  echo "---"
done
  ```
</details>

---

### 7.2 Paired-End Files

Paired-end reads come in pairs: a read 1 file (e.g. `SRR1748193_0_1.fq`) and a read 2 file (e.g. `SRR1748193_0_2.fq`). Rather than looping over all files and processing each one individually, we loop over only the **read 1 files** and **derive** the read 2 filename automatically using parameter expansion.

Look at the files in the paired-end directory:

```bash
ls fastq_data/paired_end/
```

You should see four sample pairs:
- `SRR1748193_0_1.fq` and `SRR1748193_0_2.fq`
- `SRR1748194_0_1.fq` and `SRR1748194_0_2.fq`
- `SRR1748195_0_1.fq` and `SRR1748195_0_2.fq`
- `SRR1748196_0_1.fq` and `SRR1748196_0_2.fq`

The pattern is clear: replace `_1.fq` with `_2.fq` to get the paired file. We can do this with parameter expansion:

```bash
r1="fastq_data/paired_end/SRR1748193_0_1.fq"
r2="${r1%_1.fq}_2.fq"
echo $r2   # fastq_data/paired_end/SRR1748193_0_2.fq
```

And we can derive the sample name:

```bash
filename=$(basename "$r1")     # SRR1748193_0_1.fq
sample="${filename%_0_1.fq}"   # SRR1748193
echo $sample
```

### 7.3 Understanding TrimGalore! Output Filenames

> [!IMPORTANT]
> This is one of the most common points of confusion when writing pipeline scripts.

When TrimGalore! trims a paired-end sample, it automatically creates output files with `_val_1.fq` and `_val_2.fq` appended to the input filename stem. For example:

| Input file | TrimGalore! output |
|------------|--------------------|
| `SRR1748193_0_1.fq` | `SRR1748193_0_1_val_1.fq` |
| `SRR1748193_0_2.fq` | `SRR1748193_0_2_val_2.fq` |

This means that **after running trim_galore**, the filenames you need to pass to the next tool (e.g. `bwa`) are **different** from what you put in. You must derive the trimmed filenames in your script:

```bash
# Input files (before trimming)
r1="SRR1748193_0_1.fq"
r2="SRR1748193_0_2.fq"

# Run TrimGalore
trim_galore --paired "$r1" "$r2"

# Derive the trimmed output filenames
file1=$(basename "$r1")
file2=$(basename "$r2")
trim1="${file1%.fq}_val_1.fq"    # SRR1748193_0_1_val_1.fq
trim2="${file2%.fq}_val_2.fq"    # SRR1748193_0_2_val_2.fq

echo "Trimmed read 1: $trim1"
echo "Trimmed read 2: $trim2"

# Now use the trimmed files in the next step
# bwa mem reference.fasta "$trim1" "$trim2" > output.sam
```

For single-end files TrimGalore! appends `_trimmed.fq` instead:

| Input file | TrimGalore! output |
|------------|--------------------|
| `illumina_10K.fastq.gz` | `illumina_10K_trimmed.fq` |

**Task 8:** Write a bash script that loops through the **read 1 files** in `fastq_data/paired_end/`, derives the read 2 filename and sample name automatically, runs `fastqc` on both files, then runs `trim_galore` in paired-end mode (`--paired`). Store output in `results/<sample_name>/`.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash

DATA_DIR="fastq_data/paired_end"
RESULTS_DIR="results"
mkdir -p "$RESULTS_DIR"

for r1 in "$DATA_DIR"/*_1.fq; do
  # Derive R2 filename
  r2="${r1%_1.fq}_2.fq"

  # Get sample name
  filename=$(basename "$r1")
  sample="${filename%_0_1.fq}"

  outdir="$RESULTS_DIR/$sample"
  mkdir -p "$outdir"

  echo "Processing sample: $sample"
  echo "  R1: $r1"
  echo "  R2: $r2"

  # Run FastQC on both reads
  fastqc "$r1" --outdir "$outdir"
  fastqc "$r2" --outdir "$outdir"

  # Run TrimGalore in paired-end mode
  trim_galore --paired "$r1" "$r2" --output_dir "$outdir"

  echo "Done: $sample"
  echo "---"
done
  ```
</details>

---

## 8: Extension Tasks — Practising Bash

The following tasks are for students who finish early or want extra practice. These are open-ended — try to write the solution yourself before checking.

**Task 9:** Write a script that **reverse complements** a DNA sequence provided as a command-line argument.

<details>
  <summary>Hint and solution</summary>

  Hint: `rev` reverses a string; `tr` can translate characters (A↔T, C↔G).

  ```bash
#!/bin/bash
seq="$1"
echo "$seq" | tr 'ACGTacgt' 'TGCAtgca' | rev
  ```
</details>

**Task 10:** Improve your reverse complement script so that it reads a sequence from a FASTA file provided on the command line (assume a single sequence only).

<details>
  <summary>Hint and solution</summary>

  ```bash
#!/bin/bash
file="$1"
seq=$(grep -v ">" "$file")   # remove the header line
echo "$seq" | tr 'ACGTacgt' 'TGCAtgca' | rev
  ```
</details>

**Task 11:** Extend Task 10 so that the script first checks the FASTA file contains exactly one sequence. If it contains more than one, print an error message and exit.

<details>
  <summary>Hint and solution</summary>

  ```bash
#!/bin/bash
file="$1"
count=$(grep -c ">" "$file")
if [ "$count" -ne 1 ]; then
  echo "Error: $file contains $count sequences. Expected exactly 1."
  exit 1
fi
seq=$(grep -v ">" "$file")
echo "$seq" | tr 'ACGTacgt' 'TGCAtgca' | rev
  ```
</details>

**Task 12:** Write a script that converts a FASTQ file to a FASTA file. The input and output filenames should be provided on the command line.

<details>
  <summary>Hint and solution</summary>

  In FASTQ format: line 1 = header (starts with @), line 2 = sequence, line 3 = + separator, line 4 = quality scores. To convert to FASTA: keep line 2 (sequence), change the `@` to `>` in line 1, discard lines 3 and 4.

  Since we are practicing loops, we can do this without `awk` by using a `while read` loop to read the file line by line, and keeping track of the line number using integer arithmetic:

  ```bash
#!/bin/bash
input="$1"
output="$2"

# Clear the output file if it exists, or create a new one
rm -f "$output"
touch "$output"

count=1
# Read the file line by line
while read line; do
  rem=$((count % 4))
  
  if [ "$rem" -eq 1 ]; then
    # Header line: remove the @ prefix and prepend >
    echo ">${line#@}" >> "$output"
  elif [ "$rem" -eq 2 ]; then
    # Sequence line: just print the sequence
    echo "$line" >> "$output"
  fi
  
  ((count++))
done < "$input"
  ```
</details>

**Task 13:** Write a script that counts the number of sequences in a file. The input can be either FASTA or FASTQ format. Check the file extension first and count accordingly.

<details>
  <summary>Hint and solution</summary>

  ```bash
#!/bin/bash
file="$1"
ext="${file##*.}"

if [[ "$ext" == "fasta" || "$ext" == "fa" ]]; then
  count=$(grep -c ">" "$file")
  echo "$file (FASTA): $count sequences"
elif [[ "$ext" == "fastq" || "$ext" == "fq" ]]; then
  lines=$(wc -l < "$file")
  count=$((lines / 4))
  echo "$file (FASTQ): $count sequences"
else
  echo "Unknown file format: .$ext"
  exit 1
fi
  ```
</details>

**Task 14:** Write a script that loops through all FASTQ files in `fastq_data/` and counts the number of reads in each file.

<details>
  <summary>Hint and solution</summary>

  Note: files are gzipped (`.fastq.gz`), so use `zcat` to uncompress on the fly before counting lines.

  ```bash
#!/bin/bash
for file in fastq_data/*.fastq.gz; do
  lines=$(zcat "$file" | wc -l)
  reads=$((lines / 4))
  echo "$(basename $file): $reads reads"
done
  ```
</details>

---

## Summary

| Concept | Syntax |
|---------|--------|
| `for` loop over list | `for x in a b c; do ...; done` |
| `for` loop over files | `for file in dir/*.ext; do ...; done` |
| `for` loop over range | `for i in {1..10}; do ...; done` |
| `while` loop | `while [ condition ]; do ...; done` |
| `until` loop | `until [ condition ]; do ...; done` |
| Increment counter | `((i++))` |
| Numeric comparison | `[ $a -lt $b ]` `-lt -gt -le -ge -eq -ne` |
| String equality | `[[ "$a" == "$b" ]]` |
| String contains | `[[ "$a" == *"substring"* ]]` |
| File exists | `[ -f "$file" ]` |
| Directory exists | `[ -d "$dir" ]` |
| Integer arithmetic | `$((a + b))` |
| `basename` | Extract filename from path |
| Strip suffix | `${var%suffix}` |
| Strip prefix | `${var#prefix}` |
| Make directory (safe) | `mkdir -p outdir` |

---

> **Coming up next:** In tomorrow's group session, you will combine everything you've learnt — text processing, file naming, conditions, and loops and all the bioinformatic tool commands — to build a complete automated reference assembly pipeline that processes multiple samples.
