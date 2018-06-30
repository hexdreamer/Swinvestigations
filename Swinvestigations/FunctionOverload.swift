//
//  FunctionOverload.swift
//  Swinvestigations
//
//  Created by Kenny Leung on 1/12/18.
//  Copyright © 2018 PepperDog Enterprises. All rights reserved.
//

import Foundation
import CoreData

class MO : NSManagedObject {}

public extension NSEntityDescription {
    
    class func entityForClass(entityClass: AnyClass, inManagedObjectContext context: NSManagedObjectContext) -> NSEntityDescription? {
        let entityClassName = NSStringFromClass(entityClass)
        
        guard let psc = context.persistentStoreCoordinator else {
            return nil;
        }
        
        for entityDescription in psc.managedObjectModel.entities {
            if entityClassName == entityDescription.managedObjectClassName {
                return entityDescription;
            }
        }
        
        return nil;
    }
}


extension NSManagedObjectContext {
    func fetch<T>(_ request: NSFetchRequest<T>, faults:Bool) throws -> [T] {
        request.returnsObjectsAsFaults = faults
        return try self.fetch(request)
    }
    
    func pdfetch<T:NSManagedObject> (
        entity            :T.Type,
        //predicate             :NSPredicate? = nil,
        //sortString            :String? = nil,
        //returnFaults          :Bool = false,
        completion            :@escaping (NSAsynchronousFetchResult<T>)->Void
        ) throws
    {
        guard let entity = NSEntityDescription.entityForClass(entityClass: T.self, inManagedObjectContext: self),
            let entityName = entity.name else {
                fatalError()
        }
        let request = NSFetchRequest<T>(entityName: entityName)
//        request.predicate = predicate
//        if let sortString = sortString {
//            try request.sortDescriptors = NSSortDescriptor.sortDescriptorsFrom(string: sortString)
//        }
//        request.returnsObjectsAsFaults = returnFaults
        let asyncRequest = NSAsynchronousFetchRequest(fetchRequest:request, completionBlock:completion)
        try self.execute(asyncRequest)
    }

}

struct FunctionOverload {
    
    func test() throws {
        let moc = NSManagedObjectContext(concurrencyType:.privateQueueConcurrencyType)
        let request = NSFetchRequest<MO>()
        let _ = try moc.fetch(request)
        let _ = try moc.fetch(request, faults:false)
        
        let _ = try moc.pdfetch(
            entity:MO.self,
            //predicate:nil,
            //returnFaults:true,
            completion:{ (results:NSAsynchronousFetchResult<MO>)->Void in}
        )
    }
    
}
