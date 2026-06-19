# Bash Scripting

Lets work with our nanopore-env as all the tools are there:

```
conda activate nanopore-env
```

Data is in:

```
/home4/VBG_data/ScriptData
```

# First task

Wite a bash script that:

1. Takes a sam file as input
2. Extracts the name of the same file (the bit excluding the .sam extension)
3. Sorts the SAM into a BAM
4. Indexing the BAM
5. Delete the SAM file - maybe comment this line out until the end
6. Count the number of mapped reads and place the results into a text log file
7. Create weeSAM coverage plot of the BAM

# Second Task

Data is in:

```
/home4/VBG_data/ScriptData2
```

New script that:

1. Takes a pair of FASTQ files
2. Takes a reference FASTA file
3. Aligns the FASTQs to the REF to create a SAM file
4. Create a log file that reprots the names of the FASTQS, REFs and SAM file for record keeping

# Third task

Expand your alignment script too call the SAM script.

The alignment script creates a SAM

Call the SAM script to convert it into a BAM

Call the script - dont copy the code in

# Fourth task

Write a loop script to loop over all the FASTQ pairs in a folder and run the alignment script on each one (the alignment script calls the SAM script)



