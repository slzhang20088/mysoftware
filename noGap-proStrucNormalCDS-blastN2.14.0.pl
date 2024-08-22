#!/usr/bin/perl
#useage: perl noGap-proStrucNormalCDS-blastN2.14.0.pl genomeName *-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap-proStrucNormalCDS.fasta genomeAnnotationCDSfastafile 

system "time blastn -query $ARGV[1] -db $ARGV[2].db -out $ARGV[0]-all-LMW-GS--noGap-proStrucNormalCDS--$ARGV[2]-out.db.tbl -num_alignments 1 -subject_besthit -num_threads 8   -outfmt 6 -evalue 1e-10";

