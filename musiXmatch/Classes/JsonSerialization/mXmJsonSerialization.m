//
//  mXmJsonSerialization.m
//  musiXmatch
//
//  Created by Stefan Lage on 03/02/15.
//  Copyright (c) 2015 Stefan Lage. All rights reserved.
//

#import "mXmJsonSerialization.h"

#define STATUS_CODE_MESSAGE @{\
                            @400: @"The request had bad syntax or was inherently impossible to be satisfied.",\
                            @401: @"Authentication failed, probably because of invalid/missing API key.",\
                            @402: @"The usage limit has been reached, either you exceeded per day requests limits or your balance is insufficient.",\
                            @403: @"You are not authorized to perform this operation.",\
                            @404: @"The requested resource was not found.",\
                            @405: @"The requested method was not found.",\
                            @500: @"Oops. Something were wrong.",\
                            @503: @"Our system is a bit busy at the moment and your request can’t be satisfied."\
                            }

@implementation mXmJsonSerialization

+ (id)objectFromData:(NSData *)data error:(NSError **)error
{
    NSData *refinedData = data;
    id result            = [NSJSONSerialization JSONObjectWithData:refinedData options:0 error:error];
    NSNumber *statusCode = result[@"message"][@"header"][@"status_code"];
    // Be sure the request was successful
    if(![statusCode isEqual:@200]){
        *error = [NSError errorWithDomain:STATUS_CODE_MESSAGE[statusCode] code:[statusCode intValue] userInfo:nil];
        // No mapping to do
        result = nil;
    }
    return result;
}

+ (NSData *)dataFromObject:(id)object error:(NSError **)error
{
    return [NSJSONSerialization dataWithJSONObject:object options:0 error:error];
}

@end
