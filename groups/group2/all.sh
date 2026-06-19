#!/bin/bash

fastq1=$1
fastq2=$2
ref=$3

#output=$(echo $fastq1 |cut -d"_" -f1)
output=$(basename "$fastq1")
stem="${fastq1%_*}"


bwa index ${ref}

bwa mem -t 4 $ref $fastq1 $fastq2 > ${stem}.sam
 
