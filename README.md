[![Build Status](https://travis-ci.org/bahlolab/Bio-STR-exSTRa.svg?branch=master)](https://travis-ci.org/bahlolab/Bio-STR-exSTRa)

# Bio::STR::exSTRa

Perl module and script for summarising repeat motifs from BAM files, ready for statistical analysis.
For details of the purpose of this software please see https://github.com/bahlolab/exSTRa

# Install requirements

**Perl 5.14.1**

Required CPAN modules can be obtained by instructions from the `perl Build.PL` command. 

The CPAN module Bio::DB::HTS requires [htslib](https://github.com/samtools/htslib), that may be easier to install separately, or to install [Bio::DB::HTS from Github](https://github.com/Ensembl/Bio-DB-HTS) with one of the options in the `scripts/build_options.sh` script. 

# Setup 

## Docker container

A Docker container is available for the most common use of this package. 
This can make the installation process easier. 

Instructions for the Docker container are at
https://hub.docker.com/r/ricktankard/bio-str-exstra

## Perl library install

Install as a module:

    # Install Bio::Perl if not installed already (assumes CPAN Minus is available)
    cpanm 'Bio::Perl'

    perl Build.PL
    ./Build installdeps # This is as suggested by the previous command - the command for you to run may vary.
    ./Build
    ./Build test
    ./Build install

If you do not have write access to the Perl module directory, you may need to use the local::lib module. 
In some circumstances these commands may still not work, and you may need to seek help on Perl's Module::Build. 

If Bio::DB::HTS has trouble installing, first check that [htslib](https://github.com/samtools/htslib) is fully installed. 
I have also had success installing it (after installing Bio::Perl) with this command:

    bash <(curl https://raw.githubusercontent.com/Ensembl/Bio-DB-HTS/master/scripts/build_options.sh) "git clone --branch master --depth=1 https://github.com/Ensembl/Bio-DB-HTS.git" "BUILD_LOCAL_INSTALLED_HTSLIB"

# Preparation of BAM files

An outline of our analysis pipeline can be viewed at [prepare_BAMs.md](prepare_BAMs.md). 
We have not yet extensively tested against different aligner settings, but we speculate that the alignments should be performed in local mode. 

# Script to process BAM/CRAM files

The repeat expansion loci are specified in a tab delimited file. 
This is available in the R [exSTRa package](https://github.com/bahlolab/exSTRa) under `inst/extdata/repeat_expansion_disorders.txt`.
Either use the file where the R package is installed, or download directly: [repeat_expansion_disorders.txt](https://raw.githubusercontent.com/bahlolab/exSTRa/master/inst/extdata/repeat_expansion_disorders.txt).

See [`examples/run_strexpansion_score.sh`](examples/run_strexpansion_score.sh) for an example of running the script [`bin/exSTRa_score.pl`](bin/exSTRa_score.pl) that can be modified to your data. 
The Docker container has `exSTRa_score.pl` as an executable command. 
