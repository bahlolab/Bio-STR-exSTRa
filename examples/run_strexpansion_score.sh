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
repeat_database=path/to/repeat_expansion_disorders.txt

# Reference FASTA file, the same as BAM files:
reference=path/to/hg19.fa

# exSTRa_score.pl path
exstra_score="bin/exSTRa_score.pl"

### Running ###
mkdir -p $(dirname $output)

# Please set the correct path for the exSTRa_score.pl script
perl "$exstra_score" \
    "$reference" \
    "$repeat_database" \
    $bam_glob \
    > "$output"
