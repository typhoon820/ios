//
//  SourceMO+CoreDataClass.swift
//  NewsApps
//
//  Created by xcode on 14.11.2017.
//  Copyright © 2017 VSU. All rights reserved.
//
//

import Foundation
import CoreData


public class SourceMO: NSManagedObject {

    class func createOrUpdate(
        with url: String,
        name: String,
        context: NSManagedObjectContext) throws -> SourceMO
    {
        let request: NSFetchRequest<SourceMO> = SourceMO.fetchRequest()
        request.predicate = NSPredicate(format: "url = %@", url)
        
        let source: SourceMO
        let result = try context.fetch(request)
        
        if result.count == 0 {
            source = SourceMO(context: context)
        } else if let firstSource = result.first, result.count == 1 {
            source = firstSource
        } else {
            assertionFailure("something went wrong")
            source = SourceMO(context: context)
        }
        source.name = name
        source.url = url
        
        return source
    }
}
