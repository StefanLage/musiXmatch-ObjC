//
//  mXmArtist.m
//  musiXmatch
//
//  Created by Stefan Lage on 02/02/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

#import "mXmArtist.h"

@interface mXmArtist()<NSCopying>

@end

@implementation mXmArtist

- (id)copyWithZone:(NSZone *)zone {
    mXmArtist *newArtist = [mXmArtist new];
    [newArtist setArtistId:self.artistId];
    [newArtist setName:self.name];
    [newArtist setCountry:self.country];
    [newArtist setRating:self.rating];
    return newArtist;
}

@end
