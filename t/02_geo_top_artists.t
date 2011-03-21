use strict;
use warnings;
use Test::More;
use Test::Exception;
use Webservice::LastFM::Lite;

my $lastfm = Webservice::LastFM::Lite->new('c18a961bca806e6d921780f53f4f9254');

my $res = $lastfm->geo_top_artists('japan');

is(scalar @$res, 50, 'result count');

ok($res->[0]->{name}, 'name');

ok($res->[0]->{mbid}, 'mbid');

like($res->[0]->{listeners}, qr/^\d+$/, 'listeners');

like($res->[0]->{url}, qr{http://www\.last\.fm/music/}, 'url');

like($res->[0]->{streamable}, qr/^[0-1]$/, 'streamble');

is(scalar @{$res->[0]->{image}}, 5, 'image - list count');
like($res->[0]->{image}->[0]->{'#text'}, qr{http://userserve\-ak\.last\.fm/serve/.*?\.jpg}, 'image - #text');
is($res->[0]->{image}->[0]->{size}, 'small', 'image - size');

is $lastfm->geo_top_artists('no country'), undef, 'not found country';

done_testing;
