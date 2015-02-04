//
//  musiXmatchAPI.h
//  musiXmatch
//
//  Created by Stefan Lage on 30/01/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>

// Project
#import "mXmTrack.h"
#import "mXmAlbum.h"
#import "mXmArtist.h"
#import "mXmLyrics.h"

@interface musiXmatchAPI : NSObject

+(instancetype)sharedInstance;

/**
 *  TRACKS
 */
/**
 *  Get a track info from musiXmatch database.
 *  Call the block "completion" when it's done and passing to it the track found or a nil otherwise it passed an error.
 *
 *  @param trackId      the musiXmatch track id
 *  @param dependencies load all track dependencies (lyrics and artist)
 *  @param completion   block executed when the track is loaded or not
 */
-(void)getTrackWithId:(NSNumber*)trackId withDependencies:(BOOL)dependencies completion:(void(^)(mXmTrack* track, NSError* error))completion;

/**
 *  Search for a track in musiXmatch database.
 *  Call the block "completion" when it's done and passing to it a tracks list corresponding to the search or a nil otherwise it passed an error.
 *
 *  @param title      song's title
 *  @param artist     song's artist
 *  @param hasLyrics  filter only tracks with lyrics
 *  @param dependencies load all track dependencies (lyrics, artist and album)
 *  @param completion block executed when the track is loaded or not
 */
-(void)searchTrackWithTitle:(NSString*)title artist:(NSString*)artist hasLyrics:(BOOL)hasLyrics withDependencies:(BOOL)dependencies completion:(void(^)(NSArray* tracks, NSError* error))completion;

/**
 *  Provides the list of the top songs of a given country.
 *  Call the block "completion" when it's done and passing to it a list of tracks corresponding to the trends of the concerned country or a nil otherwise it passed an error.
 *
 *  @param country    country code (for instance: "US")
 *  @param limit      limit the number of results
 *  @param hasLyrics  filter only tracks with lyrics
 *  @param dependencies load all track dependencies (lyrics, artist and album)
 *  @param completion block executed when the track is loaded or not
 */
-(void)getTrendingTracksInCountry:(NSString*)country limitResult:(NSNumber*)limit hasLyrics:(BOOL)hasLyrics withDependencies:(BOOL)dependencies completion:(void(^)(NSArray* tracks, NSError* error))completion;

/**
 *  LYRICS
 */
/**
 *  Get the lyrics for track based on title and artist.
 *  Call the block "completion" when it's done and passing to it the lyrics found or a nil otherwise it passed an error.
 *
 *  @param track      song's title
 *  @param artist     song's artist
 *  @param completion block executed when the lyrics is loaded or not
 */
-(void)searchLyricsWithTrackName:(NSString*)track artist:(NSString*)artist completion:(void(^)(mXmLyrics* lyrics, NSError* error))completion;

/**
 *  Get the lyrics of a track.
 *  Call the block "completion" when it's done and passing to it the lyrics found or a nil otherwise it passed an error.
 *
 *  @param trackId    the musiXmatch track id
 *  @param completion block executed when the lyrics is loaded or not
 */
-(void)getLyricsWithTrackId:(NSNumber*)trackId completion:(void(^)(mXmLyrics* lyrics, NSError* error))completion;

/**
 *  ARTISTS
 */
/**
 *  Get the artist info from musiXmatch database
 *  Call the block "completion" when it's done and passing to it the artist found or a nil otherwise it passed an error.
 *
 *  @param artistId   the musiXmatch artist id
 *  @param completion block executed when the artist is loaded or not
 */
-(void)getArtistWithId:(NSNumber*)artistId completion:(void(^)(mXmArtist* artist, NSError* error))completion;
/**
 *  Search for artists in musiXmatch database
 *  Call the block "completion" when it's done and passing to it a list of artists corresponding to the search or a nil otherwise it passed an error.
 *
 *  @param name       artiste name
 *  @param limit      limit the number of results
 *  @param completion block executed when the artists list is loaded or not
 */
-(void)searchArtistWithName:(NSString*)name limitResult:(NSNumber*)limit completion:(void(^)(NSArray* artists, NSError* error))completion;
/**
 *  Provides the list of the top artists of a given country.
 *  Call the block "completion" when it's done and passing to it a list of artists corresponding to the trends of the concerned country or a nil otherwise it passed an error.
 *
 *  @param country    country code (for instance: "US")
 *  @param limit    limit the number of results
 *  @param completion block executed when the artists list is loaded or not
 */
-(void)getTrendingArtistsInCountry:(NSString*)country limitResult:(NSNumber*)limit completion:(void(^)(NSArray* artists, NSError* error))completion;
/**
 *  Get the album discography of an artist
 *  Call the block "completion" when it's done and passing to it a list of albums of the concerned artist or a nil otherwise it passed an error.
 *
 *  @param artistId   the musiXmatch artist id
 *  @param dependencies load all album dependencies (artist)
 *  @param completion block executed when the discography is loaded or not
 */
-(void)getArtistAlbums:(NSNumber*)artistId withDependencies:(BOOL)dependencies completion:(void(^)(NSArray* albums, NSError* error))completion;
/**
 *  Get a list of artists somehow related to a given one
 *  Call the block "completion" when it's done and passing to it a list of artists corresponding to related to a specific one or a nil otherwise it passed an error.
 *
 *  @param artistId   the musiXmatch artist id
 *  @param limit      limit the number of results
 *  @param completion block executed when the artists list is loaded or not
 */
-(void)getArtistRelatedTo:(NSNumber*)artistId limitResult:(NSNumber*)limit completion:(void(^)(NSArray* artists, NSError* error))completion;

/**
 *  ALBUMS
 */
/**
 *  Get an album from musiXmatch database
 *  Call the block "completion" when it's done and passing to it the album found or a nil otherwise it passed an error.
 *
 *  @param albumId    the musiXmatch album id
 *  @param dependencies get the artist data
 *  @param completion block executed when the album is loaded or not
 */
-(void)getAlbumWithId:(NSNumber*)albumId withDependencies:(BOOL)dependencies completion:(void(^)(mXmAlbum* album, NSError* error))completion;

/**
 *  Provides the list of the songs of an album
 *  Call the block "completion" when it's done and passing to it a tracks list corresponding to all tracks in the concerned album or a nil otherwise it passed an error.
 *
 *  @param albumId    the musiXmatch album id
 *  @param dependencies load all track dependencies (lyrics, artist and album)
 *  @param completion block executed when the track is loaded or not
 */
-(void)getAlbumTracks:(NSNumber*)albumId hasLyrics:(BOOL)hasLyrics withDependencies:(BOOL)dependencies completion:(void(^)(NSArray* tracks, NSError* error))completion;

@end
