#!/usr/bin/perl
#useage: perl seqIDstatLMWtypeList2.pl *-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0allStruc.txt(*indicate genomeName, for example, stanley)
										#allType.txt contain:
										#*--noGap-proStrucNormal.txt + *--noGap-proStrucPseudo-Statistics.txt + *--getN-Stat.txt
my ($sec,$min,$hour)=localtime(time);
print "\nstart time: $hour-$min-$sec\n\n";

$file = $ARGV[0];
$file =~ s/\.txt//;

open (In, $ARGV[0]) || die "cannot open the $ARGV[0]\n";
$i = 0;
while (<In>){ 
#stanley.1B.LMW-GS_B1B3B6.begin.LMW-GS_B3.end.RC.6136012-6137104--1092.CDS_1092bp	364	Normal
#stanley.1B.LMW-GS_B4.begin.LMW-GS_B4.end.RC.6888024-6889077--1053.CDS_1053bp	351	Normal
#stanley.1D.LMW-GS_D6.begin.LMW-GS_D6.end.normal.6564652-6565708--1056.CDS_1056bp	352	Normal
#stanley.1D.LMW-GS_D10.begin.LMW-GS_D1D10.end.RC.4292432-4293497--1065.CDS_1065bp	355	Normal
#stanley.1D.LMW-GS_D2D9.begin.LMW-GS_D9.end.RC.4309412-4310327--915.CDS_915bp	305	Normal
#stanley.1D.LMW-GS_D3.begin.LMW-GS_D3.end.RC.4894646-4895543--897.CDS_897bp	299	Normal
#stanley.1D.LMW-GS_D8.begin.LMW-GS_D5D8.end.RC.8530661-8531759--1098.CDS_1098bp	366	Normal
#stanley.1D.LMW-GS_D7.begin.LMW-GS_D7.end.normal.6781289-6782201--912.CDS_912bp	304	Normal
#                                               0                                1    2
#stanley.1B.LMW-GS_B1B3B6.begin.LMW-GS_B1.end.RC.5964882-5965947--1065.CDS_1065bp	2	Pseudo
#stanley.1D.LMW-GS_D4.begin.LMW-GS_D4.end.RC.5017644-5018544--900.CDS_900bp	3	Pseudo
#stanley.1A.LMW-GS_A4.begin.LMW-GS_A4.end.RC.6158439-6159325--886.CDS_886bp	4	Pseudo
#stanley.1A.LMW-GS_A2.begin.LMW-GS_A1.end.RC.4588963-4589974--1011.CDS_1011bp	1	Pseudo
#stanley.1A.LMW-GS_A3.begin.LMW-GS_A3A5.end.RC.5662963-5663875--912.CDS_912bp	1	Pseudo
#stanley.1D.LMW-GS_D5.begin.LMW-GS_D5D8.end.normal.5573323-5574436--1113.CDS_1113bp	1	Pseudo
#                                               0                                   1    2
#SeqID	max	min	range	count	average	std	cv
#stanley.1A.LMW-GS_A2.begin.LMW-GS_A2.end.RC.4690953-4692279--1326.CDS_1326bp	276	276	0	1	276.00	0.00	0.00
#                                            0                                   1   2

	chomp($_);
	@temp = split (/\t/,$_);
	$id1 = $temp[0];
	$type[$i] = $temp[2];
	if ($type[$i] =~ /\d+/) {
		$type[$i] = "gapCon";
	}
	#$id1#stanley.1D.LMW-GS_D7.begin.LMW-GS_D7.end.normal.6781289-6782201--912.CDS_912bp
	     #   0     1      2      3       4      5    6  
	@ttemp = split (/\./,$id1);
	$genome = $ttemp[0];
	$begin[$i] = $ttemp[2];
	$begin[$i] =~ s/LMW\-GS_//;
	$end[$i] = $ttemp[4];
	$end[$i] =~ s/LMW\-GS_//;
	$idstattype[$i] = $begin[$i]."-".$end[$i];
	if (($begin[$i] =~ $end[$i]) or ($end[$i] =~ $begin[$i])){
		$LMWtype{$idstattype[$i]}=$type[$i];
	}else {
		$newtype = $idstattype[$i];
		$newv = $type[$i];
		$LMWtypenew{$newtype}=$newv;
	}
	$i++;
}


$ino = $i -1;
print "$genome has $ino types of LMW-GS genes.\n\n";
close (In);

open (OUT,">$file-LMWtypelist.txt")||die;
print OUT "$genome	A1-A1	A2-A2	A3-A3A5	A4-A4	A5-A3A5	A6-A6	A7-A7	B1B3B6-B1	B2-B2	B1B3B6-B3	B4-B4	B5-B5	B1B3B6-B6	D1-D1D10	D2D9-D2	D3-D3	D4-D4	D5-D5D8	D6-D6	D7-D7	D8-D5D8	D2D9-D9	D10-D1D10	D11-D11	";
if (exists $LMWtypenew{$newtype}) {
	$i = 1;
	foreach  $key (sort {$a cmp $b} keys %LMWtypenew){
		print OUT "$key\t";
		$i++;
	}
	print OUT "\n";
}else{
	print OUT "\n";
}

print OUT "$genome\t";

open (IN, "LMW-GS-begin-endID.txt") || die "cannot open the LMW-GS-begin-endID.txt\n";
$i = 0;
while (<IN>){ 
#A1-A1
#A2-A2
#A3-A3A5
#A4-A4
#A5-A3A5
#A6-A6
#A7-A7
#B1B3B6-B1
#B2-B2
#B1B3B6-B3
#B4-B4
#B5-B5
#B1B3B6-B6
#D1-D1D10
#D2D9-D2
#D3-D3
#D4-D4
#D5-D5D8
#D6-D6
#D7-D7
#D8-D5D8
#D2D9-D9
#D10-D1D10
#D11-D11

	chomp($_);
	if (exists $LMWtype{$_}) {
		print OUT "$LMWtype{$_}\t";
		push (@find, $i);
	}else{
		$m = $i + 1;
		push (@notf, $m);
		print "No $m $_ is not exists!\n";
		print OUT "NA\t";
	}
	$m++;
	$i++;
}
$finds =@find;
$notfind = @notf;
print "Total $notfind of begin-end matching do not exist.\n\n";
print "Total found numbers of begin-end matching is $finds!\n\n";

if (exists $LMWtypenew{$newtype}) {
	$i = 1;
	foreach  $key (sort {$a cmp $b} keys %LMWtypenew){
		print OUT "$LMWtypenew{$key}\t";
		print "New type$i: $key => $LMWtypenew{$key}\n\n";
		$i++;
	}
}
print OUT "\n";

close (IN);
close (OUT);

my ($sec,$min,$hour)=localtime(time);
print "end time: $hour-$min-$sec\n\n";

