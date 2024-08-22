#!/usr/bin/perl
#usage: perl seqblastTo27CSxy54.pl  genomeName


$fileCDS = "FinPS-LMW-GS-inCSxy54-27CDS.fasta";
$fileCDS =~ s/\.fasta//;

$filePro = "FinPS-LMW-GS-inCSxy54-27pro.fasta";
$filePro =~ s/\.fasta//;



system "time blastn -query $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0.fasta -db $fileCDS.fasta.db -out $ARGV[0]-all-LMW-GS--$fileCDS-out.db.tbl -num_alignments 1 -subject_besthit -num_threads 8   -outfmt 6 -evalue 1e-10";

system "time blastn -query $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap.fasta -db $fileCDS.fasta.db -out $ARGV[0]-all-LMW-GS--noGap--$fileCDS-out.db.tbl -num_alignments 1 -subject_besthit -num_threads 8   -outfmt 6 -evalue 1e-10";

system "time blastn -query $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap-proStrucNormalCDS.fasta -db $fileCDS.fasta.db -out $ARGV[0]-all-LMW-GS--noGap-proStrucNormalCDS--$fileCDS-out.db.tbl -num_alignments 1 -subject_besthit -num_threads 8   -outfmt 6 -evalue 1e-10";

system "time blastp -query $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap-pro.fasta -db $filePro.fasta.db -out $ARGV[0]-all-LMW-GS--noGap-pro--$filePro-out.db.tbl -num_alignments 1 -subject_besthit -num_threads 8   -outfmt 6 -evalue 1e-10";

system "time blastp -query $ARGV[0]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap-proStrucNormal.fasta -db $filePro.fasta.db -out $ARGV[0]-all-LMW-GS--noGap-proStrucNormal--$filePro-out.db.tbl -num_alignments 1 -subject_besthit -num_threads 8   -outfmt 6 -evalue 1e-10";

