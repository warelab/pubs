#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 1.02;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'WarePubs';
all_from 'lib/WarePubs.pm';

requires 'Catalyst::Runtime' => '5.90030';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Controller::REST';
requires 'Catalyst::View::JSON';
requires 'Catalyst::Model::DBIC::Schema';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Restarter';
requires 'Catalyst::View::TT';
requires 'Catalyst::View::Download::CSV';
requires 'Moose';
requires 'MooseX::MarkAsMethods';
requires 'namespace::autoclean';
requires 'String::Trim';
requires 'YAML::XS';

test_requires 'Test::More' => '0.88';

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
