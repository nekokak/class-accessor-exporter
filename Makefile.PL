use inc::Module::Install;
name 'Class-Accessor-Exporter';
all_from 'lib/Class/Accessor/Exporter.pm';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
