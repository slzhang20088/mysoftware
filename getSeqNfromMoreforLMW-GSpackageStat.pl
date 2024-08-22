#!/usr/bin/perl
#usage: perl getSeqNfromMoreforLMW-GSpackageStat.pl *-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0--getN.txt
open (IN, $ARGV[0]);
while (<IN>) {

#jagger.1A.LMW-GS_A1.begin.LMW-GS_A1.end.normal.3908299-3909528--1229.CDS_1229bp	263	535	273
#jagger.1A.LMW-GS_A2.begin.LMW-GS_A2.end.normal.3801758-3803080--1322.CDS_1322bp	261	573	313
#jagger.1B.LMW-GS_B1B3B6.begin.LMW-GS_B6.end.RC.2464066-2465278--1212.CDS_1212bp	357	516	160
#jagger.1B.LMW-GS_B1B3B6.begin.LMW-GS_B6.end.RC.2464066-2465278--1212.CDS_1212bp	987	1113	127
#jagger.1B.LMW-GS_B4.begin.LMW-GS_B4.end.RC.3946332-3947411--1079.CDS_1079bp	286	355	70
#jagger.1B.LMW-GS_B5.begin.LMW-GS_B5.end.normal.24188144-24189437--1293.CDS_1293bp	326	573	248
#jagger.1B.LMW-GS_B1B3B6.begin.LMW-GS_B6.end.RC.2442049-2443338--1289.CDS_1289bp	357	529	173
#jagger.1B.LMW-GS_D5.begin.LMW-GS_B4.end.normal.4245661-4246872--1211.CDS_1211bp	325	433	109
#jagger.1D.LMW-GS_D10.begin.LMW-GS_D1D10.end.RC.2443860-2444999--1139.CDS_1139bp	357	470	114
#                     0                                                              1   2   3

	chomp;
	@temp = split (/\t/, $_);
	$seqid[$i] = $temp[0];
	$leng[$i] = $temp[3];
	$line{$seqid[$i]} = $_;
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
open (OUT, ">$name-Stat.txt");
print OUT "SeqID\tmax\tmin\trange\tcount\taverage\tstd\tcv\n";
for ($i=0;$i<@key;$i++) {
	for ($j=0;$j<$n;$j++) {
		if ($key[$i] eq $seqid[$j]) {
			push (@len,$leng[$j]);
		}
	}
	$len = @len;
	my $maxValue = &max(@len);
	my $miniValue = &mini(@len);
	$range = $maxValue - $miniValue;
	my $average = &average(@len);
	$average = sprintf"%.2f",$average;
	
	my $std1 = &stdok($average,@len);
	$std1 = sprintf"%.2f",$std1;
	$cv1 = ($std1 / $average)*100;
	$cv1 = sprintf"%.2f",$cv1;
	
	@len = ();
	for ($j=0;$j<$n;$j++) {
		if ($key[$i] eq $seqid[$j]) {
			if ($leng[$j] eq $maxValue) {
					print OUT"$seqid[$j]\t$maxValue\t$miniValue\t$range\t$len\t$average\t$std1\t$cv1\n";
			}
		}
	}

}
close OUT;



sub max{
	my $currentMaxValue = shift;
	foreach ( @_ ) {
		if ( $_ > $currentMaxValue ) {
			$currentMaxValue = $_;
		}
	}
	return $currentMaxValue;
}


sub mini {
	my $currentMaxValue = shift;
	foreach ( @_ ) {
		if ( $_ < $currentMaxValue ) {
			$currentMaxValue = $_;
		}
	}
	return $currentMaxValue;
}

sub total {
	my $sum = shift;
	foreach ( @_ ) {
		$sum += $_;
	}
	return $sum;
}

sub average {
	&total(@_)/@_;
}

sub stdok{
	if ($len == 1) {
		&std;
	}else{
		&stdd;
	}
}

sub std {
	my ($ave,@squl) = @_;
	$squ = "";
	foreach ( @squl ) {
		$pf = ($_ - $ave)**2;
		$squ += $pf;
	}
	$pfh = $squ/@squl;
	$sqrt = sqrt($pfh);
	return $sqrt;
}

sub stdd {
	my ($ave,@squl) = @_;
	$squ = "";
	foreach ( @squl ) {
		$pf = ($_ - $ave)**2;
		$squ += $pf;
	}
	$pfh = $squ/(@squl-1);
	$sqrt = sqrt($pfh);
	return $sqrt;
}

