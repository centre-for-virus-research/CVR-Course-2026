#!/bin/bash

#File inputs
filepath=$1
filename=$(basename $filepath)
file=${filename%.sam}

#Create bam, index
samtools sort $filepath -o ${file}.bam
samtools index ${file}.bam

#Count mapped reads, write to file
samtools view -c -F2308 ${file}.bam > ${file}_mappedreads.txt

#Create weeSAM report - for coverage etc.
weeSAM --bam ${file}.bam --html $file

#IVAR - create consensus
samtools mpileup -aa -A -d 0 -Q 0 ${file}.bam | ivar consensus -p ${file}.consensus
