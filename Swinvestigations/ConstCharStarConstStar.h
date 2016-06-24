//
//  ConstCharStarConstStar.h
//  Swinvestigations
//
//  Created by Kenny Leung on 2016-06-20.
//  Copyright © 2016 PepperDog Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConstCharStarConstStar : NSObject

- (BOOL)passCStringFromSwift:(const char * _Nonnull)testString error:(NSError * _Nullable * _Nullable)error;

@end

