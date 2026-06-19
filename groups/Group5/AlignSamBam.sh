
echo $R1 and $R2 asligned to $R3 giving $Output  > align_log.txt
#!bin/bash
#align script

R1=$1
R2=$2
REF=$3
Output=$4

# Align FASTQ to REF and create SAM

bwa mem -t 4 $REF  $R1 $R2 >  $Output


# Output step  Name of files

echo $R1 and $R2 asligned to $R3 giving $Output  > align_log.txt


# Convert SAM to BAM

bash sam_pipe.sh $Output

