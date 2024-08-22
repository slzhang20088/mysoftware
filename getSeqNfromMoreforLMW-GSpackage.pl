#!/usr/bin/perl
#usage: perl getSeqNfromMoreforLMW-GSpackage.pl fasfile(contain more fasta sequnece) #genomeName
#

my ($sec,$min,$hour)=localtime(time);
print "start time: $hour-$min-$sec\n";

open (IN,"<$ARGV[0]") || die ("\nError: Couldn't open name file !\n\n");
$filename = $ARGV[0];
$aa = $filename;
$aa =~ s/\.fasta//;

undef $/;
$/= ">";
while (<IN>){
	next unless (my ($id,$seq) = /(.*?)\n(.*)/s); 
		$seq =~ s/[\d\s>]//g;
		$lenseq= length $seq;
		if($seq =~ /N{1,}/) {
			while ($seq =~ /N{1,}/gi) {
				$st = $-[0]+1;
				$en = $+[0];
				$len = $en - $st +1;
				open (Out,">>$aa--getN.txt")||die;
					print Out "$id\t$st\t$en\t$len\n";#$ARGV[1]-
				close (Out);
			}
		}else{
				open (Outt,">>$aa--noGap.fasta")||die;
					print Outt ">$id\n$seq\n";#$ARGV[1]-
				close (Outt);

		}
}
$/= "\n";
close (IN);

		my ($sec1,$min1,$hour1)=localtime(time);
print "end time: $hour1-$min1-$sec1\n";




