//
//  musiXmatchTests.m
//  musiXmatchTests
//
//  Created by Stefan Lage on 30/01/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "musiXmatchAPI.h"
#import "Macros.h"
#import "mXmMusicGenre.h"

@interface musiXmatchTests : XCTestCase

@end

@implementation musiXmatchTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Internal methods

-(void)setApiKey{
    [[[NSBundle mainBundle] infoDictionary] setValue:@"YOUR_API_KEY" forKey:@"musiXmatchApiKey"];
}
-(void)removeApiKey{
    [[[NSBundle mainBundle] infoDictionary] setValue:nil forKey:@"musiXmatchApiKey"];
}

/**
 *  Test the function getTrackWithId:(NSNumber*)trackId
 *                  withDependencies:(BOOL)dependencies
 *                        completion:(void(^)(mXmTrack* track, NSError* error))completion
 *
 *  @param dependencies Allow to test loading track dependencies or not
 */
- (void)getTrackWithIdWithDependencies:(BOOL)dependencies{
    __block BOOL waitingForBlock = YES;
    
    [[musiXmatchAPI sharedInstance] getTrackWithId:@15445219
                                     withDependencies:dependencies
                                           completion:^(mXmTrack *track, NSError *error) {
                                               XCTAssertNil(error, @"Should be nil");
                                               XCTAssertNotNil(track, @"Should be initialized");
                                               XCTAssertNotNil(track.name, @"Should be initialized");
                                               XCTAssertNotNil(track.length, @"Should be initialized");
                                               XCTAssertGreaterThan(track.length, @0, @"Should be greater");
                                               XCTAssertNotNil(track.lyricsId, @"Should be initialized");
                                               if(dependencies)
                                                   XCTAssertNotNil(track.lyrics, @"Should be initialized");
                                               else
                                                   XCTAssertNil(track.lyrics, @"Should be nil");
                                               XCTAssertNotNil(track.artistId, @"Should be initialized");
                                               XCTAssertNotNil(track.artistName, @"Should be initialized");
                                               if(dependencies)
                                                   XCTAssertNotNil(track.artist, @"Should be initialized");
                                               else
                                                   XCTAssertNil(track.artist, @"Should be nil");
                                               XCTAssertNotNil(track.albumId, @"Should be initialized");
                                               XCTAssertNotNil(track.albumName, @"Should be initialized");
                                               if(dependencies)
                                                   XCTAssertNotNil(track.album, @"Should be initialized");
                                               else
                                                   XCTAssertNil(track.album, @"Should be nil");
                                               XCTAssertNotNil(track.cover100x100, @"Should be initialized");
                                               XCTAssertNotNil(track.cover350x350, @"Should be initialized");
                                               XCTAssertNotNil(track.cover500x500, @"Should be initialized");
                                               XCTAssertNotNil(track.cover800x800, @"Should be initialized");
                                               XCTAssertNotNil(track.primaryGenres, @"Should be initialized");
                                               XCTAssertGreaterThan(track.primaryGenres.count, 0, @"Should be greater");
                                               XCTAssertEqual([track.primaryGenres.firstObject class], [mXmMusicGenre class], @"Should be an object of type mXmMusicGenre");
                                               XCTAssertNotNil(track.secondaryGenres, @"Should be initialized");
                                               XCTAssertGreaterThan(track.secondaryGenres.count, 0, @"Should be greater");
                                               XCTAssertEqual([track.secondaryGenres.firstObject class], [mXmMusicGenre class], @"Should be an object of type mXmMusicGenre");
                                               waitingForBlock = NO;
                                           }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

/**
 *  Test the function searchTrackWithTitle:(NSString*)title 
 *                                  artist:(NSString*)artist
 *                               hasLyrics:(BOOL)hasLyrics 
 *                        withDependencies:(BOOL)dependencies 
 *                              completion:(void(^)(NSArray* tracks, NSError* error))completion;
 *
 *  @param dependencies
 *  @param hasLyrics
 */
-(void)searchTrackWithTitle:(BOOL)dependencies hasLyrics:(BOOL)hasLyrics{
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] searchTrackWithTitle:@"back to december"
                                                     artist:nil
                                                  hasLyrics:hasLyrics
                                           withDependencies:dependencies completion:^(NSArray *tracks, NSError *error) {
                                               [self checkTracks:tracks
                                                           error:error
                                                    dependencies:dependencies
                                                       hasLyrics:hasLyrics];
                                               waitingForBlock = NO;
                                           }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

-(void)getTrendingTracks:(NSNumber*)limit dependencies:(BOOL)dependencies hasLyrics:(BOOL)hasLyrics{
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] getTrendingTracksInCountry:@"fr"
                                                      limitResult:limit
                                                        hasLyrics:hasLyrics
                                                 withDependencies:dependencies
                                                       completion:^(NSArray *tracks, NSError *error) {
                                                           [self checkTracks:tracks
                                                                       error:error
                                                                dependencies:dependencies
                                                                   hasLyrics:hasLyrics];
                                                           waitingForBlock = NO;
                                                       }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

-(void)getAlbumTracks:(BOOL)dependencies hasLyrics:(BOOL)hasLyrics{
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] getAlbumTracks:@13750844
                                            hasLyrics:hasLyrics
                                     withDependencies:dependencies
                                           completion:^(NSArray *tracks, NSError *error) {
                                               [self checkTracks:tracks
                                                           error:error
                                                    dependencies:dependencies
                                                       hasLyrics:hasLyrics];
                                               waitingForBlock = NO;
                                           }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

/**
 *  Check all tracks contains in the array "tracks"
 *
 *  @param tracks       contains all tracks
 *  @param error
 *  @param dependencies
 *  @param hasLyrics
 */
-(void)checkTracks:(NSArray*)tracks error:(NSError*)error dependencies:(BOOL)dependencies hasLyrics:(BOOL)hasLyrics{
    XCTAssertNil(error, @"Should be nil");
    XCTAssertNotNil(tracks, @"Should be initialized");
    XCTAssertGreaterThan(tracks.count, 0, @"Should be greater than 0");
    for(mXmTrack *track in tracks){
        XCTAssertNil(error, @"Should be nil");
        XCTAssertNotNil(track, @"Should be initialized");
        XCTAssertNotNil(track.name, @"Should be initialized");
        XCTAssertNotNil(track.length, @"Should be initialized");
        XCTAssertGreaterThan(track.length, @0, @"Should be greater");
        XCTAssertNotNil(track.lyricsId, @"Should be initialized");
        if(dependencies && hasLyrics)
            XCTAssertNotNil(track.lyrics, @"Should be initialized");
        else
            if(hasLyrics)
                XCTAssertNil(track.lyrics, @"Should be nil");
        XCTAssertNotNil(track.artistId, @"Should be initialized");
        XCTAssertNotNil(track.artistName, @"Should be initialized");
        if(dependencies)
            XCTAssertNotNil(track.artist, @"Should be initialized");
        else
            XCTAssertNil(track.artist, @"Should be nil");
        XCTAssertNotNil(track.albumId, @"Should be initialized");
        XCTAssertNotNil(track.albumName, @"Should be initialized");
        if(dependencies)
            XCTAssertNotNil(track.album, @"Should be initialized");
        else
            XCTAssertNil(track.album, @"Should be nil");
        XCTAssertNotNil(track.cover100x100, @"Should be initialized");
        XCTAssertNotNil(track.cover350x350, @"Should be initialized");
        XCTAssertNotNil(track.cover500x500, @"Should be initialized");
        XCTAssertNotNil(track.cover800x800, @"Should be initialized");
        XCTAssertNotNil(track.primaryGenres, @"Should be initialized");
        XCTAssertNotNil(track.secondaryGenres, @"Should be initialized");
    }
}

/**
 *  Check a lyrics
 *
 *  @param lyrics
 *  @param error
 */
-(void)checkLyrics:(mXmLyrics*)lyrics error:(NSError*)error{
    XCTAssertNil(error, @"Should be nil");
    XCTAssertNotNil(lyrics, @"Should be initialized");
    XCTAssertNotNil(lyrics.lyricsId, @"Should be initialized");
    XCTAssertNotNil(lyrics.restricted, @"Should be initialized");
    XCTAssertNotNil(lyrics.body, @"Should be initialized");
    XCTAssertNotNil(lyrics.language, @"Should be initialized");
    XCTAssertGreaterThan(lyrics.copyright.length, 0, @"Should be greater");
}

/**
 *  Check an album
 *
 *  @param artist
 *  @param error
 */
-(void)checkArtist:(mXmArtist*)artist error:(NSError*)error{
    XCTAssertNil(error, @"Should be nil");
    XCTAssertNotNil(artist, @"Should be initialized");
    XCTAssertNotNil(artist.artistId, @"Should be initialized");
    XCTAssertNotNil(artist.name, @"Should be initialized");
    XCTAssertNotNil(artist.country, @"Should be initialized");
    XCTAssertNotNil(artist.alias, @"Should be initialized");
}

-(void)checkAlbum:(mXmAlbum*)album error:(NSError*)error dependencies:(BOOL)dependencies{
    XCTAssertNil(error, @"Should be nil");
    XCTAssertNotNil(album, @"Should be initialized");
    XCTAssertNotNil(album.albumId, @"Should be initialized");
    XCTAssertNotNil(album.albumMbId, @"Should be initialized");
    //XCTAssertNotNil(album.name, @"Should be initialized");
    XCTAssertNotNil(album.rating, @"Should be initialized");
    XCTAssertNotNil(album.trackCount, @"Should be initialized");
    XCTAssertGreaterThan(album.trackCount, @0, @"Should be greater");
    XCTAssertNotNil(album.albumLabel, @"Should be initialized");
    XCTAssertNotNil(album.artistId, @"Should be initialized");
    XCTAssertNotNil(album.artistName, @"Should be initialized");
    if(dependencies){
        XCTAssertNotNil(album.artist, @"Should be initialized");
    }
    else
        XCTAssertNil(album.artist, @"Should be nil");
    XCTAssertNotNil(album.secondaryGenres, @"Should be initialized");
    XCTAssertNotNil(album.copyright, @"Should be initialized");
    XCTAssertNotNil(album.pline, @"Should be initialized");
    XCTAssertNotNil(album.cover100x100, @"Should be initialized");
    XCTAssertNotNil(album.cover350x350, @"Should be initialized");
    XCTAssertNotNil(album.cover500x500, @"Should be initialized");
    XCTAssertNotNil(album.cover800x800, @"Should be initialized");
}

#pragma mark - Tests: Tracks
/**
 *  Test to get a track with it's id but without informing about the Api Key
 */
- (void)testGetTrackWithId{
    [self removeApiKey];
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] getTrackWithId:@15445219 withDependencies:NO completion:^(mXmTrack *track, NSError *error) {
        XCTAssert(error, @"Should be set with an error description");
        XCTAssertNil(track, @"Should be nil");
        waitingForBlock = NO;
    }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

/**
 *  Test to get a track without its dependencies
 */
- (void)testGetTrackWithIdWithoutDependencies{
    // Be sure to inform an Api Key
    [self setApiKey];
    [self getTrackWithIdWithDependencies:NO];
}

/**
 *  Test to get a track with all of its dependencies
 */
- (void)testGetTrackWithIdWithDependencies{
    [self setApiKey];
    [self getTrackWithIdWithDependencies:YES];
}

// SEARCH TRACKS

-(void)testSearchTrackWithoutDependenciesWithoutLyrics{
    [self setApiKey];
    [self searchTrackWithTitle:NO hasLyrics:NO];
}

-(void)testSearchTrackWithoutDependenciesAndLyrics{
    [self setApiKey];
    [self searchTrackWithTitle:NO hasLyrics:YES];
}

-(void)testSearchTrackWithDependenciesWithoutLyrics{
    [self setApiKey];
    [self searchTrackWithTitle:YES hasLyrics:NO];
}

-(void)testSearchTrackWithDependenciesLyrics{
    [self setApiKey];
    [self searchTrackWithTitle:YES hasLyrics:YES];
}

// TRENDING

-(void)testTrendingTrackWithoutDependenciesWithoutLyrics{
    [self setApiKey];
    [self getTrendingTracks:@10 dependencies:NO hasLyrics:NO];
}

-(void)testTrendingTrackWithoutDependenciesAndLyrics{
    [self setApiKey];
    [self getTrendingTracks:@10 dependencies:NO hasLyrics:YES];
}

-(void)testTrendingTrackWithDependenciesWithoutLyrics{
    [self setApiKey];
    [self getTrendingTracks:@10 dependencies:YES hasLyrics:NO];
}

-(void)testTrendingTrackWithDependenciesLyrics{
    [self setApiKey];
    [self getTrendingTracks:@10 dependencies:YES hasLyrics:YES];
}

// ALBUMS TRACKS

-(void)testAlbumTracksWithoutDependenciesWithoutLyrics{
    [self setApiKey];
    [self getAlbumTracks:NO hasLyrics:NO];
}

-(void)testAlbumTracksWithoutDependenciesAndLyrics{
    [self setApiKey];
    [self getAlbumTracks:NO hasLyrics:YES];
}

-(void)testAlbumTracksWithDependenciesWithoutLyrics{
    [self setApiKey];
    [self getAlbumTracks:YES hasLyrics:NO];
}

-(void)testAlbumTracksWithDependenciesLyrics{
    [self setApiKey];
    [self getAlbumTracks:YES hasLyrics:YES];
}

#pragma mark - Tests: Lyrics
-(void)testGetLyricsTrackId{
    [self setApiKey];
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] getLyricsWithTrackId:@15953433
                                                 completion:^(mXmLyrics *lyrics, NSError *error) {
                                                     [self checkLyrics:lyrics
                                                                 error:error];
                                                     waitingForBlock = NO;
                                                 }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

-(void)testGetLyricsWithoutArtist{
    [self setApiKey];
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] searchLyricsWithTrackName:@"champagne shower"
                                                          artist:nil
                                                      completion:^(mXmLyrics *lyrics, NSError *error) {
                                                          XCTAssert(error, @"Should be set with an error description");
                                                          XCTAssertNil(lyrics, @"Should be nil");
                                                          waitingForBlock = NO;
                                                      }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

-(void)testGetLyricsTrackName{
    [self setApiKey];
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] searchLyricsWithTrackName:@"champagne shower"
                                                          artist:@"lmfao"
                                                      completion:^(mXmLyrics *lyrics, NSError *error) {
                                                          [self checkLyrics:lyrics
                                                                      error:error];
                                                          waitingForBlock = NO;
                                                      }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

#pragma mark - Tests: Artists
-(void)testArtistWithId{
    [self setApiKey];
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] getArtistWithId:@118
                                            completion:^(mXmArtist *artist, NSError *error) {
                                                [self checkArtist:artist
                                                            error:error];
                                                waitingForBlock = NO;
                                            }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

-(void)testSearchArtist{
    [self setApiKey];
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] searchArtistWithName:@"eminem"
                                                limitResult:nil
                                                 completion:^(NSArray *artists, NSError *error) {
                                                     for(mXmArtist *artist in artists)
                                                         [self checkArtist:artist
                                                                     error:error];
                                                waitingForBlock = NO;
                                            }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

-(void)testTrendingArtist{
    [self setApiKey];
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] getTrendingArtistsInCountry:@"it"
                                                       limitResult:@10
                                                 completion:^(NSArray *artists, NSError *error) {
                                                     for(mXmArtist *artist in artists)
                                                         [self checkArtist:artist
                                                                     error:error];
                                                     waitingForBlock = NO;
                                                 }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

-(void)testArtistRelatedTo{
    [self setApiKey];
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] getArtistRelatedTo:@56
                                              limitResult:@2
                                               completion:^(NSArray *artists, NSError *error) {
                                                   for(mXmArtist *artist in artists)
                                                       [self checkArtist:artist
                                                                   error:error];
                                                   waitingForBlock = NO;
                                               }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

#pragma mark - Tests: Albums
-(void)testGetAlbumWithIdWithoutDependencies{
    [self setApiKey];
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] getAlbumWithId:@14250417
                                     withDependencies:NO
                                           completion:^(mXmAlbum *album, NSError *error) {
                                               [self checkAlbum:album
                                                          error:error
                                                   dependencies:NO];
                                               waitingForBlock = NO;
                                           }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

-(void)testGetAlbumWithIdWithDependencies{
    [self setApiKey];
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] getAlbumWithId:@14250417
                                     withDependencies:YES
                                           completion:^(mXmAlbum *album, NSError *error) {
                                               [self checkAlbum:album
                                                          error:error
                                                   dependencies:YES];
                                               waitingForBlock = NO;
                                           }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

-(void)testGetArtistsAlbumWithoutDependencies{
    [self setApiKey];
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] getArtistAlbums:@1039
                                      withDependencies:NO
                                            completion:^(NSArray *albums, NSError *error) {
                                                for(mXmAlbum *album in albums)
                                                    [self checkAlbum:album
                                                               error:error
                                                        dependencies:NO];
                                               waitingForBlock = NO;
                                           }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

-(void)testGetArtistsAlbumWithDependencies{
    [self setApiKey];
    __block BOOL waitingForBlock = YES;
    [[musiXmatchAPI sharedInstance] getArtistAlbums:@1039
                                      withDependencies:YES
                                            completion:^(NSArray *albums, NSError *error) {
                                                for(mXmAlbum *album in albums)
                                                    [self checkAlbum:album
                                                               error:error
                                                        dependencies:YES];
                                                waitingForBlock = NO;
                                            }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    /*[self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];*/
}

@end
