//
//  FileManagerTests.swift
//  Swinvestigations
//
//  Created by Kenny Leung on 2016-09-18.
//  Copyright © 2016 PepperDog Enterprises. All rights reserved.
//

import XCTest
import MobileCoreServices

class FileManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    /*  This will fail with EXC_BAD_INSTRUCTION
    func testEnumeratorBogusDirectory() {
        self._testEnumerator("/XXX", expectError:false)
    }
    */

    /*  This will fail with EXC_BAD_INSTRUCTION
    func testEnumeratorSymlink() {
        self._testEnumerator("/tmp", expectError:false)
    }
    */

    func testEnumeratorExists() {
        let bundle = Bundle(for:type(of:self))
        guard let sampleFiles = bundle.url(forResource:"SampleFiles", withExtension:nil) else {
            XCTFail()
            return
        }
        let imageCount = self._testEnumerator(url:sampleFiles, expectError:false)
        XCTAssertEqual(imageCount, 2)
    }

    /*
    func _testEnumerator(path :String, expectError :Bool) {
        guard let url = URL(string:path) else {
            XCTFail()
            return
        }
        self._testEnumerator(url:url, expectError:expectError)
    }
    */

    /*
     This crashes with

     * thread #1: tid = 0x6c49d, 0x0000000104e17d55 libswiftFoundation.dylib`static Foundation.DateComponents._unconditionallyBridgeFromObjectiveC (Swift.Optional<__ObjC.NSDateComponents>) -> Foundation.DateComponents with unmangled suffix "_merged" + 85, queue = 'com.apple.main-thread', stop reason = EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
     frame #0: 0x0000000104e17d55 libswiftFoundation.dylib`static Foundation.DateComponents._unconditionallyBridgeFromObjectiveC (Swift.Optional<__ObjC.NSDateComponents>) -> Foundation.DateComponents with unmangled suffix "_merged" + 85
     frame #1: 0x000000010f57426b SwinvestigationsTests`thunk + 59 at FileManagerTests.swift:0
     frame #2: 0x000000010267534c Foundation`-[NSURLDirectoryEnumerator nextObject] + 101
     frame #3: 0x0000000105659645 CoreFoundation`-[NSEnumerator countByEnumeratingWithState:objects:count:] + 53
     frame #4: 0x0000000104e50e89 libswiftFoundation.dylib`function signature specialization <Arg[1] = Owned To Guaranteed> of Foundation.NSFastEnumerationIterator.(refresh () -> ()).(closure #1) + 153
     frame #5: 0x0000000104de3334 libswiftFoundation.dylib`Foundation.NSFastEnumerationIterator.next () -> Swift.Optional<Any> + 164
     
     This method always returns an enumerator despite the fact that the documentation says it's optional. If the path doesn't exist or is a symlink, it crashes when trying to use the enumerator. The Objective-C version of this code always works.

     Filed as https://bugs.swift.org/browse/SR-2690
     Problem is that the error handler callback is declared non-nullable, but ObjC tries to call it with nil NSError (presumably).
    */
    func _testEnumerator(url :URL, expectError :Bool) -> Int {
        let fileEnumeratorQ = FileManager.default.enumerator(
            at: url,
            includingPropertiesForKeys: [.isDirectoryKey, .isRegularFileKey, .nameKey, .typeIdentifierKey],
            options: [.skipsHiddenFiles],
            errorHandler:{ (url, error) -> Bool in
                if !expectError {
                    XCTFail("Should not have encountered errorHandler")
                }
                return true
            }
        )

        guard let fileEnumerator = fileEnumeratorQ else {
            return 0
        }

        var imageCount = 0;
        for file in fileEnumerator {
            guard let fileURL = file as? URL else {
                XCTFail()
                return 0
            }

            do {
                let resourceValues = try fileURL.resourceValues(forKeys: [.typeIdentifierKey])
                guard let uti = resourceValues.typeIdentifier else {
                    XCTFail()
                    continue
                }

                if ( UTTypeConformsTo(uti as CFString, "public.image" as CFString) ) {
                    NSLog("file: \(fileURL) \(uti)")
                    imageCount += 1
                }
            } catch {
                print("\(error)")
            }
        }
        return imageCount;
    }

}
