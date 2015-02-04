//
//  mXmArtist.h
//  musiXmatch
//
//  Created by Stefan Lage on 02/02/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mXmArtist : NSObject

@property (nonatomic, copy) NSNumber * artistId;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * country;
@property (nonatomic, copy) NSNumber * rating;
@property (nonatomic, copy) NSArray  * alias;

@end
