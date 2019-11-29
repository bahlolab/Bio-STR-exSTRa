# Running exSTRa

### Configuration

# Set bam_glob to a glob pattern that includes all bam files you wish to analyse.
# (multiple runs may be combined in R exSTRa later)
# You may separate globs by spaces or give full paths within the quotes.
# (For more complex cases, set in the perl command directly)
bam_glob="path/to/bams/*.bam"

# Output tab delimited file path:
output=output/exSTRa_scores.txt

# As provided from the R exSTRa package (https://github.com/bahlolab/exSTRa).
# Check that the reference matches your BAM files.
repeat_database=path/to/repeat_expansion_disorders_hg19.txt

# Reference FASTA file, the same reference as the BAM files and repeat_database:
reference=path/to/hg19.fa

### Running ###
mkdir -p $(dirname $output)

# If exSTRa_score.pl script is not available in your PATH, you may instead use: perl path/to/exSTRa_score.pl
exSTRa_score.pl \
    "$reference" \
    "$repeat_database" \
    $bam_glob \
    > "$output"
