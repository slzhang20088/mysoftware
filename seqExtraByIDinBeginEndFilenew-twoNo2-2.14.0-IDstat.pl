#!/usr/bin/perl
#useage: perl seqExtraByIDinBeginEndFilenew-twoNo2-2.14.0-IDstat.pl begin*Max2.14.0.txt end*Max2.14.0.txt databasefasfile(subject) genomeName

my ($sec,$min,$hour)=localtime(time);
print "start time: $hour-$min-$sec\n";

open (In, $ARGV[0]) || die "cannot open the $ARGV[0]\n";
$i = 0;
while (<In>){ 
#query acc.ver	subject acc.ver	% identity	alignment length	mismatches	gap opens	q. start	q. end	s. start	s. end	evalue	bit score
#LMW-GS_A4.begin	MG560140-CSA-LMW-GSregion	100.000	90	0	0	1	90	4711776	4711865	1.60e-42	167
#LMW-GS_A3.begin	MG560140-CSA-LMW-GSregion	100.000	90	0	0	1	90	4620704	4620793	1.60e-42	167
#LMW-GS_A1.begin	MG560140-CSA-LMW-GSregion	100.000	90	0	0	1	90	2076117	2076028	1.60e-42	167
#LMW-GS_A2.begin	MG560140-CSA-LMW-GSregion	100.000	90	0	0	1	90	2181941	2181852	1.60e-42	167
#      0                       1                     2   3  4   5   6    7    8       9       10        11  


	chomp($_);
	@temp = split (/\t/,$_);
	$leftsubjid[$i] = $temp[1];
	$leftbegin[$i] = $temp[8];
	$leftend[$i] = $temp[9];
	$_ = $temp[0];
	$typebegin[$i] = $1 if /LMW-GS_(\w+)\.begin/;

	$i++;
}
$ino = $i;
print "ino is $ino\n";
close (In);


open (In, $ARGV[1]) || die "cannot open the $ARGV[1]\n";
$i = 0;
while (<In>){ 
#query acc.ver	subject acc.ver	% identity	alignment length	mismatches	gap opens	q. start	q. end	s. start	s. end	evalue	bit score
#LMW-GS_A4.end	MG560140-CSA-LMW-GSregion	100.000	90	0	0	1	90	4712572	4712661	1.60e-42	167
#LMW-GS_A1.end	MG560140-CSA-LMW-GSregion	100.000	90	0	0	1	90	2075208	2075119	1.60e-42	167
#LMW-GS_A2.end	MG560140-CSA-LMW-GSregion	100.000	90	0	0	1	90	2180900	2180811	1.60e-42	167
#LMW-GS_A3A5.end	MG560140-CSA-LMW-GSregion	100.000	90	0	0	1	90	4621529	4621618	1.60e-42	167
#      0                       1                     2   3  4   5   6    7    8       9       10        11 


	chomp($_);
	@ttemp = split (/\t/,$_);
	$rightsubjid[$i] = $ttemp[1];
	$rightbegin[$i] = $ttemp[8];
	$rightend[$i] = $ttemp[9];
	$_ = $ttemp[0];
	$typeend[$i] = $1 if /LMW-GS_(\w+)\.end/;

	$i++;
}
$inno = $i;
print "ino is $inno\n";
close (In);

$file = $ARGV[2];
$file =~ s/\.fas//;
open (INN,$ARGV[2])|| die ("\nError: Couldn't open database $ARGV[2] !\n\n");
open (Out,">$file-LMW-GS_BatchCDSextractResultsfromChr.2.14.0.IDstat.txt")||die;
open (Oout,">>$ARGV[3]-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0.IDstat2.txt")||die;
undef $/; 
$/= ">";  
$j=0;
while (<INN>){
	next unless (($iid,$sseq) = /(.*?)\n(.*)/s); 
	for ($i=0;$i<$ino;$i++) {
		for ($k=0;$k<$inno;$k++) {
			if ($leftbegin[$i] < $leftend[$i]) {
				if ($rightbegin[$k] < $rightend[$k]) {
					if (($leftsubjid[$i] eq $rightsubjid[$k]) and (($rightend[$k] - $leftbegin[$i])< 2000)and (($rightend[$k] - $leftbegin[$i])> 0)) {
						$m = $i+1;
						$lengthnormal = $rightend[$k] - $leftbegin[$i] + 1;
						$leftbeginok = $leftbegin[$i];#- 1
						print Out "$ARGV[3]\t$leftsubjid[$i]\t$typebegin[$i]\t$typeend[$k]\tnormal\t$leftbeginok\t$rightend[$k]\t$lengthnormal\n";#\tCDS\t$len_in2
						print Oout "$typebegin[$i]-$typeend[$k]\t";
					}
				}
			}
			if ($leftbegin[$i] > $leftend[$i]) {
				if ($rightbegin[$k] > $rightend[$k]) {
					if (($leftsubjid[$i] eq $rightsubjid[$k]) and (($leftbegin[$i] - $rightend[$k])< 2000)and (($leftbegin[$i] - $rightend[$k])> 0)) {
						$m = $i+1;
						$lengthRC = $leftbegin[$i] - $rightend[$k] + 1;
						$rightendok = $rightend[$k];#- 1
						$seqrc = $substr;
						$seqrc =~ tr/TGCAtgca/ACGTacgt/;
						$rvseq = reverse ($seqrc);
						print Out "$ARGV[3]\t$leftsubjid[$i]\t$typebegin[$i]\t$typeend[$k]\tRC\t$rightendok\t$leftbegin[$i]\t$lengthRC\n";#\tCDS\t$len_in
						print Oout "$typebegin[$i]-$typeend[$k]\t";
					}
				}
			}
		}
	}
$j++;
}
$/= "\n";
close (INN);
close (Out);
close (Oout);

my ($sec1,$min1,$hour1)=localtime(time);
print "end time: $hour1-$min1-$sec1\n";
