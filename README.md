[![Build Status](https://travis-ci.com/trickytank/Bio-STR-exSTRa.svg?token=pyf8VedruqnDDaNAxxhX&branch=master)](https://travis-ci.com/trickytank/Bio-STR-exSTRa)

# Bio::STR::exSTRa

Perl module and script for summarising repeat motifs from BAM files, ready for statistical analysis.
For details of the purpose of this software please see https://github.com/bahlolab/exSTRa

# Install requirements

**Perl 5.14.1**

Required CPAN modules can be obtained by instructions from the `perl Build.PL` command. 

The CPAN module Bio::DB::HTS requires [htslib](https://github.com/samtools/htslib), that may be easier to install separately, or to install [Bio::DB::HTS from Github](https://github.com/Ensembl/Bio-DB-HTS) with one of the options in the `scripts/build_options.sh` script. 

# Setup 

Install as a module

    perl Build.PL
    ./Build
    ./Build test
    ./Build install

# Preparation of BAM files

An outline of our analysis pipeline can be viewed at [prepare_BAMs.md](prepare_BAMs.md). 
We have not yet extensively tested against different aligner settings, but we speculate that the alignments should be performed in local mode. 

# Script to process BAM/CRAM files

At present the script and module requires an XLSX file configuration for repeat disorders. We are changing this to use of a tab delimited file. (TODO: add this file to this repository)

The script `bin/exSTRa_score.pl` can assist with this. See `examples/run_strexpansion_score.sh` for an example. 

