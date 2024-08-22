#!/usr/bin/perl
#usage: perl delRepeat2.14.0.pl *.db.tbl-findSubjectPositionScoreMax2.14.0-delRbyIdent.txt

open (IN, $ARGV[0]);
$i = 0;
while (<IN>) {
#query acc.ver	subject acc.ver	% identity	alignment length	mismatches	gap opens	q. start	q. end	s. start	s. end	evalue	bit score
#LMW-GS_D6.begin	MG560142-CSD-LMW-GSregion	100.000	90	0	0	1	90	5055400	5055489	1.69e-42	167
#LMW-GS_D3.begin	MG560142-CSD-LMW-GSregion	100.000	90	0	0	1	90	3668116	3668027	1.69e-42	167
#LMW-GS_D4.begin	MG560142-CSD-LMW-GSregion	100.000	90	0	0	1	90	3782276	3782187	1.69e-42	167
#LMW-GS_A2.begin	MG560142-CSD-LMW-GSregion	90.323	62	6	0	1	62	2971241	2971180	6.30e-17	82.4
#LMW-GS_D5.begin	MG560142-CSD-LMW-GSregion	100.000	90	0	0	1	90	4290584	4290673	1.69e-42	167
#LMW-GS_D1.begin	MG560142-CSD-LMW-GSregion	100.000	90	0	0	1	90	2956563	2956474	1.69e-42	167
#LMW-GS_D2D9.begin	MG560142-CSD-LMW-GSregion	100.000	90	0	0	1	90	2971241	2971152	1.69e-42	167
#LMW-GS_D7.begin	MG560142-CSD-LMW-GSregion	100.000	90	0	0	1	90	5271184	5271273	1.69e-42	167
#   0                    1                         2    3   4   5   6   7       8      9       10        11 


	chomp;
	@temp = split (/\t/, $_);
		$subjstart[$i] = $temp[8];
		$line{$subjstart[$i]} = $_;
	$i++; 
}
close IN; 


$name = $ARGV[0];
$name =~ s/\.txt//;
open (OUT, ">$name-2.txt");
print OUT "query acc.ver	subject acc.ver	% identity	alignment length	",
"mismatches	gap opens	q. start	q. end	s. start	s. end	evalue	bit score\n";

$i = 0;
while (($k,$v) = each(%line)) {
	if ($k =~  /^\d+$/) {
		print OUT "$v\n";
	}
	$i++;
}
close OUT;
