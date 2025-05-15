#!/bin/bash
#SBATCH -c 1
#SBATCH --mem=32G
#SBATCH -t 12:00:00
#SBATCH -J job-D_refs
#SBATCH -o Refs.out
#SBATCH -e Refs.err


set -euo pipefail

# === CONFIGURATION ===
ENSEMBL_RELEASE=110
BASE_DIR="$(pwd)/genomes"
echo "Submitting from: $(pwd)"
echo "Downloading into: $BASE_DIR"
SPECIES_LIST=("cow" "pig" "goat")

declare -A ENSEMBL_NAMES=(
  [cow]="bos_taurus"
  [pig]="sus_scrofa"
  [goat]="capra_hircus"
)

declare -A ASSEMBLY_NAMES=(
  [cow]="ARS-UCD1.2"
  [pig]="Sscrofa11.1"
  [goat]="ARS1"
)

declare -A FILE_PREFIXES=(
  [cow]="Bos_taurus"
  [pig]="Sus_scrofa"
  [goat]="Capra_hircus"
)

# === Download reference genomes and GTFs ===
for SPECIES in "${SPECIES_LIST[@]}"; do
  echo "Downloading genome for $SPECIES..."

  ENS_NAME="${ENSEMBL_NAMES[$SPECIES]}"
  ASM_NAME="${ASSEMBLY_NAMES[$SPECIES]}"
  FILE_PREFIX="${FILE_PREFIXES[$SPECIES]}"
  SPECIES_DIR="$BASE_DIR/$SPECIES"
  mkdir -p "$SPECIES_DIR"
  cd "$SPECIES_DIR"

  FASTA_URL="https://ftp.ensembl.org/pub/release-${ENSEMBL_RELEASE}/fasta/${ENS_NAME}/dna/${FILE_PREFIX}.${ASM_NAME}.dna.toplevel.fa.gz"
  GTF_URL="https://ftp.ensembl.org/pub/release-${ENSEMBL_RELEASE}/gtf/${ENS_NAME}/${FILE_PREFIX}.${ASM_NAME}.${ENSEMBL_RELEASE}.gtf.gz"

  echo "FASTA URL: $FASTA_URL"
  echo "GTF URL:   $GTF_URL"

  rm -f "${FILE_PREFIX}.${ASM_NAME}.dna.toplevel.fa.gz" "${FILE_PREFIX}.${ASM_NAME}.${ENSEMBL_RELEASE}.gtf.gz"

  wget -c "$FASTA_URL" -O "${FILE_PREFIX}.${ASM_NAME}.dna.toplevel.fa.gz"
  wget -c "$GTF_URL" -O "${FILE_PREFIX}.${ASM_NAME}.${ENSEMBL_RELEASE}.gtf.gz"

  cd "$BASE_DIR"
done


