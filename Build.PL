use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Bio::STR::exSTRa',
    license             => 'perl',
    dist_abstract       => 'Prepare expanded repeat data from BAM files for the exSTRa R package',
    dist_author         => 'Rick Tankard <tankard.r@wehi.edu.au>',
    build_requires => {
        'Test::More' => '0.10',
    },
    requires => {
           'Bio::DB::HTS' => 0,
           'MooseX' => 0,
           'MooseX::FollowPBP' => 0,
           'Text::Iconv' => 0,
           'Carp' => 0,
           'Data::Dumper' => 0,
           'Exporter' => 0, 
           'Getopt::Long' => 0,
           'List::Util' => 0,
           'Module::Build' => 0,
           'Moose::Util::TypeConstraints' => 0,
           'Moose' => 0,
           'Spreadsheet::ParseExcel' => 0,
           'Spreadsheet::XLSX' => 0,
           'Test::More' => 0,
           'Tie::IxHash' => 0,
           'autodie' => 0, 
           'namespace::autoclean' => 0,
           'perl' => '5.14.1'
          },
);

$builder->create_build_script();

