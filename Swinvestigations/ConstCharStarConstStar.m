//
//  ConstCharStarConstStar.m
//  Swinvestigations
//
//  Created by Kenny Leung on 2016-06-20.
//  Copyright © 2016 PepperDog Enterprises. All rights reserved.
//

#import "ConstCharStarConstStar.h"

@implementation ConstCharStarConstStar

- (BOOL)passCStringFromSwift:(const char * _Nonnull)testString error:(NSError * _Nullable * _Nullable)error
{
    *error = nil;
    if ( !strcmp("Get Smart", testString) ) {
        return YES;
    }
    *error = [NSError errorWithDomain:NSCocoaErrorDomain code:86 userInfo:NULL];
    return NO;
}

@end

