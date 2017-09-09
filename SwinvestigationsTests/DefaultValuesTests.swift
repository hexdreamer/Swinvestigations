//
//  DefaultValuesTests.swift
//  Swinvestigations
//
//  Created by Kenny Leung on 1/5/17.
//  Copyright © 2017 PepperDog Enterprises. All rights reserved.
//

import XCTest

private class DefaultValues {
    
    // If this method exists, it compiles and it called.
    // If this method does not exist, the code in the test says, "Ambiguous use of 'guous'
    public func guous() {
        print("guous")
    }
    
    public func guous(x:Int=0) {
        print("guous x:")
    }
    
    public func guous(y:Int=1) {
        print("guous y:")
    }
    
}

class DefaultValuesTests: XCTestCase {
    
    func testDefaultValueAmbiguity() {
        let ambi = DefaultValues()
        ambi.guous()
    }
    
}
