#!/usr/bin/env perl 

# svn $Revision: 935 $
# svn $LastChangedDate: 2015-04-08 12:24:36 +1000 (Wed, 08 Apr 2015) $

=head1 Testing Bio::STR::exSTRa::Score
=cut

use 5.014;
use warnings;
use autodie;
use Data::Dumper;
use Test::More tests => 21;
use Test::Exception;
use File::ShareDir qw(dist_file);
use Bio::STR::exSTRa::Score; 


my %headcols;
my ($tests_passed, $n_tests) = (0, 0);
my $test_qualloc = '';
my $qualloc;

open my $fg, '<', 'share/repeats_reference.txt';

while (<$fg>) {
    chomp;
    if(/^#END#/) {
        last; # don't bother with any more columns
    }
    s/"//g; # assuming we aren't really using these quotes
    my @line = split /\t/;
    if($. == 1) {
        @headcols{@line} = (0..$#line);
        warn "\%headcols:\n", Dumper(\%headcols);
        if(!defined($headcols{repeat_unit}) || !defined($headcols{score}) || !defined($headcols{sequence})) {
            die "There does not appear to be all of the columns 'repeat_unit', 'score', 'sequence', in the input.\n";
        }
        next;
    }

    my ($rep_unit, $score_expected, $seq) = @line[@headcols{qw(repeat_unit score sequence)}];

    my $strscore = Bio::STR::exSTRa::Score->new (repeat_unit => $rep_unit, sequence => $seq);
    # say $line[$headcols{Disease}];
    # say $strscore->{sequence};
    # say $strscore->repeated_bases . " / " . $strscore->matchable_bases;
    # say "Score: " . $strscore->repeated_proportion;

    my $score_calc = $strscore->repeated_bases;

    my $locus_note = "Expected";
    if(defined($headcols{Disease})) {
        $locus_note = "At locus $headcols{Disease}, $locus_note";
    }

    is($score_calc, $score_expected, "$locus_note score $score_expected should equal $score_calc (calculated score).\nSeq: $seq\n");
}

