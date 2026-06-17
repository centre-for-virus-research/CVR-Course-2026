# Metagenomics: Contig classification

### Author

Sreenu Vattipally
MRC-University of Glasgow Centre for Virus Research
University of Glasgow
G61 1QH, UK

---

In this practical. we will be classifying de novo-generated contigs by similarity search using Diamond BlastX.

Create a new directory

```
mkdir ~/Metagenomics
cd ~/Metagenomics
```

Copy the fastq reads

```
cp /home3/bvv2t/Data-Sreenu/Metagenomics/SRR30229922_?.fq .
```

Clean them using trim_galore.

```
trim_galore --illumina --length 50 -q 30 --paired SRR30229922_1.fq SRR30229922_2.fq
```

Here, we are not performing host removal, but it is recommended to speed up the process.

Using Spades, performing de novo assembly of the cleaned reads.

```
spades.py -t 4 --careful -k 21,45,73,101 --only-assembler -1 SRR30229922_1_val_1.fq -2 SRR30229922_2_val_2.fq -o SpadesOut
```


How many contigs did Spades generate? What are these contigs? Where do they come from? Are there any novel sequences in them?

Now search the NR database using the Diamond BlastX program. This search will take a considerable amount of time based on the input size.


```
diamond blastx --db /db/diamond/nr   -b14 -p 4 -c 2 -q SpadesOut/contigs.fasta --outfmt 6 qseqid sseqid pident nident length mismatch gapopen qstart qend sstart send evalue bitscore stitle sscinames staxids skingdoms sskingdoms sphylums salltitles -k 1 --out SRR30229922_diamondNR.blasttab
```



Copy precompiled results

```
cp /home3/bvv2t/Data-Sreenu/Metagenomics/SRR30229922_diamondNR-PC.blasttab .
```

Generate a Krona plot to explore the results

```
ktImportBLAST SRR30229922_diamondNR-PC.blasttab -o SRR30229922.html -tax /db/kronatools/taxonomy
```


Open the Krona results using Firefox

```
firefox SRR30229922.html 
```

What does the Krona plot tell? Do you find any bacteria in the sample? What are the different viruses that you see in the sample, and what is your take on them?


Please use these samples to check your pipeline.

```
cp /home3/bvv2t/Data-Sreenu/Metagenomics/SRR29970413_?.fq .
```

and

```
cp /home3/bvv2t/Data-Sreenu/Metagenomics/SRR29970403_?.fq .
```

