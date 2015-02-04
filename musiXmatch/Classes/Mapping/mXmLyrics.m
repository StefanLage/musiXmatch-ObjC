//
//  mXmLyrics.m
//  musiXmatch
//
//  Created by Stefan Lage on 01/02/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

#import "mXmLyrics.h"

@interface mXmLyrics()<NSCopying>

@end

@implementation mXmLyrics

- (id)copyWithZone:(NSZone *)zone {
    mXmLyrics *newLyrics = [mXmLyrics new];
    [newLyrics setLyricsId:self.lyricsId];
    [newLyrics setBody:self.body];
    [newLyrics setRestricted:self.restricted];
    [newLyrics setLanguage:self.language];
    return newLyrics;
}

@end