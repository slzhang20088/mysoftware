#!/usr/bin/perl
#useage: perl seqIDstatLMWtypeList2-CSxy54-27CDS.pl *-all-LMW-GS--noGap--FinPS-LMW-GS-inCSxy54-27CDS-out.db.tbl(*indicate genomeName, for example, jagger)

my ($sec,$min,$hour)=localtime(time);
print "\nstart time: $hour-$min-$sec\n\n";

$file = $ARGV[0];
$file =~ s/\.txt//;

open (In, $ARGV[0]) || die "cannot open the $ARGV[0]\n";
$i = 0;
while (<In>){ 
#jagger.scaffold_v14_102480.LMW-GS_D4.begin.LMW-GS_D4.end.normal.1030-1927--897.CDS_897bp	LMW-D3.897bp	95.652	897	39	0	1	897	1	897	0.0	1441
#jagger.1A.LMW-GS_A4.begin.LMW-GS_A4.end.RC.6840630-6841516--886.CDS_886bp	LMW-A4.886bp	100.000	886	0	0	1	886	1	886	0.0	1637
#jagger.1A.LMW-GS_A3.begin.LMW-GS_A3A5.end.RC.2130775-2131687--912.CDS_912bp	LMW-A3.915bp	99.672	915	0	1	1	912	1	915	0.0	1670
#jagger.1D.LMW-GS_A5.begin.LMW-GS_B4.end.normal.3104156-3105053--897.CDS_897bp	LMW-D6.1053bp	90.128	780	56	5	136	897	277	1053	0.0	994
#jagger.1D.LMW-GS_D3.begin.LMW-GS_D3.end.RC.3057552-3058449--897.CDS_897bp	LMW-D3.897bp	98.328	897	15	0	1	897	1	897	0.0	1574
#jagger.1D.LMW-GS_D2D9.begin.LMW-GS_D9.end.RC.2461147-2462062--915.CDS_915bp	D3-2xy54.915bp	100.000	915	0	0	1	915	1	915	0.0	1690
#jagger.1D.LMW-GS_D8.begin.LMW-GS_D5D8.end.RC.5081482-5082580--1098.CDS_1098bp	LMW-D8.1098bp	100.000	1098	0	0	1	1098	1	1098	0.0	2028
#                                               0                                    1            2      3      4   5   6     7     8     9      10  11
	chomp($_);
	@temp = split (/\t/,$_);
	$id1 = $temp[0];
	$type[$i] = $temp[1];
	$type[$i] =~ s/\.\w+//;
	$type[$i] =~ s/LMW\-//;
	$ident[$i] = $temp[2];
	$ident[$i] = sprintf "%.2f",$ident[$i];
	$ident[$i] = $ident[$i]."%";
	$aLength[$i] = $temp[3];
	$score[$i] = $temp[11];

	#$id1#jagger.1D.LMW-GS_D8.begin.LMW-GS_D5D8.end.RC.5081482-5082580--1098.CDS_1098bp
	     #   0   1      2      3         4       5  6       7                  8
	@ttemp = split (/\./,$id1);
	$genome = $ttemp[0];
	$begin[$i] = $ttemp[2];
	$begin[$i] =~ s/LMW\-GS_//;
	$end[$i] = $ttemp[4];
	$end[$i] =~ s/LMW\-GS_//;
	$queryLength[$i] = $ttemp[8];
	$queryLength[$i] =~ s/CDS_//;
	$queryLength[$i] =~ s/bp//;
	$cover = $aLength[$i]/$queryLength[$i]*100;
	$cover = sprintf "%.2f",$cover;
	
	$typeinform[$i] = $type[$i].",".$ident[$i].",".$cover;
	$idstattype[$i] = $begin[$i]."-".$end[$i];
	if (($begin[$i] =~ $end[$i]) or ($end[$i] =~ $begin[$i])){
		$LMWtype{$idstattype[$i]}=$typeinform[$i];
	}else {
		$newtype = $idstattype[$i];
		$newv = $typeinform[$i];
		$LMWtypenew{$newtype}=$newv;
	}
	$i++;
}


$ino = $i;
print "$genome has $ino noGap types of LMW-GS genes'CDS.\n\n";
close (In);

open (OUT,">$file-LMWtypelistCSxy54-27CDS.txt")||die;
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
		print OUT "\t";
	}
	$i++;
}

if (exists $LMWtypenew{$newtype}) {
	$i = 1;
	foreach  $key (sort {$a cmp $b} keys %LMWtypenew){
		print OUT "$LMWtypenew{$key}\t";
		print "New type$i: $key => $LMWtypenew{$key}\n\n";
		$i++;
	}
}
print OUT "CDS\n";

close (IN);
close (OUT);

my ($sec,$min,$hour)=localtime(time);
print "end time: $hour-$min-$sec\n\n";

