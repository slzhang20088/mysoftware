#!/usr/bin/perl
#usage:perl blast-getFas2.14.0.pl databasefasfile

my ($sec,$min,$hour)=localtime(time);
print "blast-getFas2.14.0.pl Total start time: $hour-$min-$sec\n";

system "time blastn -query LMW-GS_begin-end_new90bp.fasta -db $ARGV[0].db -out out.db.tbl -num_alignments 1  -num_threads 8   -outfmt 6 -evalue 1e-10";

system "perl fasseqExtrbyTbl2.14.0.pl $ARGV[0]";

my ($sec1,$min1,$hour1)=localtime(time);
print "blast-getFas2.14.0.pl Total end time: $hour1-$min1-$sec1\n";

