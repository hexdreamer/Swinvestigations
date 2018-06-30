//
//  KeyPaths.swift
//  Swinvestigations
//
//  Created by Kenny Leung on 1/11/18.
//  Copyright © 2018 PepperDog Enterprises. All rights reserved.
//

class ThePath {
    var isWinding:Bool?
}

func walk<T>(aPath:T, forKey:PartialKeyPath<T>) {
}

func walkThePath(aPath:ThePath, forKey:PartialKeyPath<ThePath>) {
}

// You can't leave out ThePath in the key path, although you really should be able to.
// Filed as https://bugs.swift.org/browse/SR-6740
func test() {
    let path = ThePath()
    walkThePath(aPath:path, forKey:\ThePath.isWinding)
    walk(aPath:path, forKey:\ThePath.isWinding)
}

