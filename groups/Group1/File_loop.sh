#!/bin/bash

refpath=$1

for file in ./*R1.fq;
do R1path=$file; 
R2path=${R1path%R1.fq}R2.fq;
echo $R1path $R2path $refpath;
bash Aligner.sh $R1path $R2path $refpath
done
