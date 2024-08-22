#!/usr/bin/perl
#useage: perl seqIDstatLMWtypeList2-findRe.pl *-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0allStruc.txt(*indicate genomeName, for example, stanley)
										#allType.txt contain:
										#*--noGap-proStrucNormal.txt + *--noGap-proStrucPseudo-Statistics.txt + *--getN-Stat.txt
my ($sec,$min,$hour)=localtime(time);
print "\nstart time: $hour-$min-$sec\n\n";

$file = $ARGV[0];
$file =~ s/\.txt//;

open (In, $ARGV[0]) || die "cannot open the $ARGV[0]\n";
$i = 0;
while (<In>){ 
#jagger.1D.LMW-GS_A5.begin.LMW-GS_B4.end.normal.3104156-3105053--897.CDS_897bp	299	Normal
#jagger.1D.LMW-GS_D2D9.begin.LMW-GS_D9.end.RC.2461147-2462062--915.CDS_915bp	305	Normal
#jagger.1D.LMW-GS_D8.begin.LMW-GS_D5D8.end.RC.5081482-5082580--1098.CDS_1098bp	366	Normal
#                                               0                                1    2
#jagger.1A.LMW-GS_A3.begin.LMW-GS_A3A5.end.RC.2130775-2131687--912.CDS_912bp	1	Pseudo
#jagger.scaffold_v14_102480.LMW-GS_D4.begin.LMW-GS_D4.end.normal.1030-1927--897.CDS_897bp	1	Pseudo
#jagger.1A.LMW-GS_A4.begin.LMW-GS_A4.end.RC.6840630-6841516--886.CDS_886bp	4	Pseudo
#jagger.1D.LMW-GS_D3.begin.LMW-GS_D3.end.RC.3057552-3058449--897.CDS_897bp	1	Pseudo
#                                               0                           1       2
#SeqID	max	min	range	count	average	std	cv
#jagger.1B.LMW-GS_D5.begin.LMW-GS_B4.end.normal.4245661-4246872--1211.CDS_1211bp	109	109	0	1	109.00	0.00	0.00
#jagger.1D.LMW-GS_D10.begin.LMW-GS_D1D10.end.RC.2443860-2444999--1139.CDS_1139bp	114	114	0	1	114.00	0.00	0.00
#jagger.1A.LMW-GS_A2.begin.LMW-GS_A2.end.normal.3801758-3803080--1322.CDS_1322bp	313	313	0	1	313.00	0.00	0.00
#jagger.1B.LMW-GS_B4.begin.LMW-GS_B4.end.RC.3946332-3947411--1079.CDS_1079bp	70	70	0	1	70.00	0.00	0.00
#jagger.1A.LMW-GS_A1.begin.LMW-GS_A1.end.normal.3908299-3909528--1229.CDS_1229bp	273	273	0	1	273.00	0.00	0.00
#jagger.1B.LMW-GS_B5.begin.LMW-GS_B5.end.normal.24188144-24189437--1293.CDS_1293bp	248	248	0	1	248.00	0.00	0.00
#jagger.1B.LMW-GS_B1B3B6.begin.LMW-GS_B6.end.RC.2464066-2465278--1212.CDS_1212bp	160	127	33	2	143.50	23.33	16.26
#jagger.1B.LMW-GS_B1B3B6.begin.LMW-GS_B6.end.RC.2442049-2443338--1289.CDS_1289bp	173	173	0	1	173.00	0.00	0.00
#                                              0                                     1   2
	chomp($_);
	@temp = split (/\t/,$_);
	$id1[$i] = $temp[0];
	$type[$i] = $temp[2];
	#$id1#stanley.1D.LMW-GS_D7.begin.LMW-GS_D7.end.normal.6781289-6782201--912.CDS_912bp
	     #   0     1      2      3       4      5    6  
	@ttemp = split (/\./,$id1[$i]);
	$genome = $ttemp[0];
	$begin[$i] = $ttemp[2];
	$begin[$i] =~ s/LMW\-GS_//;
	$end[$i] = $ttemp[4];
	$end[$i] =~ s/LMW\-GS_//;
	$idstattype[$i] = $begin[$i]."-".$end[$i];
	if (($begin[$i] =~ $end[$i]) or ($end[$i] =~ $begin[$i])){
		push (@typeall, $idstattype[$i]);
	}else {
		$newtype = $idstattype[$i];
		push (@typeallnew, $newtype);
	}
	$i++;
}

my %count1; 
my @m2times1 = grep { ++$count1{ $_ } > 1; } @typeall;
print "2 or more of begin-end matching1: @m2times1\n";
my %count2; 
my @m2times2 = grep { ++$count2{ $_ } < 2; } @m2times1;
print "2 or more of begin-end matching2: @m2times2\n";

my %count3; 
my @m2times3 = grep { ++$count3{ $_ } > 1; } @typeallnew;
print "2 or more of new1: @m2times3\n";
my %count4; 
my @m2times4 = grep { ++$count4{ $_ } < 2; } @m2times3;
print "2 or more of new2: @m2times4\n";


$ino = $i -1;
print "$genome has $ino types of LMW-GS genes.\n\n";
close (In);

open (OUT,">$file-LMWtypelistFindRe.txt")||die;
open (IN, $ARGV[0]) || die "cannot open the $ARGV[0]\n";
$i = 0;
while (<IN>){ 
	chomp($_);
	@tempp = split (/\t/,$_);
	$id2[$i] = $tempp[0];
	$type2[$i] = $tempp[2];
	if ($type2[$i] =~ /\d+/) {
		$type2[$i] = "gapCon";
	}
	#$id2#stanley.1D.LMW-GS_D7.begin.LMW-GS_D7.end.normal.6781289-6782201--912.CDS_912bp
	     #   0     1      2      3       4      5    6      7
	@ttempp = split (/\./,$id2[$i]);
	$genome2 = $ttempp[0];
	$begin2[$i] = $ttempp[2];
	$begin2[$i] =~ s/LMW\-GS_//;
	$end2[$i] = $ttempp[4];
	$end2[$i] =~ s/LMW\-GS_//;
	$idstattype2[$i] = $begin2[$i]."-".$end2[$i];
	if (($begin2[$i] =~ $end2[$i]) or ($end2[$i] =~ $begin2[$i])){
		if ( grep { $_ eq $idstattype2[$i] } @m2times2) {
			$posi = $ttempp[7];
			$posi =~ s/\-\-/\t/;
			$posi =~ s/\-/\t/;
			print OUT "$genome2\t$ttempp[1]\t$begin2[$i]\t$end2[$i]\t$ttempp[6]\t$posi\t$type2[$i]\n";
		}

	}else {
		$newtype2 = $idstattype2[$i];
		if ( grep { $_ eq $newtype2 } @m2times4) {
			$posi = $ttempp[7];
			$posi =~ s/\-\-/\t/;
			$posi =~ s/\-/\t/;
			print OUT "$genome2\t$ttempp[1]\t$begin2[$i]\t$end2[$i]\t$ttempp[6]\t$posi\t$type2[$i]\n";
		}
	}
	$i++;
}

close (IN);
close (OUT);

my ($sec,$min,$hour)=localtime(time);
print "end time: $hour-$min-$sec\n\n";

