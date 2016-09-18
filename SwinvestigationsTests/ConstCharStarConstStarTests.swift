//
//  ConstCharStarConstStar.swift
//  Swinvestigations
//
//  Created by Kenny Leung on 2016-06-20.
//  Copyright © 2016 PepperDog Enterprises. All rights reserved.
//

// How does one interface with a function like this in Swift:
//
// PGconn *PQconnectdbParams(const char * const *keywords, const char * const *values, int expand_dbname);


import XCTest
@testable import Swinvestigations

class ConstCharStarConstStarTests: XCTestCase {

    let objc = ConstCharStarConstStar()

    func testSwiftString() {
        let success = passCStringFromSwift("Get Smart")
        XCTAssertEqual(1, success)
    }

    func testSwiftStringFail() {
        let success = passCStringFromSwift("Bet Smart")
        XCTAssertEqual(0, success)
    }

    func testSwiftStringLossy() {
        // Amazingly, this also works! C doesn't really care if your string is ASCII compliant as long as it's nul terminted.
        let success = passCStringFromSwiftUnicode("Get Smart 😇")
        XCTAssertEqual(1, success)
    }

    func testCString() {
        guard let cstring = "Get Smart".cString(using: String.defaultCStringEncoding) else {
            XCTFail()
            return
        }
        let success = passCStringFromSwift(cstring)
        XCTAssertEqual(1, success)
    }

    func testCStringFail() {
        guard let cstring = "Bet Smart".cString(using: String.defaultCStringEncoding) else {
            XCTFail()
            return
        }
        let success = passCStringFromSwift(cstring)
        XCTAssertEqual(0, success)
    }

    func testCStringLossy() {
        // This one fails expectedly trying to convert the unicode string into a C String
        guard let cstring = "Get Smart 😇".cString(using: String.defaultCStringEncoding) else {
            return
        }
        print("Should never get here \(cstring)")
        XCTFail()
    }

    func testSwiftStringObjC() throws {
        try self.objc.passCString(fromSwift:"Get Smart")
    }

    func testSwiftStringObjCFails() {
        var threw = false
        do {
            try self.objc.passCString(fromSwift:"Bet Smart")
        } catch {
            threw = true
        }
        XCTAssertEqual(true, threw)
    }

    func testCStringObjC() throws {
        guard let cstring = "Get Smart".cString(using: String.defaultCStringEncoding) else {
            XCTFail()
            return
        }
        try self.objc.passCString(fromSwift:cstring)
    }

    func testCStringObjCFails() {
        var threw = false
        do {
            guard let cstring = "Bet Smart".cString(using: String.defaultCStringEncoding) else {
                XCTFail()
                return
            }
            try self.objc.passCString(fromSwift:cstring)
        } catch {
            threw = true
        }
        XCTAssertEqual(true, threw)
    }

    /*
     We would like this to work, but it doesn't. There is an ArrayExtension in hexdreamsCocoa called cStringArray()
    func testCStringArray() {
        let stringArray = ["Get Smart", "Don Adams", "Barbara Feldon"]
        let status = passCStringArrayFromSwift(stringArray);
        XCTAssertEqual(true, status)
    }
    */

}
