#!/usr/bin/perl
#usage: perl dna2proStrucPseudoStat.pl *-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0-proStrucPseudo.txt

open (IN, $ARGV[0]);
while (<IN>) {
#MG560140-CSA-LMW-GSregion.LMW-GS_A3.begin.LMW-GS_A3A5.end.normal.4620703-4621618--915.CDS_915bp	305	52	53	1
#MG560140-CSA-LMW-GSregion.LMW-GS_A1.begin.LMW-GS_A1.end.RC.2075118-2076117--999.CDS_999bp	333	50	51	1
#MG560140-CSA-LMW-GSregion.LMW-GS_A4.begin.LMW-GS_A4.end.normal.4711775-4712661--886.CDS_886bp	295	146	147	1
#MG560140-CSA-LMW-GSregion.LMW-GS_A4.begin.LMW-GS_A4.end.normal.4711775-4712661--886.CDS_886bp	295	176	177	1
#MG560140-CSA-LMW-GSregion.LMW-GS_A4.begin.LMW-GS_A4.end.normal.4711775-4712661--886.CDS_886bp	295	256	257	1
#MG560140-CSA-LMW-GSregion.LMW-GS_A4.begin.LMW-GS_A4.end.normal.4711775-4712661--886.CDS_886bp	295	282	283	1
#MG560141-CSB-LMW-GSregion.LMW-GS_B1B3B6.begin.LMW-GS_B1.end.RC.3746367-3747432--1065.CDS_1065bp	355	121	122	1
#MG560141-CSB-LMW-GSregion.LMW-GS_B1B3B6.begin.LMW-GS_B1.end.RC.3746367-3747432--1065.CDS_1065bp	355	275	276	1
#MG560142-CSD-LMW-GSregion.LMW-GS_D4.begin.LMW-GS_D4.end.RC.3781376-3782276--900.CDS_900bp	300	141	142	1
#MG560142-CSD-LMW-GSregion.LMW-GS_D4.begin.LMW-GS_D4.end.RC.3781376-3782276--900.CDS_900bp	300	151	152	1
#MG560142-CSD-LMW-GSregion.LMW-GS_D4.begin.LMW-GS_D4.end.RC.3781376-3782276--900.CDS_900bp	300	176	177	1
#MG560142-CSD-LMW-GSregion.LMW-GS_D5.begin.LMW-GS_D5D8.end.normal.4290583-4291696--1113.CDS_1113bp	371	83	84	1
#    0                                                                                               1   2   3  4

#norin61.1A.LMW-GS_A4.begin.LMW-GS_A4.end.normal.8389623-8390481--858.CDS_858bp	286	41	42	1	Pseudo
#norin61.1A.LMW-GS_A4.begin.LMW-GS_A4.end.normal.8389623-8390481--858.CDS_858bp	286	48	49	1	Pseudo
#norin61.1A.LMW-GS_A4.begin.LMW-GS_A4.end.normal.8389623-8390481--858.CDS_858bp	286	221	222	1	Pseudo
#norin61.1A.LMW-GS_A7.begin.LMW-GS_A7.end.normal.6162383-6163302--919.CDS_919bp	NA	NA	NA	NA	Incomp
#    0                                                                           1   2   3  4      5


	chomp;
	@temp = split (/\t/, $_);
	$seqid[$i] = $temp[0];
	$stopn[$i] = $temp[4];
	$line{$seqid[$i]} = $temp[5];
	$i++; 
}
close IN; 
$n = $i;

$i = 0;
while (($k,$v) = each(%line)) {
	push (@key,$k);
	push (@val,$v);
	$i++;
}
$name = $ARGV[0];
$name =~ s/\.txt//;
open (OUT, ">$name-Statistics.txt");
for ($i=0;$i<@key;$i++) {
	for ($j=0;$j<$n;$j++) {
		if ($key[$i] eq $seqid[$j]) {
			push (@stop,$stopn[$j]);
		}
	}
	$stop = @stop;
	my $totalValue = &total(@stop);	
	@stop = ();
	print OUT"$key[$i]\t$totalValue\t$val[$i]\n";#$genome[$i]\t
}
close OUT;


sub total {
	my $sum = shift @_;
	foreach ( @_ ) {
		$sum += $_;
	}
	return $sum;
}

