//
//  MappingKeys.h
//  musiXmatch
//
//  Created by Stefan Lage on 03/02/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

#ifndef musiXmatch_MappingKeys_h
#define musiXmatch_MappingKeys_h

/**
 *  TRACKS MAPPING KEYS
 */
#define TRACK_ID                  @"track_id"
#define TRACK_MB_ID               @"track_mbid"
#define TRACK_SPOTIFY_ID          @"track_spotify_id"
#define TRACK_SOUNDCLOUD_ID       @"track_soundcloud_id"
#define TRACK_NAME                @"track_name"
#define TRACK_LENGTH              @"track_length"
#define TRACK_HAS_LYRICS          @"has_lyrics"
#define TRACK_HAS_SUBTITLES       @"has_subtitles"
#define TRACK_LYRICS_ID           @"lyrics_id"
#define TRACK_ARTIST_ID           @"artist_id"
#define TRACK_ARTIST_NAME         @"artist_name"
#define TRACK_ALBUM_ID            @"album_id"
#define TRACK_ALBUM_NAME          @"album_name"
#define TRACK_ALBUM_COVERT_100    @"album_coverart_100x100"
#define TRACK_ALBUM_COVERT_350    @"album_coverart_350x350"
#define TRACK_ALBUM_COVERT_500    @"album_coverart_500x500"
#define TRACK_ALBUM_COVERT_800    @"album_coverart_800x800"
#define TRACK_PRIMARY_GENRE       @"primary_genres.music_genre_list.music_genre"
#define TRACK_SECONDARY_GENRE     @"secondary_genres.music_genre_list.music_genre"
#define TRACK_LIST                @"track_list.track"
/**
 *  MUSIC GENRES MAPPING KEYS
 */
#define MUSIC_GENRE_ID            @"music_genre_id"
#define MUSIC_GENRE_NAME          @"music_genre_name"
#define MUSIC_GENRE_NAME_EXTENDED @"music_genre_name_extended"
#define MUSIC_GENRE_VANITY        @"music_genre_vanity"
/**
 *  LYRICS MAPPING KEYS
 */
#define LYRICS_ID                 @"lyrics_id"
#define LYRICS_RESTRICTED         @"restricted"
#define LYRICS_BODY               @"lyrics_body"
#define LYRICS_LANGUAGE           @"lyrics_language"
#define LYRICS_COPYRIGHT          @"lyrics_copyright"
/**
 *  ARTIST MAPPING KEYS
 */
#define ARTIST_ID                 @"artist_id"
#define ARTIST_NAME               @"artist_name"
#define ARTIST_COUNTRY            @"artist_country"
#define ARTIST_RATING             @"artist_rating"
#define ARTIST_ALIAS              @"artist_alias_list.artist_alias"
#define ARTIST_LIST               @"artist_list.artist"
/**
 *  ALBUM MAPPING KEYS
 */
#define ALBUM_ID                  @"album_id"
#define ALBUM_MB_ID               @"album_mbid"
#define ALBUM_NAME                @"album_name"
#define ALBUM_RATING              @"album_rating"
#define ALBUM_RELEASE_DATE        @"album_release_date"
#define ALBUM_ARTIST_ID           @"artist_id"
#define ALBUM_ARTIST_NAME         @"artist_name"
#define ALBUM_TRACK_COUNT         @"album_track_count"
#define ALBUM_LABEL               @"album_label"
#define ALBUM_PLINE               @"album_pline"
#define ALBUM_COPYRIGHT           @"album_copyright"
#define ALBUM_COVERT_100          @"album_coverart_100x100"
#define ALBUM_COVERT_350          @"album_coverart_350x350"
#define ALBUM_COVERT_500          @"album_coverart_500x500"
#define ALBUM_COVERT_800          @"album_coverart_800x800"
#define ALBUM_PRIMARY_GENRE       @"primary_genres.music_genre_list.music_genre"
#define ALBUM_SECONDARY_GENRE     @"secondary_genres.music_genre_list.music_genre"
#define ALBUM_LIST                @"album_list.album"

/**
 *
 *  JSON KEY PATH
 *
 */

/**
 *  TRACK KEY PATH
 */
#define TRACK_JSON_KEY_PATH            @"message.body.track"
#define TRACK_LIST_JSON_KEY_PATH       @"message.body"
/**
 *  LYRICS KEY PATH
 */
#define LYRICS_JSON_KEY_PATH           @"message.body.lyrics"
/**
 *  ARTIST KEY PATH
 */
#define ARTIST_JSON_KEY_PATH           @"message.body.artist"
#define ARTIST_LIST_JSON_KEY_PATH      @"message.body"
/**
 *  ALBUM KEY PATH
 */
#define ALBUM_JSON_KEY_PATH            @"message.body.album"
#define ALBUM_LIST_JSON_KEY_PATH       @"message.body"

/**
 *
 *  CLASS KEY PATH
 *
 */
/**
 *  TRACK KEY PATH
 */
#define TRACK_ID_KEY_PATH                  @"trackId"
#define TRACK_MB_ID_KEY_PATH               @"mbId"
#define TRACK_SPOTIFY_ID_KEY_PATH          @"spotifyId"
#define TRACK_SOUNDCLOUD_ID_KEY_PATH       @"soundcloudId"
#define TRACK_NAME_KEY_PATH                @"name"
#define TRACK_LENGTH_KEY_PATH              @"length"
#define TRACK_HAS_LYRICS_KEY_PATH          @"hasLyrics"
#define TRACK_HAS_SUBTITLES_KEY_PATH       @"hasSubtitles"
#define TRACK_LYRICS_ID_KEY_PATH           @"lyricsId"
#define TRACK_ARTIST_ID_KEY_PATH           @"artistId"
#define TRACK_ARTIST_NAME_ID_KEY_PATH      @"artistName"
#define TRACK_ALBUM_ID_KEY_PATH            @"albumId"
#define TRACK_ALBUM_NAME_ID_KEY_PATH       @"albumName"
#define TRACK_ALBUM_COVERT_100_KEY_PATH    @"cover100x100"
#define TRACK_ALBUM_COVERT_350_KEY_PATH    @"cover350x350"
#define TRACK_ALBUM_COVERT_500_KEY_PATH    @"cover500x500"
#define TRACK_ALBUM_COVERT_800_KEY_PATH    @"cover800x800"
#define TRACK_PRIMARY_GENRE_KEY_PATH       @"primaryGenres"
#define TRACK_SECONDARY_GENRE_KEY_PATH     @"secondaryGenres"
#define TRACK_LIST_KEY_PATH                @"tracks"
/**
 *  MUSIC GENRE KEY PATH
 */
#define MUSIC_GENRE_ID_KEY_PATH            @"genreId"
#define MUSIC_GENRE_NAME_KEY_PATH          @"name"
#define MUSIC_GENRE_NAME_EXTENDED_KEY_PATH @"nameExtended"
#define MUSIC_GENRE_VANITY_KEY_PATH        @"vanity"
/**
 *  LYRICS KEY PATH
 */
#define LYRICS_ID_KEY_PATH                 @"lyricsId"
#define LYRICS_RESTRICTED_KEY_PATH         @"restricted"
#define LYRICS_BODY_KEY_PATH               @"body"
#define LYRICS_LANGUAGE_KEY_PATH           @"language"
#define LYRICS_COPYRIGHT_KEY_PATH          @"copyright"
/**
 *  ARTIST KEY PATH
 */
#define ARTIST_ID_KEY_PATH                 @"artistId"
#define ARTIST_NAME_KEY_PATH               @"name"
#define ARTIST_COUNTRY_KEY_PATH            @"country"
#define ARTIST_RATING_KEY_PATH             @"rating"
#define ARTIST_ALIAS_KEY_PATH              @"alias"
#define ARTIST_LIST_KEY_PATH               @"artists"
/**
 *  ALBUM KEY PATH
 */
#define ALBUM_ID_KEY_PATH                  @"albumId"
#define ALBUM_MB_ID_KEY_PATH               @"albumMbId"
#define ALBUM_NAME_KEY_PATH                @"name"
#define ALBUM_RATING_KEY_PATH              @"rating"
#define ALBUM_ARTIST_ID_KEY_PATH           @"artistId"
#define ALBUM_ARTIST_NAME_KEY_PATH         @"artistName"
#define ALBUM_TRACK_COUNT_KEY_PATH         @"trackCount"
#define ALBUM_LABEL_KEY_PATH               @"albumLabel"
#define ALBUM_RELEASE_DATE_KEY_PATH        @"releaseDate"
#define ALBUM_PLINE_KEY_PATH               @"pline"
#define ALBUM_COPYRIGHT_KEY_PATH           @"copyright"
#define ALBUM_COVERT_100_KEY_PATH          @"cover100x100"
#define ALBUM_COVERT_350_KEY_PATH          @"cover350x350"
#define ALBUM_COVERT_500_KEY_PATH          @"cover500x500"
#define ALBUM_COVERT_800_KEY_PATH          @"cover800x800"
#define ALBUM_PRIMARY_GENRE_KEY_PATH       @"primaryGenres"
#define ALBUM_SECONDARY_GENRE_KEY_PATH     @"secondaryGenres"
#define ALBUM_LIST_KEY_PATH                @"albums"

#endif
