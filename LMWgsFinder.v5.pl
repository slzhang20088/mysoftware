#!/usr/bin/perl
#usage:perl LMWgsFinder.v5.pl genomeTopLevel.fa(fasfile) genomeName(cannot contain '.') genomeAnnotationCDS.fasta genomeAnnotationPro.fasta

#example:
#perl LMWgsFinder.v5.pl AK58.dna.toplevel.fa  TaAK58  AK58.cds.fasta  AK58.pep.fasta 
#perl LMWgsFinder.v5.pl IWGSC_v1.dna.fa  IWGSCv1  IWGSC_v1.cds.fasta  IWGSC_v1.pep.fasta

#test
#perl LMWgsFinder.v5.pl testDNAtoplevel.fa Tatest testCDS.fasta testPro.fasta
#If there are nearly 20 result files generated in the folder named 'results', 
#it indicates that the package is running correctly. These result files 
#can be used for sequence analysis and experimental validation of LMW-GS genes.

#Genomic sequence files, CDS sequence files, and protein sequence files must all be in Fasta format.
#The extension of the genome sequence file needs to be ".fa", while, the file extension of CDS and Pro needs to be '.fasta'.
#The main result file is located in the folder named 'results', with the file name containing'-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0'.

my $current_time = time;
my $local_time = localtime($current_time);
print "\nStart time: $local_time\n\n";


my ($sec,$min,$hour)=localtime(time);
print "BatchCDSextract_package Total start time: $hour-$min-$sec\n";

$fileCDS = $ARGV[2];
$fileCDS =~ s/\.fasta//;

$filePro = $ARGV[3];
$filePro =~ s/\.fasta//;

system "makeblastdb -in $ARGV[0] -out $ARGV[0].db -dbtype nucl -parse_seqids -hash_index";

system "perl blast-getFas2.14.0.pl $ARGV[0]";

system "perl formatdb2.14.0allFas.pl";

system "perl seqBlastGethitToLMW-GS_BatchCDSextractResults-all2.14.0.pl $ARGV[1]";

system "cat *LMW-GS_BatchCDSextractResultsfromChr.2.14.0.fasta > $ARGV[1]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0.fasta";

system "perl SeqpurifyForDNA.pl $ARGV[2]";

system "dos2unix *-purify.fasta"; 

system "makeblastdb -in $fileCDS-purify.fasta -out $fileCDS-purify.fasta.db -dbtype nucl -parse_seqids -hash_index";

system "time blastn -query $ARGV[1]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0.fasta -db $fileCDS-purify.fasta.db -out $ARGV[1]-all-LMW-GS--$fileCDS-purify-out.db.tbl -num_alignments 1 -subject_besthit -num_threads 8   -outfmt 6 -evalue 1e-10";

system "perl getSeqNfromMoreforLMW-GSpackage.pl $ARGV[1]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0.fasta ";


system "perl getSeqNfromMoreforLMW-GSpackageStat.pl *-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--getN.txt";

system "time blastn -query $ARGV[1]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap.fasta -db $fileCDS-purify.fasta.db -out $ARGV[1]-all-LMW-GS--noGap--$fileCDS-purify-out.db.tbl -num_alignments 1 -subject_besthit -num_threads 8   -outfmt 6 -evalue 1e-10";

system "perl dna2proFromMoreforLMW-GSpackage.pl $ARGV[1]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap.fasta $ARGV[1]";

system "perl SeqpurifyForPro.pl $ARGV[3]";

system "dos2unix *-purify.fasta"; 

system "makeblastdb -in $filePro-purify.fasta -out $filePro-purify.fasta.db -dbtype prot -parse_seqids -hash_index";

system "time blastp -query $ARGV[1]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap-pro.fasta -db $filePro-purify.fasta.db -out $ARGV[1]-all-LMW-GS--noGap-pro--$filePro-purify-out.db.tbl -num_alignments 1 -subject_besthit -num_threads 8   -outfmt 6 -evalue 1e-10";

system "time blastp -query $ARGV[1]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap-proStrucNormal.fasta -db $filePro-purify.fasta.db -out $ARGV[1]-all-LMW-GS--noGap-proStrucNormal--$filePro-purify-out.db.tbl -num_alignments 1 -subject_besthit -num_threads 8   -outfmt 6 -evalue 1e-10";

system "perl StrucNormalCDSseqExtraByID-2.14.0-blastN2.14.0.pl $ARGV[1] $fileCDS-purify.fasta";

system "perl seqblastTo27CSxy54.pl $ARGV[1]";

system "perl seqBlastGethitToLMW-GS_BatchCDSextractResults-all2.14.0-IDstat.pl $ARGV[1]";

system "perl 2.14.0.IDstatTogff3-all.pl";

system "cp *-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0* ./results";


my ($sec1,$min1,$hour1)=localtime(time);
print "BatchCDSextract_package Total end time: $hour1-$min1-$sec1\n";



my $current_time = time;
my $local_time = localtime($current_time);
print "\nEnd time: $local_time\n\n";
