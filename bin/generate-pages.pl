#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;
use IO::All;
use File::Basename qw/ basename /;

my ($target) = @ARGV;

{
    htmlpages => \&html,
    manpages => \&man,
    ghpages => \&ghpages,
}->{ $target }->();

sub man {
    my @txt_files = io('txt')->all_files;

    for my $file (@txt_files) {
        my $src = $file;
        $file =~ s/\.txt$//;
        $file =~ s{^txt/}{};
        my $target = "man/$file.man";
        say "Generate $target";
        my $cmd = "swim  --to man '$src' > '$target'";
        system $cmd;
    }
}
sub html {
    my @txt_files = io('txt')->all_files;

    for my $file (@txt_files) {
        my $src = $file;
        $file =~ s/\.txt$//;
        $file =~ s{^txt/}{};
        my $target = "html/$file.html";
        say "Generate $target";
        my $cmd = "swim  --to html '$src' > '$target'";
        system $cmd;
    }
}

sub ghpages {
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
}
