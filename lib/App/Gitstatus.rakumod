unit module App::Gitstatus;

use File::Find;
use Git::Status;

sub run-program($dir, @*ARGS) is export {

my $debug   = 0;
my $details = 0;
my $all     = 0;
my $first   = 0;
my $last    = 0;
my $ignore  = 0;
my $select  = 0;
my $regex;

for @*ARGS {
    when /^d/ { ++$debug             }
    when /^a/ { ++$all;   ++$details }
    when /^f/ { ++$first; ++$details }
    when /^l/ { ++$last;  ++$details }
    when /^i[gnore]? '=/' (\N+) '/' $/ {
        $regex = ~$0;
        ++$ignore; ++$details;
    }
    when /^s[elect]? '=/' (\N+) '/' $/ {
        $regex = ~$0;
        ++$select; ++$details;
    }
    default {
        die  "FATAL: Unknown arg '$_'";
    }
}

if $debug {
   say "DEBUG: regex = '$regex'";
}

my @search-dirs;
my @dirs;
if $select {
   @search-dirs = find :$dir, :type('dir'), :name(/<$regex>/);
}
elsif $ignore {
   @search-dirs = find :$dir, :type('dir'), :exclude(/<$regex>/);
}
else {
   @search-dirs = find :$dir, :type('dir');
}

if $first and @search-dirs {
   @dirs.push: @search-dirs.head;
}
elsif $last and @search-dirs  {
   @dirs.push: @search-dirs.tail;
}
else {
   @dirs = @search-dirs;
}

my $nd = @dirs.elems;
if not $nd {
   say "Found $nd directories under directory '$dir'.";
   exit;
}

my $ndirty-gitdirs = 0;
my @dirty;
for @dirs -> $d {
    next unless "$d/.git".IO.d;
    my $gs = Git::Status.new: :directory($d);
    # possible results
    my @add     = $gs.added;
    my @del     = $gs.deleted;
    my @mod     = $gs.modified;
    my @untrack = $gs.untracked;
    if $gs.gist {
        @dirty.push: $d;
        ++$ndirty-gitdirs;
        next unless $details;

        say "  Found git repo at dir '$d'";
        say "    added    : $_" for @add;
        say "    deleted  : $_" for @del;
        say "    modified : $_" for @mod;
        say "    untracked: $_" for @untrack;
        say "    directory is dirty";
    }
}
if not $ndirty-gitdirs {
     say "All directories are clean repos";
}
else {
     say "Found $ndirty-gitdirs dirty git repos:";
     say "  $_" for @dirty;
}

}
