#!/bin/sh

#SBATCH -t 20:00:00
#SBATCH --mem=60G
#SBATCH -J bwa_alignment
#SBATCH -p himem
#SBATCH -c 1
#SBATCH -N 1
#SBATCH -o bwa_alignment_output_%j.txt
#SBATCH -e bwa_alignment_error_%j.txt


# Load modules or set paths (if required)
module load bwa
module load samtools
module load igenome-human/hg19


# Define path to the reference genome
# No need if loading the module igenome-human/hg19
# REF_GENOME="/path/to/hg19.fasta"

# Directory containing FASTQ files
FASTQ_DIR="/cluster/projects/lokgroup/rotations_students/victoria_gao/hybridcap_baseline_fastq_trimmed"

# Directory for output
OUTPUT_DIR="/cluster/projects/lokgroup/rotations_students/victoria_gao/hybridcap_baseline_sam_bam"

# Index the reference genome (if not already indexed)
# No need if loading the module igenome-human/hg19
# bwa index $REF_GENOME

# Loop through each pair of FASTQ files in the directory
# This is specifically for paired-end sequencing

# Loop through R1 FASTQ files in the directory
for R1_FASTQ in "$FASTQ_DIR"/*_R1_trimmed.fq.gz; do
    # Corresponding R2 FASTQ file
    R2_FASTQ="${R1_FASTQ/_R1_/_R2_}"

    # Extract base name for output file
    BASE_NAME=$(basename "${R1_FASTQ%_R1_trimmed.fq.gz}")

    # Define output SAM file name
    OUTPUT_SAM="$OUTPUT_DIR/${BASE_NAME}.sam"

    # Alignment with BWA
    bwa mem $BWAINDEX "$R1_FASTQ" "$R2_FASTQ" > "$OUTPUT_SAM"

    echo "Created sam file: $BASE_NAME"
done


# # Loop through each FASTQ file in the directory
# for SAM_FILE in "$OUTPUT_SAM"/*.sam; do
#     # Extract base name of file for naming output
#     BASE_NAME=$(basename "$OUTPUT_SAM" .sam)

#     # Define output file names
#     OUTPUT_BAM="$OUTPUT_DIR/${BASE_NAME}.bam"

#     # Convert SAM to BAM
#     samtools view -Sb $OUTPUT_SAM > $OUTPUT_BAM

#     echo "Created bam files: $BASE_NAME"
# done

# echo "All BWA alignments completed!"

