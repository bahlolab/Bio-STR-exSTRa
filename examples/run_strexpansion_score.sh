# Running exSTRa

### Configuration

# Set bam_glob to include all bam files you wish to analyse (multiple runs may be combined in R exSTRa later)
bam_glob="path/to/bams/*.bam"

# Output tab delimited file
output=output/exSTRa_scores.txt

# As provided from the R exSTRa package (https://github.com/bahlolab/exSTRa)
# Check that the reference matches your BAM files
repeat_database=path/to/repeat_expansion_disorders.txt

# Reference FASTA file, the same as BAM files
reference=path/to/hg19.fa

### Running ###
# Create output
mkdir -p $(dirname $output)

# Set the correct path for the exSTRa_score.pl script
perl bin/exSTRa_score.pl \
    "$reference" \
    "$repeat_database" \
    $bam_glob \
    > "$output"

