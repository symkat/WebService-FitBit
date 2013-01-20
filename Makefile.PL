#!/usr/bin/perl
use warnings;
use strict;
use inc::Module::Install;

name            'WebService-FitBit';
all_from        'lib/WebService/FitBit.pm';
license         'perl';

requires        'LWP::Authen::OAuth'    => '1.01';
