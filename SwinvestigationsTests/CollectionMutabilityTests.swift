//
//  CollectionMutabilityTests.swift
//  SwinvestigationsTests
//
//  Created by Kenny Leung on 1/3/18.
//  Copyright © 2018 PepperDog Enterprises. All rights reserved.
//

import XCTest

class CollectionMutabilityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // It appears that this does work! You don't have to create a new array and re-insert it.
    func testDictionaryOfArrays() {
        var data = [UInt:[String]]()
        
        data[42] = []
        data[42]?.append("suction")
        data[42]?.append("ball")
        XCTAssertEqual("suction", data[42]?[0])
        XCTAssertEqual("ball", data[42]?[1])
    }
    
    func testDictionaryOfArraysHarder() {
        var data = [UInt:[String]]()
        
        data[42] = []
        if var words = data[42] {
            words.append("suction")
        }
        if var words = data[42] {
            words.append("ball")
        }
        XCTAssertEqual(0, data[42]?.count)
        // These tests would fail
        //XCTAssertEqual("suction", data[42]?[0])
        //XCTAssertEqual("ball", data[42]?[1])
    }

}
