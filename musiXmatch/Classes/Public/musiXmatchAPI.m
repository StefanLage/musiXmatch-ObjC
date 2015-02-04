//
//  musiXmatchAPI.m
//  musiXmatch
//
//  Created by Stefan Lage on 30/01/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

#import "musiXmatchAPI.h"
// External
#import <RestKit/RestKit.h>
// Project
#import "mXmSearchTrack.h"
#import "mXmSearchArtist.h"
#import "mXmMusicGenre.h"
#import "mXmArtistAlbums.h"
#import "mXmJsonSerialization.h"
// Macros
#import "Macros.h"

// Developer's API KEY
#define musiXmatchiApiKey   ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"musiXmatchApiKey"])?[[NSBundle mainBundle] objectForInfoDictionaryKey:@"musiXmatchApiKey"]:@""

@interface musiXmatchAPI()

@property (nonatomic, strong) RKObjectManager *objectManager;
@property (nonatomic, strong) RKObjectMapping *musicGenreMapping;
@property (nonatomic, strong) RKObjectMapping *trackMapping;
@property (nonatomic, strong) RKObjectMapping *searchTrackMapping;

@end

@implementation musiXmatchAPI

+(instancetype)sharedInstance{
    static musiXmatchAPI* sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [musiXmatchAPI new];
    });
    return sharedObject;
}

-(id)init{
    self = [super init];
    if(self){
        [self initRestKit];
    }
    return self;
}

- (void)dealloc
{
    // implement -dealloc & remove abort() when refactoring for
    // non-singleton use.
    abort();
}

#pragma mark - Accessors

-(RKObjectMapping *)musicGenreMapping{
    if(!_musicGenreMapping){
        _musicGenreMapping = [RKObjectMapping mappingForClass:[mXmMusicGenre class]];
        [_musicGenreMapping addAttributeMappingsFromDictionary:@{
                                                                 MUSIC_GENRE_ID: MUSIC_GENRE_ID_KEY_PATH,
                                                                 MUSIC_GENRE_NAME: MUSIC_GENRE_NAME_KEY_PATH,
                                                                 MUSIC_GENRE_NAME_EXTENDED: MUSIC_GENRE_NAME_EXTENDED_KEY_PATH,
                                                                 MUSIC_GENRE_VANITY: MUSIC_GENRE_VANITY_KEY_PATH
                                                                 }];
    }
    return _musicGenreMapping;
}

-(RKObjectMapping *)trackMapping{
    if(!_trackMapping){
        _trackMapping = [RKObjectMapping mappingForClass:[mXmTrack class]];
        [_trackMapping addAttributeMappingsFromDictionary:@{
                                                            TRACK_ID: TRACK_ID_KEY_PATH,
                                                            TRACK_MB_ID: TRACK_MB_ID_KEY_PATH,
                                                            TRACK_SPOTIFY_ID: TRACK_SPOTIFY_ID_KEY_PATH,
                                                            TRACK_SOUNDCLOUD_ID: TRACK_SOUNDCLOUD_ID_KEY_PATH,
                                                            TRACK_NAME: TRACK_NAME_KEY_PATH,
                                                            TRACK_LENGTH: TRACK_LENGTH_KEY_PATH,
                                                            TRACK_HAS_LYRICS: TRACK_HAS_LYRICS_KEY_PATH,
                                                            TRACK_HAS_SUBTITLES: TRACK_HAS_SUBTITLES_KEY_PATH,
                                                            TRACK_LYRICS_ID: TRACK_LYRICS_ID_KEY_PATH,
                                                            TRACK_ARTIST_ID: TRACK_ARTIST_ID_KEY_PATH,
                                                            TRACK_ARTIST_NAME: TRACK_ARTIST_NAME_ID_KEY_PATH,
                                                            TRACK_ALBUM_ID: TRACK_ALBUM_ID_KEY_PATH,
                                                            TRACK_ALBUM_NAME: TRACK_ALBUM_NAME_ID_KEY_PATH,
                                                            TRACK_ALBUM_COVERT_100: TRACK_ALBUM_COVERT_100_KEY_PATH,
                                                            TRACK_ALBUM_COVERT_350: TRACK_ALBUM_COVERT_350_KEY_PATH,
                                                            TRACK_ALBUM_COVERT_500: TRACK_ALBUM_COVERT_500_KEY_PATH,
                                                            TRACK_ALBUM_COVERT_800: TRACK_ALBUM_COVERT_800_KEY_PATH
                                                            }];
        
        [_trackMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:TRACK_PRIMARY_GENRE
                                                                                      toKeyPath:TRACK_PRIMARY_GENRE_KEY_PATH
                                                                                    withMapping:self.musicGenreMapping]];
        [_trackMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:TRACK_SECONDARY_GENRE
                                                                                      toKeyPath:TRACK_SECONDARY_GENRE_KEY_PATH
                                                                                    withMapping:self.musicGenreMapping]];
    }
    return _trackMapping;
}

-(RKObjectMapping*)searchTrackMapping{
    if(!_searchTrackMapping){
        _searchTrackMapping = [RKObjectMapping mappingForClass:[mXmSearchTrack class]];
        [_searchTrackMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:TRACK_LIST
                                                                                            toKeyPath:TRACK_LIST_KEY_PATH
                                                                                          withMapping:self.trackMapping]];
    }
    return _searchTrackMapping;
}

#pragma mark - RestKit

-(void)initRestKit{
    //RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    NSURL *baseURL           = [NSURL URLWithString:mXm_BASE_URL];
    AFHTTPClient *httpclient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    // initialize RestKit
    _objectManager           = [[RKObjectManager alloc] initWithHTTPClient:httpclient];
    [RKMIMETypeSerialization registerClass:[mXmJsonSerialization class]
                               forMIMEType:@"text/plain"];
    // Init tracks mapping
    [self  setTracksMapping];
    // Init lyrics mapping
    [self setLyricsMapping];
    // Init artists mapping
    [self setArtistMapping];
    // Init albums mapping
    [self setAlbumMapping];
}

/**
 *  Tracks
 *  Set the mapping objects for the following requests:
 *      - track.get
 *      - track.search
 *      - chart.tracks.get
 */
-(void)setTracksMapping{
    // track.get
    RKObjectMapping* trackMapping    = self.trackMapping;
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:trackMapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:URI_TRACK_GET
                                                                                   keyPath:TRACK_JSON_KEY_PATH
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [self.objectManager addResponseDescriptor:descriptor];
    // track.search
    RKObjectMapping* searchTrackMapping = self.searchTrackMapping;
    descriptor                          = [RKResponseDescriptor responseDescriptorWithMapping:searchTrackMapping
                                                                                       method:RKRequestMethodGET
                                                                                  pathPattern:URI_TRACK_SEARCH
                                                                                      keyPath:TRACK_LIST_JSON_KEY_PATH
                                                                                  statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:descriptor];
    // chart.tracks.get
    descriptor = [RKResponseDescriptor responseDescriptorWithMapping:searchTrackMapping
                                                              method:RKRequestMethodGET
                                                         pathPattern:URI_CHART_TRACK_GET
                                                             keyPath:TRACK_LIST_JSON_KEY_PATH
                                                         statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:descriptor];
}

/**
 *  Lyrics
 *  Set the mapping objects for the following requests:
 *      - track.lyrics.get
 *      - matcher.lyrics.get
 */
-(void)setLyricsMapping{
    // track.lyrics.get
    RKObjectMapping* lyricsMapping = [RKObjectMapping mappingForClass:[mXmLyrics class]];
    [lyricsMapping addAttributeMappingsFromDictionary:@{
                                                        LYRICS_ID: LYRICS_ID_KEY_PATH,
                                                        LYRICS_RESTRICTED: LYRICS_RESTRICTED_KEY_PATH,
                                                        LYRICS_BODY: LYRICS_BODY_KEY_PATH,
                                                        LYRICS_LANGUAGE: LYRICS_LANGUAGE_KEY_PATH,
                                                        LYRICS_COPYRIGHT: LYRICS_COPYRIGHT_KEY_PATH
                                                        }];
    RKResponseDescriptor* descriptor = [RKResponseDescriptor responseDescriptorWithMapping:lyricsMapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:URI_LYRICS_GET
                                                                                   keyPath:LYRICS_JSON_KEY_PATH
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:descriptor];
    // matcher.lyrics.get
    descriptor = [RKResponseDescriptor responseDescriptorWithMapping:lyricsMapping
                                                              method:RKRequestMethodGET
                                                         pathPattern:URI_LYRICS_MATCHER
                                                             keyPath:LYRICS_JSON_KEY_PATH
                                                         statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:descriptor];
}

/**
 *  Artists
 *  Set the mapping objects for the following requests:
 *      - artist.get
 *      - artist.search
 *      - chart.artists.get
 *      - artist.related.get
 */
-(void)setArtistMapping{
    // artist.get
    RKObjectMapping* artistMapping = [RKObjectMapping mappingForClass:[mXmArtist class]];
    [artistMapping addAttributeMappingsFromDictionary:@{
                                                        ARTIST_ID: ARTIST_ID_KEY_PATH,
                                                        ARTIST_NAME: ARTIST_NAME_KEY_PATH,
                                                        ARTIST_COUNTRY: ARTIST_COUNTRY_KEY_PATH,
                                                        ARTIST_RATING: ARTIST_RATING_KEY_PATH,
                                                        ARTIST_ALIAS: ARTIST_ALIAS_KEY_PATH
                                                        }];
    RKObjectMapping* searchArtistMapping = [RKObjectMapping mappingForClass:[mXmSearchArtist class]];
    [searchArtistMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:ARTIST_LIST
                                                                                        toKeyPath:ARTIST_LIST_KEY_PATH
                                                                                      withMapping:artistMapping]];
    
    RKResponseDescriptor* descriptor = [RKResponseDescriptor responseDescriptorWithMapping:artistMapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:URI_ARTIST_GET
                                                                                   keyPath:ARTIST_JSON_KEY_PATH
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:descriptor];
    
    // artist.search
    descriptor = [RKResponseDescriptor responseDescriptorWithMapping:searchArtistMapping
                                                              method:RKRequestMethodGET
                                                         pathPattern:URI_ARTIST_SEARCH
                                                             keyPath:ARTIST_LIST_JSON_KEY_PATH
                                                         statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:descriptor];
    
    // chart.artists.get
    descriptor = [RKResponseDescriptor responseDescriptorWithMapping:searchArtistMapping
                                                              method:RKRequestMethodGET
                                                         pathPattern:URI_CHART_ARTIST_GET
                                                             keyPath:ARTIST_LIST_JSON_KEY_PATH
                                                         statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:descriptor];
    // artist.related.get
    descriptor = [RKResponseDescriptor responseDescriptorWithMapping:searchArtistMapping
                                                              method:RKRequestMethodGET
                                                         pathPattern:URI_ARTIST_RELATED
                                                             keyPath:ARTIST_LIST_JSON_KEY_PATH
                                                         statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:descriptor];
}

/**
 *  Albums
 *  Set the mapping objects for the following requests:
 *      - album.get
 *      - album.tracks.get
 *      - artist.albums.get
 */
-(void) setAlbumMapping{
    // album.get
    RKObjectMapping* musicGenreMapping = self.musicGenreMapping;
    RKObjectMapping* albumMapping      = [RKObjectMapping mappingForClass:[mXmAlbum class]];
    [albumMapping addAttributeMappingsFromDictionary:@{
                                                       ALBUM_ID: ALBUM_ID_KEY_PATH,
                                                       ALBUM_MB_ID: ALBUM_MB_ID_KEY_PATH,
                                                       ALBUM_NAME: ALBUM_NAME_KEY_PATH,
                                                       ALBUM_RATING: ALBUM_RATING_KEY_PATH,
                                                       ALBUM_ARTIST_ID: ALBUM_ARTIST_ID_KEY_PATH,
                                                       ALBUM_ARTIST_NAME: ALBUM_ARTIST_NAME_KEY_PATH,
                                                       ALBUM_TRACK_COUNT: ALBUM_TRACK_COUNT_KEY_PATH,
                                                       ALBUM_LABEL: ALBUM_LABEL_KEY_PATH,
                                                       ALBUM_PLINE: ALBUM_PLINE_KEY_PATH,
                                                       ALBUM_COPYRIGHT: ALBUM_COPYRIGHT_KEY_PATH,
                                                       ALBUM_COVERT_100: ALBUM_COVERT_100_KEY_PATH,
                                                       ALBUM_COVERT_350: ALBUM_COVERT_350_KEY_PATH,
                                                       ALBUM_COVERT_500: ALBUM_COVERT_500_KEY_PATH,
                                                       ALBUM_COVERT_800: ALBUM_COVERT_800_KEY_PATH
                                                       }];
    [albumMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:ALBUM_PRIMARY_GENRE
                                                                                 toKeyPath:ALBUM_PRIMARY_GENRE_KEY_PATH
                                                                               withMapping:musicGenreMapping]];
    [albumMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:ALBUM_SECONDARY_GENRE
                                                                                 toKeyPath:ALBUM_SECONDARY_GENRE_KEY_PATH
                                                                               withMapping:musicGenreMapping]];
    RKResponseDescriptor* descriptor = [RKResponseDescriptor responseDescriptorWithMapping:albumMapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:URI_ALBUM_GET
                                                                                   keyPath:ALBUM_JSON_KEY_PATH
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:descriptor];
    
    // album.tracks.get
    RKObjectMapping* searchTrackMapping = self.searchTrackMapping;
    descriptor                          = [RKResponseDescriptor responseDescriptorWithMapping:searchTrackMapping
                                                                                       method:RKRequestMethodGET
                                                                                  pathPattern:URI_ALBUM_TRACKS_GET
                                                                                      keyPath:ALBUM_LIST_JSON_KEY_PATH
                                                                                  statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:descriptor];
    
    // artist.albums.get
    RKObjectMapping* artistAlbumsMapping = [RKObjectMapping mappingForClass:[mXmArtistAlbums class]];
    [artistAlbumsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:ALBUM_LIST
                                                                                        toKeyPath:ALBUM_LIST_KEY_PATH
                                                                                      withMapping:albumMapping]];
    descriptor = [RKResponseDescriptor responseDescriptorWithMapping:artistAlbumsMapping
                                                              method:RKRequestMethodGET
                                                         pathPattern:URI_ARTIST_ALBUM_GET
                                                             keyPath:ALBUM_LIST_JSON_KEY_PATH
                                                         statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:descriptor];
}

#pragma mark - Internal methods

/**
 *  Generic method to request the server to get wanted datas
 *
 *  @param request    URI of the request
 *  @param params     all parameters needed to pass to the request
 *  @param completion block called when all datas are loaded or not
 */
-(void)genericRequest:(NSString*)request params:(NSDictionary*)params completion:(void(^)(NSArray* obj, NSError* error))completion{
    [self.objectManager getObjectsAtPath:request
                              parameters:params
                                 success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                     completion(mappingResult.array, nil);
                                 }
                                 failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                     completion(nil, error);
                                 }];
}

#pragma mark - Internal methods
#pragma mark - Tracks

/**
 *  Request the server to get a tracks list
 *
 *  @param request      URI of the request
 *  @param params       all parameters needed to pass to the request
 *  @param dependencies inform if we need to get all track dependencies
 *  @param completion   block called when all datas are loaded or not
 */
-(void)requestForTracksList:(NSString*)request params:(NSDictionary*)params withDependencies:(BOOL)dependencies completion:(void(^)(NSArray* tracks, NSError* error))completion{
    [self genericRequest:request params:params completion:^(NSArray *results, NSError *error) {
        if(results && results.count > 0){
            mXmSearchTrack *searchTrack = results.firstObject;
            if(dependencies){
                __block int i = 0;
                // Set a TimeOut
                __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10.0f
                                                                          target:self
                                                                        selector:@selector(didTimeoutWithCompletion:)
                                                                        userInfo:@{@"completion":completion}
                                                                         repeats:NO];
                for(mXmTrack* track in searchTrack.tracks){
                    // get all dependencies
                    [self getTrackDependencies:track completion:^(BOOL value) {
                        if(value){
                            i++;
                            if(i == searchTrack.tracks.count){
                                completion(searchTrack.tracks, nil);
                                [timer invalidate];
                            }
                        }
                        else
                            // Something wrong
                            completion(nil, [NSError errorWithDomain:@"An error occured while trying to get track dependencies" code:-10 userInfo:nil]);
                    }];
                }
            }
            else
                completion(searchTrack.tracks, nil);
        }
        else
            completion(nil, error);
    }];
}

/**
 *  Get the artist and the lyrics objects of a specific track
 *
 *  @param track      the track which we need its dependencies
 *  @param completion block called when all datas are loaded or not
 */
-(void) getTrackDependencies:(mXmTrack*)track completion:(void(^)(BOOL value))completion{
    __block int i = 0;
    __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0f
                                                              target:self
                                                            selector:@selector(didTimeoutDependenciesWithCompletion:)
                                                            userInfo:@{@"completion":completion}
                                                             repeats:NO];
    // Get the artist
    [self getArtistWithId:track.artistId completion:^(mXmArtist *artist, NSError *error) {
        if(!error && artist)
            track.artist = artist;
        i++;
        if(i == 3){
            completion(YES);
            [timer invalidate];
        }
    }];
    // Get the lyrics
    [self getLyricsWithTrackId:track.trackId completion:^(mXmLyrics *lyrics, NSError *error) {
        if(!error && lyrics)
            track.lyrics = lyrics;
        i++;
        if(i == 3){
            completion(YES);
            [timer invalidate];
        }
    }];
    // Get the album
    [self getAlbumWithId:track.albumId withDependencies:YES completion:^(mXmAlbum *album, NSError *error) {
        if(!error && album)
            track.album = album;
        i++;
        if(i == 3){
            completion(YES);
            [timer invalidate];
        }
    }];
}

#pragma mark - Internal methods
#pragma mark - Artists
/**
 *  Request the server to get an artists list
 *  Call the block "completion" when it's done and passing to it the artists list if there is one or a nil value otherwise it passed an error
 *
 *  @param request    request's URI
 *  @param params     all parameters needed to pass to the request
 *  @param completion block called when all datas are loaded or not
 */
-(void)requestForArtistsList:(NSString*)request params:(NSDictionary*)params completion:(void(^)(NSArray* artist, NSError* error))completion{
    [self genericRequest:request params:params completion:^(NSArray *results, NSError *error) {
        if(results && results.count > 0){
            mXmSearchArtist *searchArtists = results.firstObject;
            completion(searchArtists.artists, nil);
        }
        else{
            completion(nil, error);
        }
    }];
}

#pragma mark - Internal methods
#pragma mark - Lyrics
/**
 *  Request the server to get a lyrics
 *  Call the block "completion" when it's done and passing to it the lyrics found or not
 *
 *  @param request    request's URI
 *  @param params     all parameters needed to pass to the request
 *  @param completion block called when all datas are loaded or not
 */
-(void)requestForLyrics:(NSString*)request params:(NSDictionary*)params completion:(void(^)(mXmLyrics* lyrics, NSError* error))completion{
    [self genericRequest:request params:params completion:^(NSArray *results, NSError *error) {
        if(results && results.count > 0){
            mXmLyrics *lyrics = results.firstObject;
            completion(lyrics, nil);
        }
        else{
            completion(nil, error);
        }
    }];
}

#pragma mark - TimeOuts

/**
 *  TimeOut when a request take too much time or if a block is locked
 *  A generic block is called and return a TimeOut error
 *
 *  @param timer
 */
- (void)didTimeoutWithCompletion:(NSTimer*)timer {
    NSError *error = [NSError errorWithDomain:@"TIMEOUT" code:-1001 userInfo:nil];
    void (^completion)(id obj, NSError* error) = timer.userInfo[@"completion"];
    completion(nil, error);
}

/**
 *  Specific TimeOut function for dependencies requests
 *
 *  @param timer
 */
- (void)didTimeoutDependenciesWithCompletion:(NSTimer*)timer {
    void (^completion)(BOOL value) = timer.userInfo[@"completion"];
    completion(NO);
}

#pragma mark - Tracks

-(void)getTrackWithId:(NSNumber*)trackId withDependencies:(BOOL)dependencies completion:(void(^)(mXmTrack* track, NSError* error))completion{
    NSDictionary *params = @{
                             ARG_API_KEY: musiXmatchiApiKey,
                             ARG_FORMAT: ARG_JSON_FORMAT,
                             ARG_TRACK_ID: (trackId)?trackId:@""
                             };
    [self genericRequest:URI_TRACK_GET params:params completion:^(NSArray *results, NSError *error) {
        if(results && results.count > 0){
            __block mXmTrack* track = results.firstObject;
            // Need to get all track dependencies ?
            if(dependencies){
                [self getTrackDependencies:track completion:^(BOOL value) {
                    if(value)
                        completion(track, nil);
                    else
                        completion(nil, [NSError errorWithDomain:@"An error occured while trying to get track dependencies" code:-10 userInfo:nil]);
                }];
            }
            else
                completion(track, nil);
        }
        else
            completion(nil, error);
    }];
}

-(void)searchTrackWithTitle:(NSString*)title artist:(NSString*)artist hasLyrics:(BOOL)hasLyrics withDependencies:(BOOL)dependencies completion:(void(^)(NSArray* tracks, NSError* error))completion{
    NSDictionary *params = @{
                             ARG_API_KEY: musiXmatchiApiKey,
                             ARG_FORMAT: ARG_JSON_FORMAT,
                             ARG_Q_TRACK: (title)?title:@"",
                             ARG_Q_ARTIST: (artist)?artist:@"",
                             ARG_HAS_LYRICS: @(hasLyrics)
                             };
    [self requestForTracksList:URI_TRACK_SEARCH
                        params:params
              withDependencies:dependencies
                    completion:completion];
}

-(void)getTrendingTracksInCountry:(NSString*)country limitResult:(NSNumber*)limit hasLyrics:(BOOL)hasLyrics withDependencies:(BOOL)dependencies completion:(void(^)(NSArray* tracks, NSError* error))completion{
    NSDictionary *params = @{
                             ARG_API_KEY: musiXmatchiApiKey,
                             ARG_COUNTRY: (country)?country:@"",
                             ARG_PAGE_SIZE: (limit)?limit:@"",
                             ARG_HAS_LYRICS: @(hasLyrics)
                             };
    [self requestForTracksList:URI_CHART_TRACK_GET
                        params:params
              withDependencies:dependencies
                    completion:completion];
}

#pragma mark - Lyrics

-(void)searchLyricsWithTrackName:(NSString*)track artist:(NSString*)artist completion:(void(^)(mXmLyrics* lyrics, NSError* error))completion{
    NSDictionary *params = @{
                             ARG_API_KEY: musiXmatchiApiKey,
                             ARG_FORMAT: ARG_JSON_FORMAT,
                             ARG_Q_TRACK: (track)?track:@"",
                             ARG_Q_ARTIST: (artist)?artist:@""
                             };
    [self requestForLyrics:URI_LYRICS_MATCHER
                    params:params
                completion:completion];
}

-(void)getLyricsWithTrackId:(NSNumber*)trackId completion:(void(^)(mXmLyrics* lyrics, NSError* error))completion{
    NSDictionary *params = @{
                             ARG_API_KEY: musiXmatchiApiKey,
                             ARG_FORMAT: ARG_JSON_FORMAT,
                             ARG_TRACK_ID: (trackId)?trackId:@""
                             };
    [self requestForLyrics:URI_LYRICS_GET
                    params:params
                completion:completion];
}

#pragma mark - Artists

-(void)getArtistWithId:(NSNumber*)artistId completion:(void(^)(mXmArtist* artist, NSError* error))completion{
    NSDictionary *params = @{
                             ARG_API_KEY: musiXmatchiApiKey,
                             ARG_FORMAT: ARG_JSON_FORMAT,
                             ARG_ARTIST_ID: (artistId)?artistId:@""
                             };
    [self genericRequest:URI_ARTIST_GET params:params completion:^(NSArray *results, NSError *error) {
        if(results && results.count > 0){
            mXmArtist *artist = results.firstObject;
            completion(artist, nil);
        }
        else
            completion(nil, nil);
    }];
}

-(void)searchArtistWithName:(NSString*)name limitResult:(NSNumber*)limit completion:(void(^)(NSArray* artists, NSError* error))completion{
    NSDictionary *params = @{
                             ARG_API_KEY: musiXmatchiApiKey,
                             ARG_FORMAT: ARG_JSON_FORMAT,
                             ARG_Q_ARTIST: (name)?name:@"",
                             ARG_PAGE_SIZE: (limit)?limit:@""
                             };
    [self requestForArtistsList:URI_ARTIST_SEARCH
                         params:params
                     completion:completion];
}

-(void)getTrendingArtistsInCountry:(NSString*)country limitResult:(NSNumber*)limit completion:(void(^)(NSArray* artists, NSError* error))completion{
    NSDictionary *params = @{
                             ARG_API_KEY: musiXmatchiApiKey,
                             ARG_FORMAT: ARG_JSON_FORMAT,
                             ARG_COUNTRY: (country)?country:@"",
                             ARG_PAGE_SIZE: (limit)?limit:@""
                             };
    [self requestForArtistsList:URI_CHART_ARTIST_GET
                         params:params
                     completion:completion];
}

-(void)getArtistRelatedTo:(NSNumber*)artistId limitResult:(NSNumber*)limit completion:(void(^)(NSArray* artists, NSError* error))completion{
    NSDictionary *params = @{
                             ARG_API_KEY: musiXmatchiApiKey,
                             ARG_FORMAT: ARG_JSON_FORMAT,
                             ARG_ARTIST_ID: (artistId)?artistId:@"",
                             ARG_PAGE_SIZE: (limit)?limit:@""
                             };
    [self requestForArtistsList:URI_ARTIST_RELATED
                         params:params
                     completion:completion];
}

#pragma mark - Album

-(void)getAlbumWithId:(NSNumber*)albumId withDependencies:(BOOL)dependencies completion:(void(^)(mXmAlbum* album, NSError* error))completion{
    NSDictionary *params = @{
                             ARG_API_KEY: musiXmatchiApiKey,
                             ARG_FORMAT: ARG_JSON_FORMAT,
                             ARG_ALBUM_ID: (albumId)?albumId:@""
                             };
    [self genericRequest:URI_ALBUM_GET params:params completion:^(NSArray *results, NSError *error) {
        if(results && results.count > 0){
            mXmAlbum *album = results.firstObject;
            if(dependencies){
                [self getArtistWithId:album.artistId completion:^(mXmArtist *artist, NSError *error) {
                    if(!error && artist)
                        album.artist = artist;
                    completion(album, nil);
                }];
            }
            else
                completion(album, nil);
        }
        else
            completion(nil, nil);
    }];
    
}

-(void)getArtistAlbums:(NSNumber*)artistId withDependencies:(BOOL)dependencies completion:(void(^)(NSArray* albums, NSError* error))completion{
    NSDictionary *params = @{
                             ARG_API_KEY: musiXmatchiApiKey,
                             ARG_FORMAT: ARG_JSON_FORMAT,
                             ARG_ARTIST_ID: (artistId)?artistId:@"",
                             ARG_PAGE_SIZE: @10,
                             ARG_RELEASE_DATE: @"desc",
                             ARG_ALBUM_NAME: @1
                             };
    [self genericRequest:URI_ARTIST_ALBUM_GET params:params completion:^(NSArray *results, NSError *error) {
        if(results && results.count > 0){
            mXmArtistAlbums *albumsList = results.firstObject;
            if(dependencies){
                __block int i = 0;
                // Set a TimeOut
                __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10.0f
                                                                          target:self
                                                                        selector:@selector(didTimeoutWithCompletion:)
                                                                        userInfo:@{@"completion":completion}
                                                                         repeats:NO];
                for(mXmAlbum *album in albumsList.albums){
                    // It should be the same artist
                    [self getArtistWithId:album.artistId completion:^(mXmArtist *artist, NSError *error) {
                        if(!error && artist)
                            album.artist = artist;
                        i++;
                        if(i == albumsList.albums.count){
                            completion(albumsList.albums, nil);
                            [timer invalidate];
                        }
                    }];
                }
            }
            else
                completion(albumsList.albums, nil);
        }
        else
            completion(nil, nil);
    }];
}

-(void)getAlbumTracks:(NSNumber*)albumId hasLyrics:(BOOL)hasLyrics withDependencies:(BOOL)dependencies completion:(void(^)(NSArray* tracks, NSError* error))completion{
    NSDictionary *params = @{
                             ARG_API_KEY: musiXmatchiApiKey,
                             ARG_FORMAT: ARG_JSON_FORMAT,
                             ARG_ALBUM_ID: (albumId)?albumId:@"",
                             ARG_HAS_LYRICS: @(hasLyrics)
                             };
    [self requestForTracksList:URI_CHART_TRACK_GET
                        params:params
              withDependencies:dependencies
                    completion:completion];
}

@end