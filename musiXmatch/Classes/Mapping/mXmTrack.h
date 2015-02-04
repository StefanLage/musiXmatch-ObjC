//
//  mXmTrack.h
//  musiXmatch
//
//  Created by Stefan Lage on 30/01/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mXmArtist.h"
#import "mXmLyrics.h"
#import "mXmAlbum.h"

@interface mXmTrack : NSObject

@property (nonatomic, copy) NSNumber  * trackId;
@property (nonatomic, copy) NSNumber  * mbId;
@property (nonatomic, copy) NSNumber  * spotifyId;
@property (nonatomic, copy) NSNumber  * soundcloudId;
@property (nonatomic, copy) NSString  * name;
@property (nonatomic, copy) NSNumber  * length;
@property (nonatomic)       BOOL      hasLyrics;
@property (nonatomic)       BOOL      hasSubtitles;
@property (nonatomic, copy) NSNumber  * lyricsId;
@property (nonatomic, copy) mXmLyrics * lyrics;
@property (nonatomic, copy) NSNumber  * artistId;
@property (nonatomic, copy) NSString  * artistName;
@property (nonatomic, copy) mXmArtist * artist;
@property (nonatomic, copy) NSNumber  * albumId;
@property (nonatomic, copy) NSString  * albumName;
@property (nonatomic, copy) mXmAlbum  * album;
@property (nonatomic, copy) NSString  * cover100x100;
@property (nonatomic, copy) NSString  * cover350x350;
@property (nonatomic, copy) NSString  * cover500x500;
@property (nonatomic, copy) NSString  * cover800x800;
@property (nonatomic, copy) NSArray   * primaryGenres;
@property (nonatomic, copy) NSArray   * secondaryGenres;

@end
