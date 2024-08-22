#!/usr/bin/perl
#usage: perl 2.14.0.IDstatTogff3.pl IDstatfile(for example, kariega-all-LMW-GS.2.14.0.IDstat.txt)

$file2 = $ARGV[0];
$file2 =~ s/\.txt//;
open (In, $ARGV[0]) || die "cannot open the 2.14.0.IDstat.txt file";
open (Out,">$ARGV[0].gff3")||die;
open (Outt,">$ARGV[0].gff3.geneNameNew.txt")||die;

print Out "##gff-version 3\n";

$i = 0;
while (<In>){ 
#kariega	1A	A4	A4	normal	9384199	9385081	882
#kariega	1A	A1	A1	RC	5119294	5120296	1002
#kariega	1A	A3	A3A5	normal	9257663	9258548	885
#   0       1   2    3        4       5      6       7
	chomp($_);	
	@temp = split (/\t/,$_);
	$id[$i] = $temp[1];
	$st[$i] = $temp[5]+1;
	$en[$i] = $temp[6];
	$Len[$i] = $temp[7]."bp";
	$gene[$i] = $temp[0]."_".$temp[1]."g".$temp[2].".".$temp[3]."p".$st[$i];
	if ($temp[4] eq "normal") {
		print Out "$temp[1]\tLMWgsFinder\tgene\t$st[$i]\t$temp[6]\t.\t+\t.\tID=gene:$gene[$i]s$Len[$i];Info=1,$temp[7]\n";
		print Out "$temp[1]\tLMWgsFinder\tmRNA\t$st[$i]\t$temp[6]\t.\t+\t.\tID=transcript:$gene[$i]s$Len[$i].1;Parent=gene:$gene[$i]s$Len[$i];transcript_id=$gene[$i]s$Len[$i].1\n";
		print Out "$temp[1]\tLMWgsFinder\texon\t$st[$i]\t$temp[6]\t.\t+\t.\tParent=transcript:$gene[$i]s$Len[$i].1\n";
		print Out "$temp[1]\tLMWgsFinder\tCDS\t$st[$i]\t$temp[6]\t.\t+\t0\tID=CDS:cds.$gene[$i]s$Len[$i].1;Parent=transcript:$gene[$i]s$Len[$i].1;protein_id=cds.$gene[$i]s$Len[$i].1\n";
		print Outt "$gene[$i]s$Len[$i]\n";
#1A	KAUST	gene	564846	566120	.	+	.	ID=gene:TraesKAR1A01G0000030;biotype=protein_coding;gene_id=TraesKAR1A01G0000030;logic_name=gff3_high_conf
#1A	KAUST	mRNA	564846	566120	.	+	.	ID=transcript:TraesKAR1A01G0000030.1;Parent=gene:TraesKAR1A01G0000030;transcript_id=TraesKAR1A01G0000030.1
#1A	KAUST	exon	564846	565188	.	+	.	Parent=transcript:TraesKAR1A01G0000030.1;rank=1
#1A	KAUST	CDS	565008	565188	.	+	0	ID=CDS:cds.TraesKAR1A01G0000030.1;Parent=transcript:TraesKAR1A01G0000030.1;protein_id=cds.TraesKAR1A01G0000030.1
	}elsif($temp[4] eq "RC"){
		print Out "$temp[1]\tLMWgsFinder\tgene\t$st[$i]\t$temp[6]\t.\t-\t.\tID=gene:$gene[$i]a$Len[$i];Info=1,$temp[7]\n";
		print Out "$temp[1]\tLMWgsFinder\tmRNA\t$st[$i]\t$temp[6]\t.\t-\t.\tID=transcript:$gene[$i]a$Len[$i].1;Parent=gene:$gene[$i]a$Len[$i];transcript_id=$gene[$i]a$Len[$i].1\n";
		print Out "$temp[1]\tLMWgsFinder\texon\t$st[$i]\t$temp[6]\t.\t-\t.\tParent=transcript:$gene[$i]a$Len[$i].1\n";
		print Out "$temp[1]\tLMWgsFinder\tCDS\t$st[$i]\t$temp[6]\t.\t-\t0\tID=CDS:cds.$gene[$i]a$Len[$i].1;Parent=transcript:$gene[$i]a$Len[$i].1;protein_id=cds.$gene[$i]a$Len[$i].1\n";
		print Outt "$gene[$i]a$Len[$i]\n";
	}
	$i++;
}
close (In);
close (Out);
###gff-version 3
###sequence-region   1A 1 613662638
##!genome-build KAUST Tae_Kariega_v1
##!genome-version Tae_Kariega_v1
##!genome-date 2020-22
##!genome-build-accession GCA_910594105.1
#1A	Tae_Kariega_v1	chromosome	1	613662638	.	.	.	ID=chromosome:1A
####
#1A	KAUST	gene	564846	566120	.	+	.	ID=gene:TraesKAR1A01G0000030;biotype=protein_coding;gene_id=TraesKAR1A01G0000030;logic_name=gff3_high_conf
#1A	KAUST	mRNA	564846	566120	.	+	.	ID=transcript:TraesKAR1A01G0000030.1;Parent=gene:TraesKAR1A01G0000030;biotype=protein_coding;tag=Ensembl_canonical;transcript_id=TraesKAR1A01G0000030.1
#1A	KAUST	five_prime_UTR	564846	565007	.	+	.	Parent=transcript:TraesKAR1A01G0000030.1
#1A	KAUST	exon	564846	565188	.	+	.	Parent=transcript:TraesKAR1A01G0000030.1;Name=TraesKAR1A01G0000030.1-E1;constitutive=1;ensembl_end_phase=1;ensembl_phase=-1;exon_id=TraesKAR1A01G0000030.1-E1;rank=1
#1A	KAUST	CDS	565008	565188	.	+	0	ID=CDS:cds.TraesKAR1A01G0000030.1;Parent=transcript:TraesKAR1A01G0000030.1;protein_id=cds.TraesKAR1A01G0000030.1
#1A	KAUST	CDS	565552	565784	.	+	2	ID=CDS:cds.TraesKAR1A01G0000030.1;Parent=transcript:TraesKAR1A01G0000030.1;protein_id=cds.TraesKAR1A01G0000030.1
#1A	KAUST	exon	565552	566120	.	+	.	Parent=transcript:TraesKAR1A01G0000030.1;Name=TraesKAR1A01G0000030.1-E2;constitutive=1;ensembl_end_phase=-1;ensembl_phase=1;exon_id=TraesKAR1A01G0000030.1-E2;rank=2
#1A	KAUST	three_prime_UTR	565785	566120	.	+	.	Parent=transcript:TraesKAR1A01G0000030.1
####

###gff-version 3
#1A	TBtools	exon	9384200	9385081	.	+	.	ID=exon0;Parent=Takari_1AgA4p9384199s882bp;Info=1,882
#1A	TBtools	exon	5119295	5120296	.	-	.	ID=exon0;Parent=Takari_1AgA1p5119294a1002bp;Info=1,1002
#1A	TBtools	exon	9257664	9258548	.	+	.	ID=exon0;Parent=Takari_1AgA3p9257663s885bp;Info=1,885
