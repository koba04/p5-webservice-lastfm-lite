use strict;
use warnings;
use Test::More;
use Test::Exception;
use Webservice::LastFM::Lite;

my $lastfm = Webservice::LastFM::Lite->new('c18a961bca806e6d921780f53f4f9254');

my $res = $lastfm->artist_top_tracks('Radiohead');

is(scalar @$res, 50, 'result count');

ok($res->[0]->{name}, 'name');

like($res->[0]->{playcount}, qr/^\d+$/, 'playcount');
like($res->[0]->{url}, qr{http://www\.last\.fm/music/}, 'url');

is(scalar @{$res->[0]->{image}}, 4, 'image - list count');
like($res->[0]->{image}->[0]->{'#text'}, qr{http://userserve\-ak\.last\.fm/serve/.*?\.png}, 'image - #text');
is($res->[0]->{image}->[0]->{size}, 'small', 'image - size');

is $res->[0]->{artist}->{name}, 'Radiohead', 'artist';

is $lastfm->artist_top_tracks('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'), undef, 'not found artist';

done_testing;
