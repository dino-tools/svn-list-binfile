#!/usr/bin/perl -w

use strict;

die "Found no .svn directory.\n" if (!-d "./.svn/");

open(PIPE, "svn propget -R svn:mime-type |");

my $current_filename = "";
my @binary_files;
while (<PIPE>) {
    chomp;
    if (/^(.*) - ([-A-z]+)\/[-A-z]+$/) {
        my $current_filename = $1;
        my $mime_type = $2;
        if ($mime_type ne "text") {
            push(@binary_files, $current_filename)
        }
    } else {
        # die "nazo no gyou: $_";
        # do nothing. ignore.
    }
}
if(@binary_files) {
    print join("\n", sort @binary_files), "\n";
}
