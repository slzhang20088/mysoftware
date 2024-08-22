#!/usr/bin/perl
#usage: perl findSubjectPositionScoreMax2.14.0.pl *.db.tbl 

open (IN, $ARGV[0]);
while (<IN>) {
#query acc.ver,     subject acc.ver, % identity, alignment length, mismatches, gap opens, q. start, q. end, s. start, s. end, evalue, bit score
#LMW-GS_A1.begin	MG560140-CSA-LMW-GSregion	100.000	90	0	0	1	90	2076117	2076028	1.60e-42	167
#LMW-GS_A2.begin	MG560140-CSA-LMW-GSregion	100.000	90	0	0	1	90	2181941	2181852	1.60e-42	167
#LMW-GS_A3.begin	MG560140-CSA-LMW-GSregion	100.000	90	0	0	1	90	4620704	4620793	1.60e-42	167
#LMW-GS_A4.begin	MG560140-CSA-LMW-GSregion	100.000	90	0	0	1	90	4711776	4711865	1.60e-42	167
#LMW-GS_A5.begin	MG560140-CSA-LMW-GSregion	96.667	90	3	0	1	90	4620704	4620793	1.61e-37	150
#LMW-GS_A6.begin	MG560140-CSA-LMW-GSregion	96.667	90	3	0	1	90	2181941	2181852	1.61e-37	150
#LMW-GS_A7.begin	MG560140-CSA-LMW-GSregion	98.889	90	1	0	1	90	2181941	2181852	7.45e-41	161
#LMW-GS_D2D9.begin	MG560140-CSA-LMW-GSregion	94.444	90	5	0	1	90	4711776	4711865	3.49e-34	139
#LMW-GS_D3.begin	MG560140-CSA-LMW-GSregion	92.222	90	7	0	1	90	4711776	4711865	7.55e-31	128
#       0                       1                  2    3   4   5   6   7       8      9        10       11 


	chomp;
	@temp = split (/\t/, $_);
	$queryid[$i] = $temp[0];
	$subjectid[$i] = $temp[1];
	$identity[$i] = $temp[2];
	$Align_length[$i] = $temp[3];
	$mismatches[$i] = $temp[4];
	$Gap[$i] = $temp[5];
	$querstart[$i] = $temp[6];
	$querend[$i] = $temp[7];
	$subjstart[$i] = $temp[8];
	$subjend[$i] = $temp[9];
	$E_value[$i] = $temp[10];
	$Score[$i] = $temp[11];
	if ($subjend[$i] > $subjstart[$i]) {
		$line{$subjstart[$i]} = $_;
	}
	if ($subjend[$i] < $subjstart[$i]) {
		$line{$subjend[$i]} = $_;
	}

	$i++; 
}
close IN; 
$n = $i;

$i = 0;
while (($k,$v) = each(%line)) {
	push (@key,$k);
	$i++;
}
$name = $ARGV[0];
$name =~ s/\.txt//;
open (OUT, ">$name-findSubjectPositionScoreMax2.14.0.txt");
print OUT "query acc.ver	subject acc.ver	% identity	alignment length	",
"mismatches	gap opens	q. start	q. end	s. start	s. end	evalue	bit score\n";

for ($i=0;$i<@key;$i++) {
	for ($j=0;$j<$n;$j++) {
		if ($subjend[$j] > $subjstart[$j]) {
			if (abs($key[$i] - $subjstart[$j])<= 30) {
				push (@lenscore,$Score[$j]);
			}
		}

		if ($subjend[$j] < $subjstart[$j]) {
			if (abs($key[$i] - $subjend[$j])<= 30) {
				push (@lenscore,$Score[$j]);
			}
		}


	}
	my $maxScore = &max(@lenscore);
	@lenscore = ();
	for ($j=0;$j<$n;$j++) {
		if ($subjend[$j] > $subjstart[$j]) {
			if ($key[$i] eq $subjstart[$j]) {
				if (($Score[$j] eq $maxScore) and ($identity[$j] > 85)) {
					if ($subjstart[$j] =~  /^\d+$/) {
						print OUT "$queryid[$j]\t$subjectid[$j]\t$identity[$j]\t$Align_length[$j]\t$mismatches[$j]\t",
						"$Gap[$j]\t$querstart[$j]\t$querend[$j]\t$subjstart[$j]\t$subjend[$j]\t",
						"$E_value[$j]\t$Score[$j]\n";
					}
				}
			}
		}

		if ($subjend[$j] < $subjstart[$j]) {
			if ($key[$i] eq $subjend[$j]) {
				if (($Score[$j] eq $maxScore) and ($identity[$j] > 85)) {
					if ($subjstart[$j] =~  /^\d+$/) {
						print OUT "$queryid[$j]\t$subjectid[$j]\t$identity[$j]\t$Align_length[$j]\t$mismatches[$j]\t",
						"$Gap[$j]\t$querstart[$j]\t$querend[$j]\t$subjstart[$j]\t$subjend[$j]\t",
						"$E_value[$j]\t$Score[$j]\n";
					}
				}
			}
		}

	}
}
close OUT;



sub max {
	my $CurrentMaxValue = shift @_;
	foreach ( @_ ) {
		if ( $_ > $CurrentMaxValue ) {
			$CurrentMaxValue = $_;
		}
	}
	return $CurrentMaxValue;
}

