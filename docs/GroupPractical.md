# Bash Scripting

Lets work with our nanopore-env as all the tools are there:

```
conda activate nanopore-env
```

# First task

Wite a bash script that:

1. Takes a SAM file as input
2. Extracts the name of the SAM file (the bit excluding the .sam extension)
3. Sorts the SAM into a BAM
4. Indexing the BAM
5. Deletes the SAM file - maybe comment this line out until the end
6. Counts the number of mapped reads and place the results into a text log file
7. Create weeSAM coverage plot of the BAM

Two example SAM files to work with on the first task are here, so copy them over to where you are working:

```
/home4/VBG_data/ScriptData
```

# Second task

Write a new script that:

1. Takes a pair of FASTQ files
2. Takes a reference FASTA file
3. Aligns the FASTQs to the REF to create a SAM file
4. Creates a log file that reports the names of the FASTQs, REFs and SAM file for record keeping


Two pairs of FASTQ files and ref FASTA are available here, so copy them over to start with:

```
/home4/VBG_data/ScriptData2
```

# Third task

Expand your alignment script to call the SAM script.

* The alignment script creates a SAM files
* Call the SAM script to convert it into a BAM
* Trying calling the script - dont copy the code from the SAM script into the ref one
  
# Fourth task

Write a loop script to loop over all the FASTQ pairs in a folder and run the alignment script on each one (the alignment script now calls the SAM script)

# Fifth task

Expand the alignment script to trim the reads with trim_galore first and use the trimmed reads for the alignment

# Sixth task

Populate the log file with as much info as you think is needed - number of raw reads, number of trimmed reads, number of unmapped reads, name of the reference seq (the actual seq name not file name), average coverage, etc

# Seventh task

Loop over the paired FQ reads and run spades to do the de novo aseembly on each. Make a new script for this (not at the end of the alignment one) - run spades (4 threads) on 
