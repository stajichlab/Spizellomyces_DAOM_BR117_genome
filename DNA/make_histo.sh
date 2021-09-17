#!/usr/bin/bash -l
#SBATCH -a 1 -p short -C xeon -N 1 -n 32 --mem 256gb --out make_histo.%a.log

CPU=${SLURM_CPUS_ON_NODE}
if [ -z $CPU ]; then
    CPU=1
fi

N=${SLURM_ARRAY_TASK_ID}
if [ -z $N ]; then
    N=1
fi
module load jellyfish
module load workspace/scratch

for n in $(ls */*_R1_001.fastq.gz | sed -n ${N}p )
do
 name=$(basename $n _L001_R1_001.fastq.gz | perl -p -e 's/_S\d+//')
 r=$(echo -n "$n" | perl -p -e 's/_R1/_R2/')
 echo "$name $n $r"
 if [ ! -f $name.histo ]; then
     mkdir -p $SCRATCH/$name
     pigz -dc $n > $SCRATCH/$name/$(basename $n .gz)
     pigz -dc $r > $SCRATCH/$name/$(basename $r .gz)
     jellyfish count -C -m 21 -s 5000000000 -t $CPU $SCRATCH/$name/*.fastq -o $SCRATCH/$name.jf
      jellyfish histo -t $CPU $SCRATCH/$name.jf > $name.histo
 fi
done
