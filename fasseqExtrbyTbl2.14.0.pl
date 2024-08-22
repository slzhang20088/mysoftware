#!/usr/bin/perl

#usage: perl fasseqExtrbyTbl2.14.0.pl databasefasfile
#

my ($sec,$min,$hour)=localtime(time);
print "fasseqExtrbyTbl2.14.0.pl start time: $hour-$min-$sec\n";

open (SL,"<out.db.tbl") or die $!;
$i = 0;
while (<SL>) {
#LMW-GS_A2.begin	MG560142-CSD-LMW-GSregion	90.323	62	6	0	1	62	2971241	2971180	6.30e-17	82.4
#LMW-GS_A3.begin	MG560142-CSD-LMW-GSregion	93.333	90	6	0	1	90	2971241	2971152	1.72e-32	134
#LMW-GS_A4.begin	MG560142-CSD-LMW-GSregion	94.444	90	5	0	1	90	2971241	2971152	3.69e-34	139
#    0                    1

	chomp;
	@temp = split (/\t/, $_);
	$seqno[$i] = $temp[1];
	$line{$seqno[$i]}=$_;
	$i++;
}
close (SL);


$i = 0;
while (($k[$i],$v[$i]) = each(%line)) {
	push(@keys,$k[$i]);
	$i++;
}



open (IN,"<$ARGV[0]") || die ("\nError: Couldn't open name file !\n\n");

undef $/;
$/= ">";
$j = 0;
while (<IN>){
	next unless ( ($id,$seq) = /(.*?)\n(.*)/s); 
		$id4=$id;
		$id4= ~/(^\S+).*/; 
		$id2=$1;

		for ($i=0;$i < @keys;$i++) {
			if ($id2 eq $k[$i]) {
				$idnew = $id;
				$idnew =~ s/\s+/\./g;
				$idnew =~ s/\:/\-/g;
				$seq =~ s/[\d\s>]//g;
				open (Out,">$idnew.fas")||die;
				print "inid : $id\ninidnew: $id2\ninseqno: $k[$i]\n\n";
				print Out ">$id\n$seq\n";
				close (Out);
			}
		}
	$j++;
}
close (IN);

my ($sec1,$min1,$hour1)=localtime(time);
print "fasseqExtrbyTbl2.14.0.pl end time: $hour1-$min1-$sec1\n";







