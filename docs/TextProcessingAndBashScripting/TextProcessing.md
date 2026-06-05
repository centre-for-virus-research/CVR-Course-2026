# Bash File Editing & Text Processing

## Introduction to Viral Bioinformatics Training Course
* Monday 15th - Friday 19th June 2026
* MRC-University of Glasgow Centre for Virus Research
* University of Glasgow, Garscube Campus, Glasgow, G61 1QH

### Instructor
[Joseph Hughes](https://www.gla.ac.uk/schools/infectionimmunity/staff/josephhughes/)

---

## Overview

This tutorial introduces the fundamentals of command-line text processing and Bash scripting. Linux is especially useful for life scientists and bioinformaticians who regularly handle large datasets such as genome sequences and metadata tables.

### Learning Objectives

By the end of this session you will be able to:

1. Search files for patterns using `grep`
2. Preview and extract sections of files with `head`, `tail`, and `cat`
3. Count lines, words, and characters with `wc`
4. Pipe commands together and redirect output to files
5. Sort and deduplicate data with `sort` and `uniq`
6. Select columns from tabular data using `cut`
7. Find and replace text using `sed`
8. Write your first Bash script and pass arguments to it
9. Store command output in a variable inside a script
10. Manipulate filenames using **parameter expansion** — a key skill for building automated pipelines

---

## Setup

The data for this session is in `/home4/VBG_data/BashDatasets/`. Copy the whole directory into your home directory and then move into it:

```bash
cp -r /home4/VBG_data/BashDatasets/ ~/
cd ~/BashDatasets
```

List the files you now have:

```bash
ls
```

You should see the following files:

| File | Description |
|------|-------------|
| `sc2.fasta` | SARS-CoV-2 Wuhan-Hu-1 reference genome (single sequence, FASTA format) |
| `omicron.fasta` | SARS-CoV-2 Omicron variant genome (single sequence, FASTA format) |
| `sarscov2.gb` | SARS-CoV-2 genome annotation in GenBank format |
| `metadata.csv` | COVID-19 sequencing metadata from the UK (comma-separated, ~11,000 rows) |
| `fastq_data/` | A directory containing Illumina sequencing reads |

---

## 1. Text Processing

### 1.1 Searching using `grep` (Global Regular Expression Print)

`grep` searches for and prints lines that contain a specified pattern. These patterns can be simple (a word or character) or complex (using regular expression / regex syntax). 

A FASTA file contains sequences prefixed by a header line that starts with a `>` character. We can use `grep` to extract just the headers:

```bash
grep ">" sc2.fasta
```

<details>
  <summary>Expected output</summary>

  ```
>NC_045512.2 Severe acute respiratory syndrome coronavirus 2 isolate Wuhan-Hu-1, complete genome
  ```
</details>

Another example: extracting gene names from a GenBank file.

```bash
grep "gene=" sarscov2.gb
```

<details>
  <summary>Expected output</summary>

  ```
                     /gene="ORF1ab"
                     /gene="S"
                     /gene="ORF3a"
                     /gene="E"
                     /gene="M"
                     /gene="ORF6"
                     /gene="ORF7a"
                     /gene="ORF7b"
                     /gene="ORF8"
                     /gene="N"
                     /gene="ORF10"
  ```
</details>

We can go further and use the `-o` flag to print **only the matching part** of each line (rather than the whole line), combined with a regular expression `'".*"'` that captures everything inside double quotes:

```bash
grep "gene=" sarscov2.gb | grep -o '".*"'
```

<details>
  <summary>Expected output</summary>

  ```
"ORF1ab"
"S"
"ORF3a"
"E"
"M"
"ORF6"
"ORF7a"
"ORF7b"
"ORF8"
"N"
"ORF10"
  ```
</details>

`grep` is one of the most powerful commands for processing text files in Linux, and is especially useful when combined with other commands via pipes (see Section 1.4).

**Task 1:** Extract all lines containing the paper titles ("TITLE") from the `sarscov2.gb` file.

<details>
  <summary>Don't cheat</summary>

  ```bash
grep "TITLE" sarscov2.gb
  ```
</details>

---

### 1.2 `head` and `tail` for File Previews

Use `head` to look at the top lines of a file. The `-n` flag specifies how many lines to show:

```bash
head -n 5 metadata.csv
tail -n 3 metadata.csv
```

A useful trick: `tail -n +<N>` skips the first N-1 lines. So the following skips the header line. This can be particularly useful when working with files that have column names (or other non-sequence information) in the first lines:

```bash
tail -n +2 metadata.csv
```

---

### 1.3 `wc` for Line and Word Counts

`wc` counts lines (`-l`), words (`-w`), or characters (`-c`) in a file:

```bash
wc -l metadata.csv
```

<details>
  <summary>Expected output</summary>

  ```
11427 metadata.csv
  ```
</details>

---

### 1.4 Piping and Redirecting (`|`, `>`, `>>`)

We can chain commands together using the **pipe** (`|`) operator, which takes the output of one command and passes it as input to the next. Using `head` and `tail` together, we can extract lines 495–500:

```bash
head -n 500 metadata.csv | tail -n 5
```

<details>
  <summary>Expected output</summary>

  ```
UK,UK-ENG,NORTHAMPTONSHIRE,MILK-28E97EC,2021-10-31,SANG,97,AY.4
UK,UK-ENG,GREATER LONDON,HSLL-28E764B,2021-10-28,SANG,96,AY.4
UK,UK-ENG,EAST RIDING OF YORKSHIRE,QEUH-28E3946,2021-10-31,SANG,97,AY.4
UK,UK-ENG,GREATER LONDON,HSLL-28E7A4F,2021-10-28,SANG,96,AY.4
UK,UK-NIR,BELFAST,NIRE-014205,2021-10-21,NIRE,95,AY.4
  ```
</details>

To save the output to a file, use the **redirect** operator `>`:

```bash
head -n 500 metadata.csv | tail -n 5 > 5_rows.txt
```

The `>` creates the file if it doesn't exist, or **overwrites** it if it does. To **append** to an existing file without erasing it, use `>>`:

```bash
head -n 505 metadata.csv | tail -n 5 >> 5_rows.txt
```

**Task 2:** Get the first line of `metadata.csv` and save it as a new file called `header.csv`. 

<details>
  <summary>Don't cheat</summary>

  ```bash
head -n 1 metadata.csv > header.csv
  ```
</details>

---

### 1.5 `cat` to View and Concatenate

To check whether we successfully appended rows to the file, we can use `cat` to display its contents:

```bash
cat 5_rows.txt
```

`cat` can also be used to **concatenate** (join) two or more files into one. For example, to combine two FASTA files:

```bash
cat sc2.fasta omicron.fasta > two_seq.fasta
```

---

**Task 3:** Use `grep` to check that you now have two sequences in the `two_seq.fasta` file. Then count exactly how many sequences there are using a pipe.

<details>
  <summary>Don't cheat</summary>

  ```bash
grep ">" two_seq.fasta
grep ">" two_seq.fasta | wc -l
  ```
</details>

**Task 4:** Use `head` to retrieve the first (header) line of `metadata.csv` and save it to a new file called `header.csv`.

<details>
  <summary>Don't cheat</summary>

  ```bash
head -n 1 metadata.csv > header.csv
  ```
</details>

**Task 5:** Retrieve lines 90–100 of `metadata.csv` and save them as `10line_metadata.csv`.

<details>
  <summary>Don't cheat</summary>

  ```bash
head -n 100 metadata.csv | tail -n 10 > 10line_metadata.csv
  ```
</details>

**Task 6:** Combine `header.csv` and `10line_metadata.csv` into a new file called `subset.csv`.

<details>
  <summary>Don't cheat</summary>

  ```bash
cat header.csv 10line_metadata.csv > subset.csv
  ```
</details>

---

### 1.6 Sorting with `sort`

The `sort` command sorts lines in a file. Two useful flags when sorting tabular data:
- `-t` specifies the column separator character
- `-k` specifies which column to sort on

```bash
sort 5_rows.txt -t "," -k 5
```

<details>
  <summary>Expected output</summary>

  ```
UK,UK-NIR,ARDS AND NORTH DOWN,NIRE-0142c6,2021-10-20,NIRE,95,AY.4
UK,UK-NIR,BELFAST,NIRE-014205,2021-10-21,NIRE,95,AY.4
...
  ```
</details>

By specifying the separator as `,` and `-k 5`, we sorted by the 5th column (the date). By default the order is ascending; use `-r` to reverse. The `-u` flag also makes the output unique (similar to `sort | uniq`).

**Task 6:** Use `head` to retrieve the first 10 lines of `metadata.csv` and sort the output by the 3rd column.

<details>
  <summary>Don't cheat</summary>

  ```bash
head -n 10 metadata.csv | sort -t "," -k 3
  ```
</details>

---

### 1.7 Selecting Columns with `cut`

`cut` selects fields from each line of a file. Use `-d` to specify the delimiter and `-f` to specify which column(s) to extract:

```bash
cut -d"," -f1,5 5_rows.txt
```

<details>
  <summary>Expected output</summary>

  ```
UK,2021-10-31
UK,2021-10-28
...
  ```
</details>

The `-f` flag accepts comma-separated column numbers or ranges (e.g. `-f1,5` or `-f1-3`).

---

### 1.8 Filtering Duplicates with `uniq`

`uniq` filters consecutive duplicate lines. It works best on sorted input. Here we select the 2nd column, sort it, then count unique values:

```bash
cut -d "," -f 2 5_rows.txt | sort | uniq
```

```
UK-ENG
UK-NIR
```

The `-c` flag counts occurrences:

```bash
cut -d "," -f 2 5_rows.txt | sort | uniq -c
```

```
      7 UK-ENG
      3 UK-NIR
```

---

**Task 7:** Use `head` to retrieve the first 1000 data lines of `metadata.csv` (i.e. excluding the header), then retrieve the 2nd column and count the number of unique occurrences of each entry.

<details>
  <summary>Don't cheat</summary>

  ```bash
tail -n +2 metadata.csv | head -n 1000 | cut -d"," -f2 | sort | uniq -c
  ```
</details>

---

### 1.9 `sed` (Stream Editor)

`sed` edits a text stream — it can print, delete, and substitute text. 

**Printing specific lines** with `p` (use `-n` to suppress the default full-file print):

```bash
sed -n "1p" metadata.csv
sed -n "1,5p" metadata.csv
```

**Deleting lines** with `d`:

```bash
sed "1d" metadata.csv | head -n 1
```

This removes the header line; the first line printed is now the first data row. Note: `sed` does **not** modify the original file unless you use the `-i` flag.

**Substituting text** with `s/search/replace/`:

```bash
head -n 1 subset.csv | sed 's/country/COUNTRY/'
```

By default `sed` only replaces the **first** occurrence on each line. Use `g` (global) to replace all:

```bash
sed 's/UK/United Kingdom/g' metadata.csv | head -n 5
```

---

**Task 8:** Get the lines from `metadata.csv` that have `UK-SCT` in them, substitute `UK-SCT` for `Scotland`, then save the output to a new file called `modified_metadata.csv`.

<details>
  <summary>Don't cheat</summary>

  ```bash
grep "UK-SCT" metadata.csv | sed 's/UK-SCT/Scotland/' > modified_metadata.csv
  ```
</details>

---

## 2. Bash Shell Scripts

### 2.1 What is a Shell Script?

* A **shell script** is a text file containing a sequence of Linux commands.
* Scripts typically start with a **shebang** (`#!`) followed by the path to the shell interpreter: `#!/bin/bash`.
* Lines beginning with `#` are **comments** — they are ignored by the interpreter but are vital for explaining what the script does.
* Commands are executed **sequentially** from top to bottom.

### 2.2 Why Write Scripts?

* Automate repetitive tasks (e.g. processing multiple files)
* Ensure reproducibility
* Simplify complex data workflows
* Schedule jobs on a computing cluster

### 2.3 The `nano` Text Editor

`nano` is a simple command-line text editor. Open a new or existing file with:

```bash
nano new_file.txt
```

Type your content, then:
- **Save**: `Ctrl + O`, then press `Enter`
- **Exit**: `Ctrl + X`

The keyboard shortcuts are shown at the bottom of the nano interface.

**Task 9:** Open a new text file with `nano`, add some text, save the file and exit.

---

### 2.4 Your First Script

Open `nano` and type the following three lines:

```bash
#!/bin/bash
# This is our first script
echo "Hello World"
```

**Task 10:** Save this as `hello.sh`, then make it executable and run it:

```bash
chmod +x hello.sh
./hello.sh
```

The `chmod +x` command makes the script executable. You then run it with `./hello.sh`.

---

### 2.5 Using Variables

#### 2.5.1 Hardcoding a value into a variable

```bash
#!/bin/bash
filename="sc2.fasta"
echo $filename
```

#### 2.5.2 Accepting Arguments from the Command Line

It is much more useful to write scripts that accept input filenames on the command line. Open `nano` and save the following as `script.sh`:

```bash
#!/bin/bash
echo $1
echo $2
```

Make it executable and run it:

```bash
chmod +x script.sh
./script.sh file1.txt file2.txt
```

`$1` holds the first argument, `$2` the second, and so on.

**Task 11:** Modify `hello.sh` to accept two arguments: `name` and `surname`. Print the surname first, then the name.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
name=$1
surname=$2
echo "$surname $name"
  ```
</details>

---

#### 2.5.3 Storing Command Output in a Variable

The output of any command can be captured into a variable using `$(...)`:

```bash
#!/bin/bash
count=$(grep ">" two_seq.fasta | wc -l)
echo "Number of sequences: $count"
```

**Task 12:** Write a script called `count_genes.sh` that takes the GenBank file `sarscov2.gb` as a command-line argument and counts how many **unique** gene names the file has. Print the filename and the count.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
filename=$1
count=$(grep "gene=" $filename | grep -o '".*"' | sort | uniq | wc -l)
echo "Number of unique genes in $filename: $count"
  ```
</details>

---

## 3. File Naming and Parameter Expansion

This is one of the most important skills for building automated pipelines. When processing many files, you need to derive output filenames automatically from input filenames — so you don't have to type a new name for every file.

### 3.1 Removing a Suffix with `%`

`${variable%pattern}` removes the **shortest match** of `pattern` from the **end** (suffix) of the variable's value.

```bash
#!/bin/bash
input="metadata.csv"
echo ${input%.csv}        # prints: metadata
echo ${input%.csv}.txt    # prints: metadata.txt
```

This is useful for changing file extensions, e.g. turning an input `.fastq` file into a named output file:

```bash
input="sample1.fastq"
output="${input%.fastq}_trimmed.fastq"
echo $output   # prints: sample1_trimmed.fastq
```

### 3.2 Removing a Prefix with `#` or `##`

`${variable#pattern}` removes the **shortest match** from the **beginning** (prefix):

```bash
path="/home4/VBG_data/BashDatasets/metadata.csv"
echo ${path#*/}    # removes first / (prints home4/VBG_data/BashDatasets/metadata.csv)
```

By using a double hash `##`, it removes the **longest match** instead. This is extremely useful for extracting a file extension:

```bash
filename="sample1.fastq.gz"
echo ${filename##*.}   # removes everything up to the last dot (prints: gz)
```

### 3.3 Working with Full File Paths using `basename`

When your script receives a full path like `/home4/VBG_data/BashDatasets/sample1.fastq`, you usually only want the filename (`sample1.fastq`). The `basename` command extracts it:

```bash
path="/home4/VBG_data/BashDatasets/metadata.csv"
filename=$(basename "$path")
echo $filename        # metadata.csv

# Then strip the extension:
stem="${filename%.csv}"
echo $stem            # metadata
```

### 3.4 Combining basename and extension stripping

This pattern is extremely common in bioinformatics scripts:

```bash
#!/bin/bash
input="$1"                            # e.g. /data/sample1.fastq.gz
filename=$(basename "$input")         # sample1.fastq.gz
stem="${filename%.fastq.gz}"          # sample1
echo "Processing: $stem"
echo "Output will be: ${stem}_results.txt"
```

---

**Task 13:** Write a script called `rename_demo.sh` that accepts any filename as a command-line argument and prints:
1. Just the filename (without the path)
2. Just the stem (filename without extension)
3. A proposed output filename with `_output` appended before the extension

For example: if given `/home4/VBG_data/BashDatasets/metadata.csv`, it should print:
```
Filename: metadata.csv
Stem:     metadata
Output:   metadata_output.csv
```

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
input="$1"
filename=$(basename "$input")
ext="${filename##*.}"
stem="${filename%.*}"

echo "Filename: $filename"
echo "Stem:     $stem"
echo "Output:   ${stem}_output.${ext}"
  ```
</details>

---

**Task 14:** Modify `count_genes.sh` so that it saves the gene count to a file named automatically from the input filename. For example, if the input is `sarscov2.gb`, the output file should be `sarscov2_gene_count.txt`.

<details>
  <summary>Don't cheat</summary>

  ```bash
#!/bin/bash
filename=$1
stem=$(basename "${filename%.gb}")
count=$(grep "gene=" $filename | grep -o '".*"' | sort | uniq | wc -l)
outfile="${stem}_gene_count.txt"
echo $count > $outfile
echo "Wrote gene count ($count) to $outfile"
  ```

  Check the output:
  ```bash
  more sarscov2_gene_count.txt
  ```
  You should see `11`.
</details>

---

## Summary

| Command | What it does |
|---------|-------------|
| `grep "pattern" file` | Print lines matching a pattern |
| `grep -o "pattern" file` | Print only the matching portion |
| `head -n N file` | Show first N lines |
| `tail -n N file` | Show last N lines |
| `tail -n +N file` | Skip first N-1 lines |
| `wc -l file` | Count lines |
| `cmd1 \| cmd2` | Pipe output of cmd1 to cmd2 |
| `cmd > file` | Redirect output to file (overwrite) |
| `cmd >> file` | Redirect output to file (append) |
| `cat file1 file2` | Display / concatenate files |
| `sort -t"," -k N file` | Sort by column N using comma delimiter |
| `uniq -c` | Count unique consecutive lines |
| `cut -d"," -f N file` | Extract column N from CSV |
| `sed 's/old/new/'` | Substitute first occurrence per line |
| `sed 's/old/new/g'` | Substitute all occurrences per line |
| `${var%.ext}` | Remove suffix from variable |
| `${var#prefix}` | Remove prefix from variable |
| `basename path` | Extract filename from full path |
| `$(command)` | Capture command output into a variable |
| `$1, $2, ...` | Access command-line arguments in a script |
| `chmod +x script.sh` | Make a script executable |
