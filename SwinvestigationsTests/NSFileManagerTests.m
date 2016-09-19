//
//  NSFileManagerTests.m
//  Swinvestigations
//
//  Created by Kenny Leung on 2016-09-18.
//  Copyright © 2016 PepperDog Enterprises. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSFileManagerTests : XCTestCase

@end

@implementation NSFileManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEnumeratorBogusDirectory
{
    [self _testEnumerator:@"/XXX"];
}

- (void)testEnumeratorSymlink
{
    [self _testEnumerator:@"/tmp"];
}

- (void)testEnumeratorExists
{
    [self _testEnumerator:@"/private/tmp"];
}

/*
 This method will work no matter what url you give it. It will always return an enumerator even though the (Swift side of the) documentation says it's optional. If the path doesn't exist or is a symbolic link, it will enumerate over nothing. The Swift version will crash.
 */
- (void)_testEnumerator:(NSString *)directory
{
    NSURL *url = [NSURL URLWithString:directory];
    XCTAssertNotNil(url);
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager]
     enumeratorAtURL:url
     includingPropertiesForKeys:@[NSURLIsDirectoryKey, NSURLIsRegularFileKey, NSURLNameKey, NSURLTypeIdentifierKey]
     options:NSDirectoryEnumerationSkipsHiddenFiles
     errorHandler:^BOOL(NSURL * _Nonnull url, NSError * _Nonnull error) {
         return YES;
     }];
    XCTAssertNotNil(enumerator);

    NSLog(@"Enumerator: %@", enumerator);

    for ( NSURL *url in enumerator ) {
        NSLog(@"%@", url);
    }
}

@end
