#!/usr/bin/perl
#useage: perl seqIDstatLMWtypeList.pl *-all-LMW-GS_BatchCDSextractResultsfromChr.2.14.0.IDstat.txt(*indicate genomeName, for example, stanley)

my ($sec,$min,$hour)=localtime(time);
print "start time: $hour-$min-$sec\n\n";

$file = $ARGV[0];
$file =~ s/\.txt//;

open (In, $ARGV[0]) || die "cannot open the $ARGV[0]\n";
$i = 0;
while (<In>){ 
#stanley	1A	A2	A1	RC	4588963	4589974	1011
#stanley	1A	A4	A4	RC	6158439	6159325	886
#stanley	1A	A3	A3A5	RC	5662963	5663875	912
#stanley	1A	A2	A2	RC	4690953	4692279	1326
#stanley	1B	B1B3B6	B3	RC	6136012	6137104	1092
#stanley	1B	B4	B4	RC	6888024	6889077	1053
#stanley	1B	B1B3B6	B1	RC	5964882	5965947	1065
#stanley	1D	D6	D6	normal	6564652	6565708	1056
#stanley	1D	D10	D1D10	RC	4292432	4293497	1065
#stanley	1D	D4	D4	RC	5017644	5018544	900
#stanley	1D	D2D9	D9	RC	4309412	4310327	915
#stanley	1D	D3	D3	RC	4894646	4895543	897
#stanley	1D	D5	D5D8	normal	5573323	5574436	1113
#stanley	1D	D8	D5D8	RC	8530661	8531759	1098
#stanley	1D	D7	D7	normal	6781289	6782201	912
#  0         1  2   3     4       5       6      7

	chomp($_);
	@temp = split (/\t/,$_);
	$genome = $temp[0];
	$chr[$i] = $temp[1];
	$begin[$i] = $temp[2];
	$end[$i] = $temp[3];
	$idstattype[$i] = $begin[$i]."-".$end[$i];
	if (($begin[$i] =~ $end[$i]) or ($end[$i] =~ $begin[$i])){
		$LMWtype{$idstattype[$i]}=$_;
	}else {
		$newtype = $idstattype[$i];
		$LMWtypenew{$newtype}=$_;
	}
	$i++;
}

$ino = $i;
print "$genome has $ino types of LMW-GS genes.\n\n";
close (In);

open (OoUT,">$file-LMWtypelistnotfind.txt")||die;
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
print OoUT "$genome\t";

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
		print OUT "$_\t";
		push (@find, $i);
	}else{
		$m = $i + 1;
		push (@notf, $m);
		print "No $m $_ is not exists!\n";
		print OUT "NA\t";
		print OoUT "$_\t";
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
		print OUT "$key\t";
		print "New type$i: $key => $LMWtypenew{$key}\n\n";
		$i++;
	}
}

print OUT "\n";
print OoUT "\n";

close (IN);
close (OUT);
close (OoUT);

my ($sec,$min,$hour)=localtime(time);
print "end time: $hour-$min-$sec\n\n";

