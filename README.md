[![Build Status](https://travis-ci.com/trickytank/Bio-STR-exSTRa.svg?token=pyf8VedruqnDDaNAxxhX&branch=master)](https://travis-ci.com/trickytank/Bio-STR-exSTRa)

# Bio::STR::exSTRa

Perl module and script for summarising repeat motifs from BAM files.

# Install requirements

**Perl 5.14.1**

[htslib](https://github.com/samtools/htslib)

Required CPAN modules can be obtained by instructions from the `perl Build.PL` command. 

The CPAN module Bio::DB::HTS requires 

# Setup 

Install as a module
    perl Build.PL
    ./Build
    ./Build test
    ./Build install

To set up, when the working directory is this directory can be achieved with:

    export PERL5LIB="$PWD/exSTRa/perl/lib/:$PERL5LIB"


# Script to process BAM/CRAM files

At present the script and module requires an XLSX file configuration for repeat disorders. We are changing this to use of a tab delimited file. (TODO: add this file to this repository)

The script `bin/exSTRa_score.pl` can assist with this. See `examples/run_strexpansion_score.sh` for an example. 

