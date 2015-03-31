#!/usr/bin/perl
# th.pl

#Wrote this almost a decade back for a similar need. I've removed some irrelevant lines, but didn't test it. Obviously a quick-n-dirty script, but
#I hope it works for you:)

#say we have a folder with thousands of html files. Since the file browser crashes, i am looking at making a script that would do the following:
#Distribute all html files in folders, say 001, 002, 003, etc, sorted by the html files' names. Then, i would like to create an index also an html
#file, that would exist in each folder, containing links to all the folder's stored html files. Also, if possible, a general index in the parent
#folder, that would allow for a tree like showing the directories as links, and in a tree like representation, below the links of the files
#contained in each folder.



opendir(ROOT, "100");

open(OUT, ">100/index.html");
print OUT "<html><head><title>Index</title></head><body><table border=\"1\">\n";

$sfolder = '';
foreach $folder (readdir(ROOT)) {
    next if $folder=~/^\./;

    $sfolder = "100/$folder";
    opendir(DIR, $sfolder);
    print OUT "<tr><td><b>$folder</b></td></tr>";
    foreach $file (readdir(DIR)) {
        next if $file =~/^\./;
        next if $file =~/jpg/;
        next if $file =~/^Thumb/;
        $fname = $file;
        $fname =~s/\..*//;
        #print $fname, "\n";
        
        open(SFILE, "$sfolder/$file");
        @doc = <SFILE>;
        $tmpTitle = $doc[0];
        #print $tmpTitle, "\n";
        
        print OUT "<tr><td><a href=\"$folder/$file\">$tmpTitle</a><br></td></tr>\n";
        warn ".";
        close(SFILE);
    }
    close(DIR);
    print "\n";
}
print OUT "</table></body></html>";
close(OUT);