//
//  Errors.swift
//  Swinvestigations
//
//  Created by Kenny Leung on 1/28/18.
//  Copyright © 2018 PepperDog Enterprises. All rights reserved.
//

import Foundation

public enum SIErrors : Error {
    case invalidArgument(String)       // message
    case objectNotFound(Any,String,String)  // our equivalent of NullPointerException args: sender, function, message
    case internalInconsistency(String)
    case fatal(String)
}
