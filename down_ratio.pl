# 
# Detect the file in download and show its total ratio
#
# Requires: a download.txt with the total size for file
#
# Author: Daniel Molina Cabrera <danimolina@gmail.com>
# Licence: GNU PUBLIC LICENSE (GPL) v3.0
#
use strict; 
use IO::File;

my $file = new IO::File "sizes.txt" or die "Error, 'sizes.txt' not found";
my $sizes = {};

for (<$file>) {
   my ($size,@fname) = split(/ /);
   my $fname = join(" ", @fname);
   chomp $fname;
   $sizes->{$fname} = $size;
}

$file->close;
my $fname;

for $fname (keys(%$sizes)) {

    if (-e $fname) {
       print "$fname: 100%\n";
       next;
    }

    my $fdown = "$fname.crdownload";

    unless (-f $fdown) {
	next;
    }
    my $current = `du -m $fdown`;
    my $ratio = ($current+0)/$sizes->{$fname};
    print sprintf "%s: %.0f%%\n", $fname, 100*$ratio;
}
