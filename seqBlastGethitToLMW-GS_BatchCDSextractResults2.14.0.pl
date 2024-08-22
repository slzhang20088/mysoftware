#!/usr/bin/perl
#useage: perl seqBlastGethitToLMW-GS_BatchCDSextractResults2.14.0.pl  databasefasfile  queryfasfile1(begin)        queryfasfile2(end)           genomeName
#                                                                                       LMW-GS_begin_new90bp.fasta  LMW-GS_end_new90bp.fasta     TaCS_ABD

my ($sec,$min,$hour)=localtime(time);
print "start time: $hour-$min-$sec\n";
$file0 = $ARGV[0];
$file0 =~ s/\.fas//;
$file1 = $ARGV[1];    #queryfasfile1(begin)
$file1 =~ s/\.fasta//;
$file2 = $ARGV[2];    #queryfasfile2(end)
$file2 =~ s/\.fasta//;

#system "time blastn -query                      -db                              -out              -num_alignments 1 -num_threads 6 -subject_besthit  -outfmt 6 -evalue 1e-10
                    #LMW-GS_begin_new90bp.fasta  MG560140-CSA-LMW-GSregion.fas.db  LMW-GS_begin_new90bp--MG560140-CSA-LMW-GSregion.fas.db.tbl ";

system "time blastn -query $ARGV[1] -db $ARGV[0].db -out $file1--$ARGV[0].db.tbl -num_alignments 1  -num_threads 8   -outfmt 6 -evalue 1e-10";
system "time blastn -query $ARGV[2] -db $ARGV[0].db -out $file2--$ARGV[0].db.tbl -num_alignments 1  -num_threads 8   -outfmt 6 -evalue 1e-10";
#                                                                                                -subject_besthit
#                                                                                                -subject_besthit

system "perl findSubjectPositionScoreMax2.14.0.pl $file1--$ARGV[0].db.tbl";
system "perl findSubjectPositionScoreMax2.14.0.pl $file2--$ARGV[0].db.tbl";


#LMW-GS_begin_new90bp--MG560140-CSA-LMW-GSregion.fas.db.tbl-findSubjectPositionScoreMax2.14.0.txt
#LMW-GS_end_new90bp--MG560140-CSA-LMW-GSregion.fas.db.tbl-findSubjectPositionScoreMax2.14.0.txt

system "perl findSubjectPositionScoreMax2.14.0-delRbyIdent.pl $file1--$ARGV[0].db.tbl-findSubjectPositionScoreMax2.14.0.txt";
system "perl findSubjectPositionScoreMax2.14.0-delRbyIdent.pl $file2--$ARGV[0].db.tbl-findSubjectPositionScoreMax2.14.0.txt";

system "perl delRepeat2.14.0.pl $file1--$ARGV[0].db.tbl-findSubjectPositionScoreMax2.14.0-delRbyIdent.txt";
system "perl delRepeat2.14.0.pl $file2--$ARGV[0].db.tbl-findSubjectPositionScoreMax2.14.0-delRbyIdent.txt";

system "perl seqExtraByIDinBeginEndFilenew-twoNo2-2.14.0.pl $file1--$ARGV[0].db.tbl-findSubjectPositionScoreMax2.14.0-delRbyIdent-2.txt $file2--$ARGV[0].db.tbl-findSubjectPositionScoreMax2.14.0-delRbyIdent-2.txt $ARGV[0] $ARGV[3]";

my ($sec1,$min1,$hour1)=localtime(time);
print "end time: $hour1-$min1-$sec1\n";
