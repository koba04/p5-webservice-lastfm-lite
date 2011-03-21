use strict;
use warnings;
use Test::More;
use Test::Exception;
use Webservice::LastFM::Lite;

my $lastfm = Webservice::LastFM::Lite->new('c18a961bca806e6d921780f53f4f9254');

my $res = $lastfm->user_top_artists('koba04');

is scalar @$res, 50, 'result count';

ok $res->[0]->{name}, 'name';

ok $res->[0]->{mbid}, 'mbid';

like $res->[0]->{playcount}, qr/^\d+$/, 'playcount';

like $res->[0]->{url}, qr{http://www\.last\.fm/music/}, 'url';

like $res->[0]->{streamable}, qr/^[0-1]$/, 'streamble';

is scalar @{$res->[0]->{image}}, 5, 'image - list count';
like $res->[0]->{image}->[0]->{'#text'}, qr{http://userserve\-ak\.last\.fm/serve/.*?\.jpg}, 'image - #text';
is $res->[0]->{image}->[0]->{size}, 'small', 'image - size';


# limit
my $limit_res = $lastfm->user_top_artists('koba04', { limit => 1});
is scalar @$limit_res, 1, 'limit';
is $res->[0]->{name}, $limit_res->[0]->{name}, 'limit name';

# page
my $page_res = $lastfm->user_top_artists('koba04', { limit => 1, page => 2});
is scalar @$page_res, 1, 'limit';
isnt $limit_res->[0]->{name}, $page_res->[0]->{name}, 'page name';

is $lastfm->user_top_artists('koba04444444'), undef, 'not found user';

done_testing;
