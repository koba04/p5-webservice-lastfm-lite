use inc::Module::Install;
name 'WebService-LastFM-Lite';
all_from 'lib/WebService/LastFM/Lite.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
