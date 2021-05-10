#!/usr/bin/perl -w

my@fieldNames = 0;
my @maxLen = 0;
my $numAttr = 0;

my $true = 1;
my $false = 0;


$first = $true;
while(<>) {
    chop;chop;
#    print $_;
    if ($first) {
	@info = split(",");
	$numAttr = $#info;
	print $_;
	print "\n";
    }
    if ($first != 1) {
	@info = split(",");
	for($i = 0; $i < $numAttr; ++$i) {
	    print "$info[$i]," if $i != 3;
	    if ($i == 3) {
		my $dt = $info[3];
		$dt =~ s/(.*)T(.*)Z/$1 $2/;
		print "$dt,";
	    }
	}
	print "$info[$numAttr]\n";
    }
    $first = $false;
}

exit(0);

