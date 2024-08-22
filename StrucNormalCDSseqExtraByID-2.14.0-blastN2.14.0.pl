#!/usr/bin/perl
#useage: perl StrucNormalCDSseqExtraByID-2.14.0-blastN2.14.0.pl genomeName genomeAnnotationCDSfastafile 

system "perl StrucNormalCDSseqExtraByID-2.14.0.pl $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap-proStrucNormal.txt $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap.fasta";

system "perl noGap-proStrucNormalCDS-blastN2.14.0.pl $ARGV[0] $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap-proStrucNormalCDS.fasta $ARGV[1]";
