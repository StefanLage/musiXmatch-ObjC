//
//  mXmMusicGenre.h
//  musiXmatch
//
//  Created by Stefan Lage on 01/02/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mXmMusicGenre : NSObject

@property (nonatomic, copy) NSNumber * genreId;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * nameExtended;
@property (nonatomic, copy) NSString * vanity;

@end
