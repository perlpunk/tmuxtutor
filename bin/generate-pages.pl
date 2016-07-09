#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;
use IO::All;
use File::Basename qw/ basename /;


my $TMPL = io->file('pages-template.html')->slurp;

my @html_files = io('html')->all_files;
mkdir "out-html";

for my $file (@html_files) {
    my $name = basename $file->name;
    next unless $name =~ m/^(\d+)\.(.*)\.html$/;
    say "Processing $name...";
    my ($num, $title) = ($1, $2);
    my $html = $file->slurp;

    my $tmpl = $TMPL;
    $tmpl =~ s/\$TITLE/$title/g;
    $tmpl =~ s/\$CONTENT/$html/;
    io("out-html/$name")->write($tmpl);
}
