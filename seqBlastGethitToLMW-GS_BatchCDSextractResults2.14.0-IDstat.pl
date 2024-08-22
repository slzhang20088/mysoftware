#!/usr/bin/perl
#useage: perl seqBlastGethitToLMW-GS_BatchCDSextractResults2.14.0-IDstat.pl  databasefasfile  queryfasfile1(begin)        queryfasfile2(end)           genomeName
#                                                                                       LMW-GS_begin_new90bp.fasta  LMW-GS_end_new90bp.fasta     TaCS_ABD

my ($sec,$min,$hour)=localtime(time);
print "start time: $hour-$min-$sec\n";
$file0 = $ARGV[0];
$file0 =~ s/\.fas//;
$file1 = $ARGV[1];    #queryfasfile1(begin)
$file1 =~ s/\.fasta//;
$file2 = $ARGV[2];    #queryfasfile2(end)
$file2 =~ s/\.fasta//;


system "perl seqExtraByIDinBeginEndFilenew-twoNo2-2.14.0-IDstat.pl $file1--$ARGV[0].db.tbl-findSubjectPositionScoreMax2.14.0-delRbyIdent-2.txt $file2--$ARGV[0].db.tbl-findSubjectPositionScoreMax2.14.0-delRbyIdent-2.txt $ARGV[0] $ARGV[3]";

my ($sec1,$min1,$hour1)=localtime(time);
print "end time: $hour1-$min1-$sec1\n";
