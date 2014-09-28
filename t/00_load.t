#!/usr/bin/env perl
 
use warnings;
use strict;
use File::Find::Rule;
use Test::More;
 
# If you don't want your module tested for compile-time
# error, add it to @skip_modules.  Have a good reason!
my @skip_modules = qw / /;
 
my @modules = File::Find::Rule->file->name('*.pm')->in('lib');
 
for my $module (@modules) {
    s/lib\///, s/\.pm//, s/\//::/g for $module;
    next if grep { $_ eq $module } @skip_modules;
    use_ok($module);
}
 
done_testing();
