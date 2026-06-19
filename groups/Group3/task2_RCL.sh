#!/bin/bash
#Task 2
fq1=$1
fq2=$2
ref=$3
sample_stem=${fq1%_R1.fq}
ref_stem=${ref%.fasta}
bwa index $ref
bwa mem -t 4 $ref $fq1 $fq2 > ${sample_stem}_${ref_stem}.sam

samtools sort ${sample_stem}_${ref_stem}.sam -o ${sample_stem}_${ref_stem}.bam
samtools index ${sample_stem}_${ref_stem}.bam
#rm ${sample_stem}_${ref_stem}.sam

samtools view -c -F4 ${sample_stem}_${ref_stem}.bam > ${sample_stem}_${ref_stem}_mapped_reads.txt
weeSAM --bam ${sample_stem}_${ref_stem}.bam --html ${sample_stem}_${ref_stem} --overwrite


