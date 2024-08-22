#!/usr/bin/perl
#usage: perl seqBlastGethitToLMW-GS_BatchCDSextractResults-all2.14.0.pl genomeName


while (defined($filename = glob ("*.fas"))) {
	system "perl seqBlastGethitToLMW-GS_BatchCDSextractResults2.14.0.pl $filename LMW-GS_begin_new90bp.fasta LMW-GS_end_new90bp.fasta $ARGV[0]";

}
