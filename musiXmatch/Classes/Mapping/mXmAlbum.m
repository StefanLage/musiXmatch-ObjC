//
//  mXmAlbum.m
//  musiXmatch
//
//  Created by Stefan Lage on 02/02/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

#import "mXmAlbum.h"

@interface mXmAlbum()<NSCopying>

@end

@implementation mXmAlbum

- (id)copyWithZone:(NSZone *)zone {
    mXmAlbum *newAlbum = [mXmAlbum new];
    [newAlbum setAlbumId:self.albumId];
    [newAlbum setAlbumMbId:self.albumMbId];
    [newAlbum setName:self.name];
    [newAlbum setRating:self.rating];
    [newAlbum setTrackCount:self.trackCount];
    [newAlbum setAlbumLabel:self.albumLabel];
    [newAlbum setReleaseDate:self.releaseDate];
    [newAlbum setArtistId:self.artistId];
    [newAlbum setArtistName:self.artistName];
    [newAlbum setArtist:self.artist];
    [newAlbum setPrimaryGenres:self.primaryGenres];
    [newAlbum setSecondaryGenres:self.secondaryGenres];
    [newAlbum setPline:self.pline];
    [newAlbum setCopyright:self.copyright];
    [newAlbum setCover100x100:self.cover100x100];
    [newAlbum setCover350x350:self.cover350x350];
    [newAlbum setCover500x500:self.cover500x500];
    [newAlbum setCover800x800:self.cover800x800];
    return newAlbum;
}

@end
