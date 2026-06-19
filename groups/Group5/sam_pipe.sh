#!/bin/bash
# pipeline to convert a .sam file to .bam, index, count mapped reads and save in file, weeSAM coverage plot and delete sam
path=$1
echo "PATH" $path
filename=$(basename $path)

echo $filename

stem=${filename%.sam}

echo $stem

samtools sort $path -o ${stem}.bam 

echo "hi"

samtools index ${stem}.bam

echo "hello"

samtools view -c F4 ${stem}.bam > ${stem}_counted.txt

weeSAM --bam ${stem}.bam --html ${stem} 



