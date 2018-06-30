//
//  OptionalBooleanTests.swift
//  SwinvestigationsTests
//
//  Created by Kenny Leung on 1/28/18.
//  Copyright © 2018 PepperDog Enterprises. All rights reserved.
//

import XCTest
import Foundation
@testable import Swinvestigations

private enum FSType:UInt32 {
    case hfs = 23
    case autofs = 25
    case afpfs = 27
}

private class Volume:Equatable {
    public var name:String?
    public var volumeIsRootFileSystem:NSNumber?
    public var volumeIsLocal:NSNumber?
    public var _fsType:FSType?
    
    public func fsType() throws -> FSType {
        guard let type = self._fsType else {
            throw SIErrors.invalidArgument("Bogus")
        }
        return type
    }
    static func == (lhs: Volume, rhs: Volume) -> Bool {
        return lhs.name == rhs.name
    }
}

class OptionalBooleanTests: XCTestCase {
    
    private var volumes = [Volume]()
    
    override func setUp() {
        var v:Volume
        
        super.setUp()
        
        v = Volume()
        v.name = "TunesTrove"
        v.volumeIsRootFileSystem = NSNumber(value:false)
        v.volumeIsLocal = NSNumber(value:true)
        v._fsType = .hfs
        self.volumes.append(v)

        v = Volume()
        v.name = "NetworkDrive"
        v.volumeIsRootFileSystem = NSNumber(value:false)
        v.volumeIsLocal = NSNumber(value:false)
        v._fsType = .afpfs
        self.volumes.append(v)
        
        v = Volume()
        v.name = "Macintosh HD"
        v.volumeIsRootFileSystem = NSNumber(value:true)
        v.volumeIsLocal = NSNumber(value:true)
        v._fsType = .hfs
        self.volumes.append(v)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testV1() {
        var results = [Volume]()
        if let rootVolume = volumes.first(where:{$0.volumeIsRootFileSystem?.boolValue == true}) {
            results.append(rootVolume)
            results += volumes.filter{$0 != rootVolume && $0.volumeIsLocal?.boolValue == true}
        } else {
            print("weird occurrence - can't find root volume")
            results += volumes.filter{$0.volumeIsLocal?.boolValue == true}
        }
        results += volumes.filter{(try? $0.fsType()) == FSType.afpfs}
        self.verify()
    }
    
    private func verify() {
        XCTAssertEqual("Macintosh HD", volumes[0].name)
        XCTAssertEqual("NetworkDrive", volumes[1].name)
        XCTAssertEqual("TunesTrove"  , volumes[2].name)
    }

}
