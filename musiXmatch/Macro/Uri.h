//
//  Uri.h
//  musiXmatch
//
//  Created by Stefan Lage on 03/02/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

#ifndef musiXmatch_Uri_h
#define musiXmatch_Uri_h

#define mXm_BASE_URL @"http://api.musixmatch.com"

/**
 *  TRACK URI
 */
#define URI_TRACK_GET @"/ws/1.1/track.get"
#define URI_TRACK_SEARCH @"/ws/1.1/track.search"
#define URI_CHART_TRACK_GET @"/ws/1.1/chart.tracks.get"
/**
 *  LYRICS URI
 */
#define URI_LYRICS_GET @"/ws/1.1/track.lyrics.get"
#define URI_LYRICS_MATCHER @"/ws/1.1/matcher.lyrics.get"
/**
 *  ARTIST URI
 */
#define URI_ARTIST_GET @"/ws/1.1/artist.get"
#define URI_ARTIST_SEARCH @"/ws/1.1/artist.search"
#define URI_CHART_ARTIST_GET @"/ws/1.1/chart.artists.get"
#define URI_ARTIST_RELATED @"/ws/1.1/artist.related.get"
/**
 *  ALBUM URI
 */
#define URI_ALBUM_GET @"/ws/1.1/album.get"
#define URI_ALBUM_TRACKS_GET @"/ws/1.1/album.tracks.get"
#define URI_ARTIST_ALBUM_GET @"/ws/1.1/artist.albums.get"

/**
 *  ARGUMENTS
 */
#define ARG_API_KEY @"apikey"
#define ARG_FORMAT @"format"
#define ARG_TRACK_ID @"track_id"
#define ARG_Q_TRACK @"q_track"
#define ARG_Q_ARTIST @"q_artist"
#define ARG_HAS_LYRICS @"f_has_lyrics"
#define ARG_COUNTRY @"country"
#define ARG_PAGE_SIZE @"page_size"
#define ARG_ARTIST_ID @"artist_id"
#define ARG_RELEASE_DATE @"s_release_date"
#define ARG_ALBUM_ID @"album_id"
#define ARG_ALBUM_NAME @"g_album_name"

#define ARG_JSON_FORMAT @"json"

#endif
