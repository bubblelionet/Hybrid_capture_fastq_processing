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
module load samtools

# Directory for output
INPUT_DIR="/cluster/projects/lokgroup/rotations_students/victoria_gao/hybridcap_baseline_sam"

OUTPUT_DIR="/cluster/projects/lokgroup/rotations_students/victoria_gao/hybridcap_baseline_bam"



# Loop through each FASTQ file in the directory
for SAM_FILE in "$INPUT_DIR"/*.sam; do
    # Extract base name of file for naming output
    BASE_NAME=$(basename "$SAM_FILE" .sam)

    # Define output file names
    OUTPUT_BAM="$OUTPUT_DIR/${BASE_NAME}.bam"

    # Convert SAM to BAM
    samtools view -Sb "$SAM_FILE" > "$OUTPUT_BAM"

    echo "Created bam files: $BASE_NAME"
done

echo "All bam files created!"