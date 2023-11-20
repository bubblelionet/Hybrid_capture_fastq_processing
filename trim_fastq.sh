#!/bin/sh

#SBATCH -t 1-00:00:00
#SBATCH --mem=60G
#SBATCH -J fastq_trimming
#SBATCH -p himem
#SBATCH -c 1
#SBATCH -N 1
#SBATCH -o trimgalore_trim_output_%j.txt
#SBATCH -e trimgalore_trim_error_%j.txt


# Load modules or set paths (if required)
module load trim_galore

# Directory containing FASTQ files
FASTQ_DIR="/cluster/projects/lokgroup/rotations_students/hybrid_capture_baseline"

# Directory for output
OUTPUT_DIR="/cluster/projects/lokgroup/rotations_students/victoria_gao/hybridcap_baseline_fastq_trimmed"

# Loop through each FASTQ file in the directory
for FASTQ_FILE in "$FASTQ_DIR"/*.fastq.gz; do
    # Extract base name of file for naming output
    # BASE_NAME=$(basename "${FASTQ_FILE%.fq.gz}" )

    # Remove adapters from fastq
    trim_galore --quality 20 --gzip --fastqc $FASTQ_FILE -o $OUTPUT_DIR

    echo "Trimmed $BASE_NAME"
done

echo "All FASTQ adapters trimmed!"
