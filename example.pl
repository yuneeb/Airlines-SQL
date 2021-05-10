#!/usr/bin/perl -w
#
# Accept an SQL outfile with query data
# Match the timing information
# The match assumes a single row of output
# This match would need to be changed for other possible outputs
# Compute an average over the results
# Throw out the worst result and recompute the average
# If no individual result is worse than the new average by more
# than $tolerance then report the new average and the worst
# deviation from that average
# If some result is worse than the tolerance level,
# issue an error message and exit

my $tolerance = 0.10;    # 10% tolerance
my @results = ();

# Get the results from the file
while(<>) {
    if ($_ =~ /1 row in set \((.*) sec\)/) {
	push @results, $1;
    }
}

# Process Results
# Compute average over four results
my $sum = 0;
foreach $r (@results) {
    $sum += $r;
}
my $avg = $sum/scalar(@results);

# Pick worst and throw it out
my $worst = $avg;
foreach $r (@results) {
    if (abs($avg - $r) > abs($avg - $worst)) {
	$worst = $r;
    }
}

# Compute average over remaining three
$sum = 0;
foreach $r (@results) {
    if ($r != $worst) {
	$sum += $r;
    }
}

# Determine what the worst error is relative to average
# If it is more than the tolerance, exit
# Otherwise, print the average and worst deviation
my $worstDeviation = 0;
$avg = $sum/(scalar(@results) - 1);
foreach $r (@results) {
    if ($r != $worst) {
	if (abs($avg - $r)/$avg > $tolerance) {
	    printf "Deviance too great: %.2f%%; exiting\n", (100.0*abs($avg - $r)/$avg);
	    exit -1;
	}
	if ((abs($avg - $r)/$avg) > $worstDeviation) {
	    $worstDeviation = (abs($avg - $r)/$avg)
	}
    }
}
printf "Average is: %.2f\nWorst Deviation is: %.2f%%\n", $avg, $worstDeviation*100;




