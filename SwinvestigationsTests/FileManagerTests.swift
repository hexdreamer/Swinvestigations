//
//  FileManagerTests.swift
//  Swinvestigations
//
//  Created by Kenny Leung on 2016-09-18.
//  Copyright © 2016 PepperDog Enterprises. All rights reserved.
//

import XCTest

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
        self._testEnumerator("/XXX")
    }
    */

    /*  This will fail with EXC_BAD_INSTRUCTION
    func testEnumeratorSymlink() {
        self._testEnumerator("/tmp")
    }
    */

    func testEnumeratorExists() {
        self._testEnumerator("/private/tmp")
    }


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
    */
    func _testEnumerator(_ directory :String) {
        guard let directory = URL(string:directory) else {XCTFail(); return}
        let fileEnumeratorQ = FileManager.default.enumerator(
            at: directory,
            includingPropertiesForKeys: [.isDirectoryKey, .isRegularFileKey, .nameKey, .typeIdentifierKey],
            options: [.skipsHiddenFiles],
            errorHandler:{ (url, error) -> Bool in
                return true
            }
        )

        guard let fileEnumerator = fileEnumeratorQ else {
            return
        }

        NSLog("Enumerator: \(fileEnumerator)");

        for file in fileEnumerator {
            NSLog("file: \(file)")
        }
    }

}
