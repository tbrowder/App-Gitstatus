[![Actions Status](https://github.com/tbrowder/App-Gitstatus/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/App-Gitstatus/actions) [![Actions Status](https://github.com/tbrowder/App-Gitstatus/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/App-Gitstatus/actions) [![Actions Status](https://github.com/tbrowder/App-Gitstatus/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/App-Gitstatus/actions)

NAME
====

**App::Gitstatus** - Provides an installed program, `git-status-check`, to help maintain a directory of Git repositories

SYNOPSIS
========

```raku
$ git-status-check # OUTPUT: 
Usage: git-status-check <dir> [...options...]

Checks and reports details of the Git status of all directories 
under directory 'dir' which are 'dirty' (i.e, having a non-zero
Git::Status.

(Note <dir> must be the first argument entered.)

Options:
  first      - report the first directory
  last       - report the last directory
  ignore=/X/ - ignore directory names satisfying regex /X/
  select=/X/ - select directory names satisfying regex /X/
  debug
```

DESCRIPTION
===========

The installed program will be very useful for any user who has to maintain many Git repositories, especially when the user has to keep those same repositories synchronized on multiple hosts.

CREDITS
=======

A big tip of my hat to prolific Raku module author and major core developer, Elizabeth Mattijsen (AKA @lizmat) for her very useful `Git::Status` module which this module depends upon.

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2023 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

