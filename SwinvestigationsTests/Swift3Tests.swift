//
//  Swift3Tests.swift
//  Swinvestigations
//
//  Created by Kenny Leung on 2016-06-24.
//  Copyright © 2016 PepperDog Enterprises. All rights reserved.
//

import XCTest
import CoreData

class Swift3Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

// Looks like there's still a problem with Entity.fetchRequest(), so we'll do it the other way.
func updateEntity<Entity:NSManagedObject,PKClass:Hashable>(
    entityPKGetter          :@escaping (_ element :Entity) -> PKClass?,  // object to the @escaping here. Can we somehow get rid of it? (It's CoreData's fault)
    moc                     :NSManagedObjectContext
    ) throws -> [PKClass?]
{
    var mosByID :[PKClass?]? = nil
    moc.performAndWait {
        do {
            let request = NSFetchRequest<Entity>()
            //let request = Entity.fetchRequest()
            //request.predicate = Predicate(format: "%@ in %@", argumentArray:[entityPKAttribute, inList])
            let existingMOs = try request.execute()
            mosByID = existingMOs.map(entityPKGetter)
        } catch {
        }
    }

    return mosByID!
}
