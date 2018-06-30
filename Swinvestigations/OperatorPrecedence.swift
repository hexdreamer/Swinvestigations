//
//  OperatorPrecedence.swift
//  Swinvestigations
//
//  Created by Kenny Leung on 1/5/18.
//  Copyright © 2018 PepperDog Enterprises. All rights reserved.
//

class Suction {
    func ball() -> Bool {
        return true
    }
}

// Checking to see that NOT ("!") does not bind tighter than a method call. Though I saw this in my code.
func testNotVSMethod() {
    let x = Suction()
    if !x.ball() {
        print("OK")
    }
}
