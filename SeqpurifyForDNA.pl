#!/usr/bin/perl
#usage: perl SeqpurifyForDNA.pl DNAfasfile(contain more fasta sequnece) 
#

my ($sec,$min,$hour)=localtime(time);
print "start time: $hour-$min-$sec\n";

open (IN,"<$ARGV[0]") || die ("\nError: Couldn't open name file !\n\n");
$filename = $ARGV[0];
$filename =~ s/\.fasta//;
open (Out,">$filename-purify.fasta")||die;

undef $/;
$/= ">";
while (<IN>){
	next unless (my ($id,$seq) = /(.*?)\n(.*)/s); 
		$seq =~ s/[\d\s>]//g;
		$seq =~ s/[^ATCGNatcgn]//g;
		print Out ">$id\n$seq\n";
}
$/= "\n";
close (Out);
close (IN);

		my ($sec1,$min1,$hour1)=localtime(time);
print "end time: $hour1-$min1-$sec1\n";





