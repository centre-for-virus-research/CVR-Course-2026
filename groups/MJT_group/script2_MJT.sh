#!/bin/bash

ref=$2

ref_name=$(basename "$ref")

path2=${sample_R1%R1.fq}

file_name=$(basename "$sample_R1")

bwa index $ref

path=$1

echo "$ref_name" > log.txt

for file in $path/*_R1.fq
do

  echo $file

path2=${file%_R1.fq}

file_name=$(basename "$path2")

bwa mem -t 4 $ref ${path2}_R1.fq ${path2}_R2.fq > "$file_name.sam"


echo "${file_name}.fq" >> log.txt

echo "${file_name}.sam" >> log.txt

bash /home4/course06/Richard/Sample1/script1/script1.sh "$file_name.sam"

done
