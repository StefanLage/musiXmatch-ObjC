//
//  mXmLyrics.h
//  musiXmatch
//
//  Created by Stefan Lage on 01/02/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mXmLyrics : NSObject

@property (nonatomic, copy) NSNumber * lyricsId;
@property (nonatomic, copy) NSNumber * restricted;
@property (nonatomic, copy) NSString * body;
@property (nonatomic, copy) NSString * language;
@property (nonatomic, copy) NSString * copyright;

@end
