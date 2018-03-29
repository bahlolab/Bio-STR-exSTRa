[![Build Status](https://travis-ci.org/bahlolab/Bio-STR-exSTRa.svg?branch=master)](https://travis-ci.org/bahlolab/Bio-STR-exSTRa)

# Bio::STR::exSTRa

Perl module and script for summarising repeat motifs from BAM files, ready for statistical analysis.
For details of the purpose of this software please see https://github.com/bahlolab/exSTRa

# Install requirements

**Perl 5.14.1**

Required CPAN modules can be obtained by instructions from the `perl Build.PL` command. 

The CPAN module Bio::DB::HTS requires [htslib](https://github.com/samtools/htslib), that may be easier to install separately, or to install [Bio::DB::HTS from Github](https://github.com/Ensembl/Bio-DB-HTS) with one of the options in the `scripts/build_options.sh` script. 

# Setup 

Install as a module:

    perl Build.PL
    ./Build
    ./Build test
    ./Build install

If you do not have write access to the Perl module directory, you may need to use the local::lib module. 
In some circumstances these commands may still not work, and you may need to seek help on Perl's Module::Build. 

# Preparation of BAM files

An outline of our analysis pipeline can be viewed at [prepare_BAMs.md](prepare_BAMs.md). 
We have not yet extensively tested against different aligner settings, but we speculate that the alignments should be performed in local mode. 

# Script to process BAM/CRAM files

The repeat expansion loci are specified in a tab delimited file. 
This is available in the R [exSTRa package](https://github.com/bahlolab/exSTRa) under `inst/extdata/repeat_expansion_disorders.txt`.
Either use the file where the R package is installed, or download directly from https://raw.githubusercontent.com/bahlolab/exSTRa/master/inst/extdata/repeat_expansion_disorders.txt.

See [`examples/run_strexpansion_score.sh`](examples/run_strexpansion_score.sh) for an example of running the script [`bin/exSTRa_score.pl`]() that can be modified to your data.
