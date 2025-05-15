#!/bin/bash
#SBATCH -c 1
#SBATCH --mem=30G
#SBATCH -t 12:00:00
#SBATCH -J Trimgalore
#SBATCH -o Pig1.out
#SBATCH -e Pig1.err


module load trimgalore/0.6.10
trim_galore --paired --gzip --quality 30 --fastqc --length 40 --stringency 1 --fastqc ERR2664200_1.fastq.gz ERR2664200_2.fastq.gz
