//
//  mXmAlbum.h
//  musiXmatch
//
//  Created by Stefan Lage on 02/02/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mXmArtist.h"

@interface mXmAlbum : NSObject

@property (nonatomic, copy) NSNumber  * albumId;
@property (nonatomic, copy) NSNumber  * albumMbId;
@property (nonatomic, copy) NSString  * name;
@property (nonatomic, copy) NSNumber  * rating;
@property (nonatomic, copy) NSNumber  * trackCount;
@property (nonatomic, copy) NSString  * albumLabel;
@property (nonatomic, copy) NSDate    * releaseDate;
@property (nonatomic, copy) NSNumber  * artistId;
@property (nonatomic, copy) NSString  * artistName;
@property (nonatomic, copy) mXmArtist * artist;
@property (nonatomic, copy) NSArray   * primaryGenres;
@property (nonatomic, copy) NSArray   * secondaryGenres;
@property (nonatomic, copy) NSString  * pline;
@property (nonatomic, copy) NSString  * copyright;
@property (nonatomic, copy) NSString  * cover100x100;
@property (nonatomic, copy) NSString  * cover350x350;
@property (nonatomic, copy) NSString  * cover500x500;
@property (nonatomic, copy) NSString  * cover800x800;

@end
