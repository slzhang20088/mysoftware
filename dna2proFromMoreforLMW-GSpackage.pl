#!/usr/bin/perl
#usage£ºperl dna2proFromMoreforLMW-GSpackage.pl fasfile genomeName

$file = $ARGV[0];
$file =~ s/\.fasta//;

open (INN,$ARGV[0])|| die ("\nError: Couldn't open $ARGV[0] file !\n\n");
undef $/;
$/= ">";
while (<INN>){
	next unless (($iid,$sseq) = /(.*?)\n(.*)/s);
	$sseq =~ s/[\d\s\n>]//g;
	$iid =~ s/\s+/./g;
	system "perl dna2pro.pl $sseq $iid $file ";#$ARGV[1]
}
$/= "\n";

system "perl dna2proStrucPseudoStat.pl $ARGV[1]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--noGap-proStrucPseudo.txt";

close (INN);


