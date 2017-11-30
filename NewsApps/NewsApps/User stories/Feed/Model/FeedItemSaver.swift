//
//  FeedItemSaver.swift
//  NewsApps
//
//  Created by xcode on 28.11.2017.
//  Copyright © 2017 VSU. All rights reserved.
//

import Foundation
import CoreData

protocol FeedItemSaver {
    
    func save(feedItems: [FeedItem]) throws
}

class FeedItemCoreDataSaver: FeedItemSaver {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func save(feedItems: [FeedItem]) throws {
        for feedItem in feedItems {
            try FeedItemMO.createOrUpdate(item: feedItem, context: context)
        }
        try context.save()
    }
}
