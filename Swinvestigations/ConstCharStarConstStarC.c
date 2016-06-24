//
//  ConstCharStarConstStar.m
//  Swinvestigations
//
//  Created by Kenny Leung on 2016-06-20.
//  Copyright © 2016 PepperDog Enterprises. All rights reserved.
//

#import "ConstCharStarConstStarC.h"

#import <string.h>

int passCStringFromSwift(const char * testString) {
    if ( !strcmp("Get Smart", testString) ) {
        return 1;
    }
    return 0;
}

int passCStringFromSwiftUnicode(const char * testString) {
    if ( !strcmp("Get Smart 😇", testString) ) {
        return 1;
    }
    return 0;
}

int passCStringArrayFromSwift(const char * const *array) {
    return 1;
}

