#!/usr/bin/perl
#usage: perl seqBlastGethitToLMW-GS_BatchCDSextractResults-all2.14.0-IDstat.pl genomeName

system "perl seqB_shIDstatChmodxdos2unix.pl";

while (defined($filename = glob ("*.fas"))) {
	system "perl seqBlastGethitToLMW-GS_BatchCDSextractResults2.14.0-IDstat.pl $filename LMW-GS_begin_new90bp.fasta LMW-GS_end_new90bp.fasta $ARGV[0]";

}

system "cat *LMW-GS_BatchCDSextractResultsfromChr.2.14.0.IDstat.txt > $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0.IDstat.txt";

system "sed -i 's/^/$ARGV[0]\t&/g'  $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0.IDstat2.txt";

system "./seqB_deltabAddenter.sh $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0.IDstat2.txt";

system "perl seqIDstatLMWtypeList.pl $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0.IDstat.txt";

system "cat $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap-proStrucNormal.txt $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap-proStrucPseudo-Statistics.txt  $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--getN-Stat.txt > $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0allStruc.txt";

system "perl seqIDstatLMWtypeList2.pl $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0allStruc.txt";

system "perl seqIDstatLMWtypeList2-findRe-CSxy54-27CDS-Pro.pl $ARGV[0]";

system "cat *-all-LMW-GS--noGap--FinPS-LMW-GS-inCSxy54-27CDS-out.db.tbl-LMWtypelistCSxy54-27CDS.txt *-all-LMW-GS--noGap-pro--FinPS-LMW-GS-inCSxy54-27pro-out.db.tbl-LMWtypelistCSxy54-27Pro.txt > $ARGV[0]-all-LMW-GS--noGap--FinPS-LMW-GS-inCSxy54-27CDSpro-out.db.tbl-LMWtypelistCSxy54-27CDSpro.txt";
