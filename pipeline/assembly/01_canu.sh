#!/usr/bin/bash
#SBATCH -p short -N 1 -n 4 --mem 8gb --out logs/canu_launch.log

OUTDIR=assembly
OUTNAME=DAOM_BR111_r1
PROJECT=Sp_DAOM_BR111
GENOMESIZE=25m
mkdir -p $OUTDIR

module load canu
FASTQ=DNA/DAOM_BR117/m54089_210413_162225.subreads.fastq.gz

canu -pacbio $FASTQ -d $OUTDIR/$OUTNAME -p $PROJECT useGrid=true gridOptions="-p short" genomeSize=${GENOMESIZE}
