#!/usr/bin/perl
#useage: perl StrucNormalCDSseqExtraByID-2.14.0.pl *-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap-proStrucNormal.txt *-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap.fasta

my ($sec,$min,$hour)=localtime(time);
print "start time: $hour-$min-$sec\n";

open (In, $ARGV[0]) || die "cannot open the $ARGV[0]\n";
$i = 0;
while (<In>){ 
#julius.1B.LMW-GS_B4.begin.LMW-GS_B4.end.RC.6669378-6670431--1053.CDS_1053bp	351	Normal
#julius.1B.LMW-GS_B1B3B6.begin.LMW-GS_B3.end.RC.5286162-5287194--1032.CDS_1032bp	344	Normal
#julius.1D.LMW-GS_D8.begin.LMW-GS_D5D8.end.RC.6740693-6741791--1098.CDS_1098bp	366	Normal
#julius.1D.LMW-GS_D7.begin.LMW-GS_D7.end.normal.4971798-4972710--912.CDS_912bp	304	Normal
#julius.1D.LMW-GS_D2D9.begin.LMW-GS_D9.end.RC.2547055-2547970--915.CDS_915bp	305	Normal
#julius.1D.LMW-GS_D3.begin.LMW-GS_D3.end.RC.3155764-3156661--897.CDS_897bp	299	Normal
#julius.1D.LMW-GS_D6.begin.LMW-GS_D6.end.normal.4756359-4757412--1053.CDS_1053bp	351	Normal
#      0                                                                             2   3

	chomp($_);
	@temp = split (/\t/,$_);
	$seqid[$i] = $temp[0];
	$i++;
}
$ino = $i;
print "StrucNormalCDSseq is $ino\n";
close (In);



$file = $ARGV[1];
$file =~ s/\.fasta//;
open (INN,$ARGV[1])|| die ("\nError: Couldn't open $ARGV[1]!\n\n");
open (Out,">$file-proStrucNormalCDS.fasta")||die;
undef $/;
$/= ">";
while (<INN>){
	next unless (($iid,$sseq) = /(.*?)\n(.*)/s); 
	$sseq =~ s/[\d\s\n>]//g;
	for ($i=0;$i<$ino;$i++) {
		if ($iid eq $seqid[$i]) {
			print Out ">$iid\n$sseq\n";
		}
	}
}
$/= "\n";
close (INN);
close (Out);

my ($sec1,$min1,$hour1)=localtime(time);
print "end time: $hour1-$min1-$sec1\n";
