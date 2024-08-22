#!/usr/bin/perl
#usage: perl formatdb2.14.0allFas.pl


while (defined($filename = glob ("*.fas"))) {
	system "makeblastdb -in $filename -out $filename.db -dbtype nucl -parse_seqids -hash_index";
}
