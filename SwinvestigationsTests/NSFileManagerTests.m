//
//  NSFileManagerTests.m
//  Swinvestigations
//
//  Created by Kenny Leung on 2016-09-18.
//  Copyright © 2016 PepperDog Enterprises. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MobileCoreServices/MobileCoreServices.h>

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
    [self _testEnumeratorAtPath:@"/XXX" expectError:YES];
}

- (void)testEnumeratorSymlink
{
    [self _testEnumeratorAtPath:@"/tmp" expectError:YES];
}

- (void)testEnumeratorExists
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:@"SampleFiles" withExtension:nil];
    int imageCount = [self _testEnumeratorAtURL:url expectError:NO];
    XCTAssertEqual(imageCount, 2);
}

- (int)_testEnumeratorAtPath:(NSString *)path expectError:(BOOL)expectError
{
    NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]]];
    XCTAssertNotNil(url);
    return [self _testEnumeratorAtURL:url expectError:expectError];
}

/*
 This method will work no matter what url you give it. It will always return an enumerator even though the (Swift side of the) documentation says it's optional. If the path doesn't exist or is a symbolic link, it will enumerate over nothing. The Swift version will crash.
 */
- (int)_testEnumeratorAtURL:(NSURL *)url expectError:(BOOL)expectError
{
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager]
     enumeratorAtURL:url
     includingPropertiesForKeys:@[NSURLIsDirectoryKey, NSURLIsRegularFileKey, NSURLNameKey, NSURLTypeIdentifierKey]
     options:NSDirectoryEnumerationSkipsHiddenFiles
     errorHandler:^BOOL(NSURL * _Nonnull url, NSError * _Nonnull error) {
         if ( !expectError ) {
             XCTFail("Should not have encountered errorHandler");
         }
         return YES;
     }];
    XCTAssertNotNil(enumerator);

    int imageCount = 0;
    for ( NSURL *url in enumerator ) {
        NSString *uti;
        NSError *error;

        [url getResourceValue:&uti forKey:NSURLTypeIdentifierKey error:&error];
        if ( UTTypeConformsTo((__bridge CFStringRef)uti, (__bridge CFStringRef)@"public.image") ) {
            NSLog(@"%@ uti:%@", url, uti);
            imageCount++;
        }
    }
    return imageCount;
}

@end
