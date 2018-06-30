//
//  Rethrows.swift
//  Swinvestigations
//
//  Created by Kenny Leung on 12/31/17.
//  Copyright © 2017 PepperDog Enterprises. All rights reserved.
//
// https://lists.swift.org/pipermail/swift-users/Week-of-Mon-20171225/006787.html


func withPredicateErrors<Element, Return>(
    _ predicate: @escaping (Element) throws -> Bool,
    do body: ((Element) -> Bool) -> Return
    ) rethrows
    -> Return
{
    var caught: Error?
    var element: Element?
    
    let value = body { elem in
        element = elem
        do {
            return try predicate(elem)
        }
        catch {
            caught = error
            return true     // Terminate search
        }
    }
    
    if let _ = caught,
        let element = element {
        try _ = predicate(element)
    }
    
    return value
}

// Try rewriting this by calling a helper that throws, then you can be the re-thrower.
