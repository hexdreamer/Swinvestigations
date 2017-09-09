//
//  ArrayTests.swift
//  Swinvestigations
//
//  Created by Kenny Leung on 12/10/16.
//  Copyright © 2016 PepperDog Enterprises. All rights reserved.
//

import XCTest

class ArrayTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIterationIndexes() {
        let testSet = ["May", "the", "Force", "be", "with", "you"]
    
        //for i in [0..<testSet.endIndex] {  // not this (brain fart)
        for i in 0..<testSet.endIndex {  // this. And testSet.endIndex is 1 past the end of the array, even though that makes no sense at all. But the ship has sailed on that one.
            let word = testSet[i]
            
            print("*** \(i)")
            print("*** \(word)")
        }
    }
    
    
}
