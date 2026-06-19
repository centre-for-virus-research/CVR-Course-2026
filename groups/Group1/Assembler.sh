#!/bin/bash

fq1=$1
fq2=$2
fq=${fq1%_R1_val_1.fq}


echo "HERE ARE THE INGOING READS: $fq1 $fq2"

#spades.py -t 4 --careful -k 21,45,73,101 --only-assembler -1 $fq1 -2 $fq2 -o ${fq}_assembly

/software/SPAdes-v4.0.0/bin/spades.py -t 4 --isolate -k 21,45,73,101  -1 $fq1 -2 $fq2 -o ${fq}_assembly


contigs=${fq}_assembly/contigs.fasta
echo $contigs
