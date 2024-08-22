#!/usr/bin/perl
#usage: perl seqB_shIDstatChmodxdos2unix.pl

system "dos2unix *sh *IDstat*";
system "chmod +x *sh *IDstat*";
