#!/usr/bin/perl
#usage£ºperl dna2pro.pl DNAseq seqID fasfilename #genomeName


@DNA = $ARGV[0];
$DNA = join( '', @DNA);
$DNA =~ s/\s//g;
my $protein='';
my $codon;
for(my $i=0;$i<(length($DNA)-2);$i+=3){
	$codon=substr($DNA,$i,3);
	$protein.=&codonToAA($codon);
}
open (Out,">>$ARGV[2]-pro.fasta");
print Out ">$ARGV[1]\n";#$ARGV[3]-
print Out "$protein\n";
close Out;

$lenseq= length $protein;

if (($protein =~ /\*{1,}$/) and ($protein =~ /^M/)) {
	$protein =~ s/\*{1,}$//;
	if ($protein =~ /\*{1,}/) {

		open (Outt,">>$ARGV[2]-proStrucPseudo.txt")||die;
		while ($protein =~ /\*{1,}/gi) {
			$st = $-[0];
			$en = $+[0];
			$len = $en - $st;
			print Outt "$ARGV[1]\t$lenseq\t$st\t$en\t$len\tPseudo\n";#$ARGV[3]\t
		}
		close (Outt);
	}else{
		open (Oout,">>$ARGV[2]-proStrucNormal.fasta");
		print Oout ">$ARGV[1]\n";#$ARGV[3]-
		print Oout "$protein\n";
		close Oout;

		open (Outtt,">>$ARGV[2]-proStrucNormal.txt")||die;
		print Outtt "$ARGV[1]\t$lenseq\tNormal\n";#$ARGV[3]\t
		close (Outtt);
	}
}elsif (($protein =~ /^M/) and ($protein !~ /\*{1,}$/) and ($protein !~ /\*{1,}/)) {
		open (Outt,">>$ARGV[2]-proStrucPseudo.txt")||die;
			print Outt "$ARGV[1]\tNA\tNA\tNA\tNA\tIncomp\n";
		close (Outt);
}else{
	if ($protein =~ /\*{1,}/) {
		open (Outt,">>$ARGV[2]-proStrucPseudo.txt")||die;
		while ($protein =~ /\*{1,}/gi) {
			$st = $-[0];
			$en = $+[0];
			$len = $en - $st;
			print Outt "$ARGV[1]\t$lenseq\t$st\t$en\t$len\tPseudo\n";#$ARGV[3]\t
		}
		close (Outt);
	}else{
		open (Outt,">>$ARGV[2]-proStrucPseudo.txt")||die;
			print Outt "$ARGV[1]\tNA\tNA\tNA\tNA\tPseudo\n";
		close (Outt);
	}
}



sub codonToAA{
	my($codon)=@_;
	$codon=uc $codon;
	my(%gc)=(
		'TCA'=>'S','TCC'=>'S','TCG'=>'S','TCT'=>'S','AGC'=>'S','AGT'=>'S',
		'TTC'=>'F','TTT'=>'F',
		'TAC'=>'Y','TAT'=>'Y',
		'TAA'=>'*','TAG'=>'*','TGA'=>'*',
		'TGC'=>'C','TGT'=>'C',
		'TGG'=>'W',
		'CTA'=>'L','CTC'=>'L','CTG'=>'L','CTT'=>'L','TTA'=>'L','TTG'=>'L',
		'CCA'=>'P','CCC'=>'P','CCG'=>'P','CCT'=>'P',
		'CAC'=>'H','CAT'=>'H',
		'CAA'=>'Q','CAG'=>'Q',
		'CGA'=>'R','CGC'=>'R','CGG'=>'R','CGT'=>'R','AGA'=>'R','AGG'=>'R',
		'ATA'=>'I','ATC'=>'I','ATT'=>'I',
		'ATG'=>'M',
		'ACA'=>'T','ACC'=>'T','ACG'=>'T','ACT'=>'T',
		'AAC'=>'N','AAT'=>'N',
		'AAA'=>'K','AAG'=>'K',
		'GTA'=>'V','GTC'=>'V','GTG'=>'V','GTT'=>'V',
		'GCA'=>'A','GCC'=>'A','GCG'=>'A','GCT'=>'A',
		'GAC'=>'D','GAT'=>'D',
		'GAA'=>'E','GAG'=>'E',
		'GGA'=>'G','GGC'=>'G','GGG'=>'G','GGT'=>'G'
		);
	if(exists $gc{$codon}){
		return $gc{$codon};
	}else{
		print STDERR "Find bad codon \"$codon\"!\n\n";
		exit;
	}
}

