#!/usr/bin/perl
#usage: perl formatdb2.14.0-makeblastdb-genome.pl fasfile(genomic DNA) genomeName
#

system "makeblastdb -in $ARGV[0] -out $ARGV[0].db -dbtype nucl -parse_seqids -hash_index";
