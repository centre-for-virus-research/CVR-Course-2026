#!/bin/bash
#this is the pipeline for processing the sam file
path=$1
filename=$(basename "$path")
echo $filename
stem="${filename%.sam}"
echo $filename
echo "Processing: $stem"
echo "output will be: ${stem}.bam"
samtools sort ${stem}.sam -o ${stem}.bam
samtools index ${stem}.bam
#rm ${stem}.sam

samtools view -c -F4 ${stem}.bam > ${stem}_mapped_reads.txt
weeSAM --bam ${stem}.bam --html ${stem} --overwrite

