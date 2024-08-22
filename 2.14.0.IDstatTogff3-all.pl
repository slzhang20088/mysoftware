#!/usr/bin/perl

my $current_time = time;
my $local_time = localtime($current_time);
print "\nStart time: $local_time\n\n";


my ($sec,$min,$hour)=localtime(time);
print "start time: $hour-$min-$sec\n";

while (defined ($filename1 = glob ("*2.14.0.IDstat.txt")))  {
	system "perl 2.14.0.IDstatTogff3.pl $filename1";
}
my ($sec,$min,$hour)=localtime(time);
print "end time: $hour-$min-$sec\n";


my $current_time = time;
my $local_time = localtime($current_time);
print "\nEnd time: $local_time\n\n";

