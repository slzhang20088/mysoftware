#!/usr/bin/perl
#usage: perl findSubjectPositionScoreMax2.14.0-delRbyIdent.pl *.db.tbl-findSubjectPositionScoreMax2.14.0.txt 

open (IN, $ARGV[0]);
while (<IN>) {
#query acc.ver	subject acc.ver	% identity	alignment length	mismatches	gap opens	q. start	q. end	s. start	s. end	evalue	bit score
#LMW-GS_B2.end	1B	100.000	90	0	0	1	90	2743650	2743561	1.94e-40	167
#LMW-GS_B1.end	1B	100.000	90	0	0	1	90	2673785	2673696	1.94e-40	167
#LMW-GS_B3.end	1B	97.701	87	2	0	4	90	2852806	2852720	1.96e-35	150
#LMW-GS_D1D10.end	1B	96.667	90	3	0	1	90	2852809	2852720	1.96e-35	150
#LMW-GS_B4.end	1B	100.000	90	0	0	1	90	3970735	3970646	1.94e-40	167
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
open (OUT, ">$name-delRbyIdent.txt");
print OUT "query acc.ver	subject acc.ver	% identity	alignment length	",
"mismatches	gap opens	q. start	q. end	s. start	s. end	evalue	bit score\n";

for ($i=0;$i<@key;$i++) {
	for ($j=0;$j<$n;$j++) {
		if ($subjend[$j] > $subjstart[$j]) {
			if (abs($key[$i] - $subjstart[$j])<= 30) {
				push (@lenscore,$identity[$j]);
			}
		}

		if ($subjend[$j] < $subjstart[$j]) {
			if (abs($key[$i] - $subjend[$j])<= 30) {
				push (@lenscore,$identity[$j]);
			}
		}


	}
	my $maxScore = &max(@lenscore);
	@lenscore = ();
	for ($j=0;$j<$n;$j++) {
		if ($subjend[$j] > $subjstart[$j]) {
			if ($key[$i] eq $subjstart[$j]) {
				if (($identity[$j] eq $maxScore) and ($identity[$j] > 85)) {
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
				if (($identity[$j] eq $maxScore) and ($identity[$j] > 85)) {
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

