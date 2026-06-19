#!
dir=$1
echo $dir
ref=$2
for fq1 in ${dir}/*_R1.fq
do
	echo $fq1
        fq2=${fq1%_R1.fq}_R2.fq
        echo $fq2
        bash all.sh $fq1 $fq2 $ref
done
