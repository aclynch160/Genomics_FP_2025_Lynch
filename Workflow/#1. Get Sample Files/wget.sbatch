#!/bin/bash
#SBATCH -c 1
#SBATCH --mem=24G
#SBATCH -t 12:00:00
#SBATCH -J Wget_files
#SBATCH -o wget.out
#SBATCH -e wget.err

module load uri/main all/SRA-Toolkit/3.0.3-gompi-2022a

wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR266/000/ERR2664200/ERR2664200_1.fastq.gz
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR266/000/ERR2664200/ERR2664200_2.fastq.gz
