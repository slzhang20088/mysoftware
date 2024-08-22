#!/usr/bin/perl
#useage: perl seqIDstatLMWtypeList2-findRe-CSxy54-27CDS-Pro.pl genomeName(for example, stanley)

my ($sec,$min,$hour)=localtime(time);
print "\nstart time: $hour-$min-$sec\n\n";

system "perl seqIDstatLMWtypeList2-findRe.pl $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0allStruc.txt";

system "perl seqIDstatLMWtypeList2-CSxy54-27CDS.pl $ARGV[0]-all-LMW-GS--noGap--FinPS-LMW-GS-inCSxy54-27CDS-out.db.tbl";

system "perl seqIDstatLMWtypeList2-CSxy54-27Pro.pl $ARGV[0]-all-LMW-GS--noGap-pro--FinPS-LMW-GS-inCSxy54-27pro-out.db.tbl";

my ($sec,$min,$hour)=localtime(time);
print "end time: $hour-$min-$sec\n\n";

