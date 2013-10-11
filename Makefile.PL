use inc::Module::Install;

# Define metadata
name           'WarePubs';
author         'Jim & Ken';
version        '0.01';
license        'MIT';
perl_version   '5.010';

# Specific dependencies
requires       'Mojolicious'                     => '4.42';
requires       'Mojolicious::Plugin::TtRenderer' => 0;
requires       'Mojolicious::Plugin::YamlConfig' => 0;
requires       'JSON::XS'                        => '2.33';
requires       'Moose'                           => '2.0604';
requires       'MooseX::NonMoose'                => '0.22';
requires       'MooseX::MarkAsMethods'           => '0.15';
requires       'String::Trim'                    => '0.005';
test_requires  'Test::More'                      => '0.98';

WriteAll;
