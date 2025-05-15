#!/bin/bash
#SBATCH -c 8
#SBATCH --mem=48G
#SBATCH -t 16:00:00
#SBATCH -J star_index
#SBATCH -o STAR_index.out
#SBATCH -e STAR_index.err

set -euo pipefail

module load star/2.7.11a

# === CONFIGURATION ===
ENSEMBL_RELEASE=110
BASE_DIR="$(pwd)"
GENOME_DIR="${BASE_DIR}/genomes"
INDEX_DIR="${BASE_DIR}/star_index"
THREADS=8
SJDB_OVERHANG=100  # typical for 100 bp reads

SPECIES_LIST=("cow" "pig" "goat")

declare -A FILE_PREFIXES=(
  [cow]="Bos_taurus"
  [pig]="Sus_scrofa"
  [goat]="Capra_hircus"
)

declare -A ASSEMBLY_NAMES=(
  [cow]="ARS-UCD1.2"
  [pig]="Sscrofa11.1"
  [goat]="ARS1"
)

# === Build STAR index ===
for SPECIES in "${SPECIES_LIST[@]}"; do
  echo " Building STAR index for $SPECIES..."

  PREFIX="${FILE_PREFIXES[$SPECIES]}"
  ASM="${ASSEMBLY_NAMES[$SPECIES]}"
  SPECIES_GENOME_DIR="${GENOME_DIR}/${SPECIES}"
  FASTA="${SPECIES_GENOME_DIR}/${PREFIX}.${ASM}.dna.toplevel.fa"
  GTF="${SPECIES_GENOME_DIR}/${PREFIX}.${ASM}.${ENSEMBL_RELEASE}.gtf"
  OUTDIR="${INDEX_DIR}/${SPECIES}"

  mkdir -p "$OUTDIR"

  STAR --runThreadN "$THREADS"        --runMode genomeGenerate        --genomeDir "$OUTDIR"        --genomeFastaFiles "$FASTA"        --sjdbGTFfile "$GTF"        --sjdbOverhang "$SJDB_OVERHANG"

  echo " $SPECIES index complete."
done

echo " All STAR indices generated."
