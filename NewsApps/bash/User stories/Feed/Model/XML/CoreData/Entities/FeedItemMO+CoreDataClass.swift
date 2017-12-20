//
//  FeedItemMO+CoreDataClass.swift
//  NewsApps
//
//  Created by xcode on 14.11.2017.
//  Copyright © 2017 VSU. All rights reserved.
//
//

import Foundation
import CoreData

public class FeedItemMO: NSManagedObject {
    
    @discardableResult
    class func createOrUpdate(item: FeedItemProtocol,
                              context: NSManagedObjectContext) throws -> FeedItemMO
    {
        let request: NSFetchRequest<FeedItemMO> = FeedItemMO.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", item.title)
        
        let feedItemMO: FeedItemMO
        let result = try context.fetch(request)
        
        if result.count == 0 {
            feedItemMO = FeedItemMO(context: context)
        } else if let firstSource = result.first, result.count == 1 {
            feedItemMO = firstSource
        } else {
            assertionFailure("something went wrong")
            feedItemMO = FeedItemMO(context: context)
        }
        feedItemMO.title = item.title
        feedItemMO.desc = item.desc
        feedItemMO.pubDate = item.pubDate
        feedItemMO.link = item.link
        feedItemMO.details = item.details
        feedItemMO.isInFavorites = item.isInFavorites
        return feedItemMO
    }
    @discardableResult
    class func findFavorites(context: NSManagedObjectContext) throws -> [FeedItemMO]
    {
        let request: NSFetchRequest<FeedItemMO> = FeedItemMO.fetchRequest()
        request.predicate=NSPredicate(format: "isInFavorites = true")
        let result = try context.fetch(request)
        return result
    }
}
