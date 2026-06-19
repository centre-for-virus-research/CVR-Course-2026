#!/bin/bash

echo "Enter: [fastq1] [fastq2] [reference]"

fq1path=$1
fq2path=$2
reference=$3


#Trim the reads
trim_galore -q 20 --length 50 --max_n 0 --paired $fq1path $fq2path
fq1path=${fq1path%_R1.fq}_R1_val_1.fq
fq2path=${fq2path%_R2.fq}_R2_val_2.fq

fq1name=$(basename $fq1path)
fq2name=$(basename $fq2path)
fq1=${fq1name%.fq}
fq2=${fq2name%.fq}
fq=${fq1%_R1}

echo "TEST HERE:"
echo $fq1path $fq2path

#FASTQC
fastqc $fq1path $fq2path

#Create an index of the reference file
bwa index $reference -p ${fq}_reference.index

#Run the reference alignment
bwa mem -t 4 ./${fq}_reference.index $fq1path $fq2path > ${fq}.sam

#Create a log of the filenames used
echo -e "FastQ1_name: $fq1name  $'\n' FastQ2_name: $fq2name $'\n' Reference_name:  $(basename $reference) $'\n' SAM_name:  ${fq}.sam " > log.txt

bash BAM_consensus.sh ${fq}.sam
bash Assembler.sh $fq1path $fq2path
