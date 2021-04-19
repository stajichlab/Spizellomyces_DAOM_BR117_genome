#!/usr/bin/bash
#SBATCH -p short -N 1 -n 2 --mem 8gb --out logs/bam2fastq.log

INFILE=DNA/DAOM_BR117/m54089_210413_162225.subreads.bam
OUTFILE=DNA/DAOM_BR117/m54089_210413_162225.subreads.fastq

if [[ -f $FASTQ || -f $FASTQ.gz ]]; then
  echo "Already ran bam2fastq to create $FASTQ"
  exit
fi

# data are all single-end/unpaired so best way to get that out is to redirect to file
# otherwise would use -o OUTFILE_#.fastq option which writes _1/_2/_M for fwd/rev/unpaired for other paired-end data

bam2fastq  --all-to-stdout $INFILE > $OUTFILE
pigz $OUTFILE
