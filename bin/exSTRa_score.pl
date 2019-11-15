#!/usr/bin/env perl

=head1 
Extracting important information from aligned reads with respect 
to the STR expansion disease loci. Counts the number of repeated bases 
in reads found. 

Usage: 
perl exSTRa_score.pl $bahlolab_db/hg19/standard_gatk/hg19.fa ../../../disorders/repeat_disorders.txt sample.bam [sample2.bam] [...]

Testing:
perl exSTRa_score.pl --debug $bahlolab_db/hg19/standard_gatk/hg19.fa ../../../disorders/repeat_disorders.txt ../simulations/*1/pipeline/initial_*_pipeline/bam_recal/*_bowtie2_recal.bam

Actual Usage: 
perl exSTRa_score.pl $bahlolab_db/hg19/standard_gatk/hg19.fa ../disorders/repeat_disorders.txt bam_links/*.bam > repeat_rediscovery_02_readdetect.txt

perl exSTRa_score.pl --by_alignment $bahlolab_db/hg19/standard_gatk/hg19.fa ../disorders/repeat_disorders.txt bam_links/*.bam > repeat_rediscovery_02_byalignment.txt

=cut

use 5.014;
use strict 'vars';
use warnings; 
use Bio::STR::exSTRa 1.0.1; 
use Bio::DB::HTS;
use autodie; 
use Getopt::Long;
use Tie::IxHash;
use Data::Dumper; 

$Data::Dumper::Sortkeys = 1; # Dumper outputs are sorted

# Read options
my $expanded = '';
my $outer_bases = 2000;
my $debug = '';
my $assess_by_alignment = '';
my $trim = 0;
GetOptions (
    "outer_bases=i" => \$outer_bases, 
    "debug" => \$debug,
    'by_alignment' => \$assess_by_alignment,
    'trim=i' => \$trim,,
) or die("Error in command line arguments\n");
my $reference = shift @ARGV;
my $repeat_database = shift @ARGV;
my @bam_files = @ARGV;
# my $bam_file = shift @ARGV;

# identify locations from Excel file
my $strs = exSTRa::DB->new;
$strs->fasta($reference);
my $input_type = '';
if($repeat_database =~ /\.xlsx$/) {
    warn "Excel file $repeat_database\n";
    $strs->read_str_database_excel($repeat_database, 
       (    chrom   => 'hg19 chrom', 
            start0  => 'hg19 start 0',
            end     => 'hg19 end', 
            repeat_unit => 'Repeat sequence',
            per_match => 'perMatch',
            per_indel => 'perIndel',
            name    => 'Disease',
            gene    => 'Gene',
            region  => 'Location of repeat within gene',
            strand  => 'strand',
            read_detect_size => 'read_detect_size',
            stable_repeats => 'Stable repeat number',
            unstable_repeats => 'Unstable repeat number',
       ) );
    $input_type = 'named';
} else {
    # Determine if named or UCSC style file
    my $is_named_loci = 0;
    open my $rd, '<', $repeat_database or die $!;
    my $head;
    while($head = <$rd>) {
        chomp $head;
        if($head =~ /^### exSTRa /) {
            $is_named_loci = 1;
        }
        # Find the first non-comment line (#bin could be from UCSC files)
        unless ($head =~ /^#/ && $head !~ /^#bin/) {
            last;
        }
    }
    close $rd;
    my @heads = split /\t/, $head;

    if($is_named_loci) {
        warn "Tab delimited file of named loci $repeat_database\n";
        # Find start and end header names.
        # There should only be one of each.
        my @start_names = grep { /start$/ } @head;
        my @end_names = grep { /end$/ } @head;
        if(@start_names != 1 && @end_names != 1) {
            die "There was not exactly one '*start' column and '*end' column.\n" .
            "Note that any column name that ends with 'start' or 'end' respectively will match.\n" .
            "start columns: " . join(", ", @start_names) .
            "end columns: " . join(", ", @end_names) .
            "\n";
        }

        $strs->read_str_database_tsv($repeat_database, 
           (    chrom   => 'chrom', 
                start  => $start_names[0],
                end     => $end_names[0],
                repeat_unit => 'motif',
                per_match => 'perMatch',
                per_indel => 'perIndel',
                name    => 'locus',
                gene    => 'gene',
                region  => 'location',
                strand  => 'strand',
                # read_detect_size => 'read_detect_size',
                #stable_repeats => 'Stable repeat number',
                #unstable_repeats => 'Unstable repeat number',
           )
        );
        $input_type = 'named';
    } else {
        # UCSC Simple Repeat style
        warn "Importing repeats assuming UCSC Simple Repeat style, from file $repeat_database.\n";
        if($head =~ /^#bin\tchrom/) {
            $strs->read_str_database_UCSC_TRF($repeat_database);
        } else {
            $strs->read_str_database_UCSC_TRF($repeat_database, 0, 1);
        }
        $strs->keep_repeat_unit_sizes();
        $input_type = 'ucsc';
    }
}

# Read BAMs
$strs->fasta($reference); # set Fasta reference
$strs->read_bams_array(\@bam_files); # , (-expand_flags  => 1)); # may need to remove the expand flags to avoid error
# Scan whole SAM file for the counts of each read origin

# Bio::DB:Sam flags are: 
#  0  HASH(0x4a0ab80)
#     1 => 'PAIRED'
#     1024 => 'DUPLICATE'
#     128 => 'SECOND_MATE'
#     16 => 'REVERSED'
#     2 => 'MAP_PAIR'
#     256 => 'NOT_PRIMARY'
#     32 => 'M_REVERSED'
#     4 => 'UNMAPPED'
#     512 => 'QC_FAILED'
#     64 => 'FIRST_MATE'
#     8 => 'M_UNMAPPED'


# Understand those BAMs
if($assess_by_alignment) {
    $strs->assess_str_reads_by_alignment;
} else {
    $strs->assess_str_reads(read_trim_static => $trim, give_score => 1, print_only => 1);
}
# $strs->all_counts_give;

# Print it all out
say Dumper($strs->counts) if $debug;

warn "We are all done. Yay\n";

# $strs->rep_in_read_print(read_name => 1);

# Subs #

sub give_seq_counts {
    # Gives a hash with counts of the features that give true values as 
    # arguments to a subroutine. 
    # Usage: 
    # give_seq_counts SAM, sub


}
