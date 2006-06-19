#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 2;
use Test::LongString;

use_ok("CSS::Squish");

my $expected_result = <<'EOT';


/**
  * From t/css/02-edge-cases.css: @import "blam.css" print;
  */

@media print {
Blam!
}

/** End of blam.css */


/**
  * From t/css/02-edge-cases.css: @import "blam.css";
  */

Blam!

/** End of blam.css */


/**
  * From t/css/02-edge-cases.css: @import url( "foo.css") print,aural;
  */

@media print,aural {
foo1
}

/** End of foo.css */


/**
  * From t/css/02-edge-cases.css: @import url(foo2.css ) print, aural, tty;
  */

@media print, aural, tty {
foo2
}

/** End of foo2.css */

/* WARNING: Unable to find import 'failure.css' */
@import 'failure.css' print;

fjkls
 jk
 
@import url("foo.css");

last
EOT

my $result = CSS::Squish->concatenate('t/css/02-edge-cases.css');

is_string($result, $expected_result, "Edge cases");

