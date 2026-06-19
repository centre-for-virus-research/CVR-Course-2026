#!/bin/bash
path=$1
echo $path
filename=$(basename $path)
echo $filename
stem=${filename%.sam}
echo $stem
samtools sort $path -o ${stem}.bam 
samtools index ${stem}.bam
# rm $path
samtools view -c -F4 ${stem}.bam > ${stem}.log
weeSAM --bam ${stem}.bam --html ${stem} 

