//
//  SourceMO+CoreDataProperties.swift
//  NewsApps
//
//  Created by xcode on 14.11.2017.
//  Copyright © 2017 VSU. All rights reserved.
//
//

import Foundation
import CoreData


extension SourceMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourceMO> {
        return NSFetchRequest<SourceMO>(entityName: "Source")
    }

    @NSManaged public var url: String?
    @NSManaged public var name: String?
    @NSManaged public var feedItems: NSSet?

}

// MARK: Generated accessors for feedItems
extension SourceMO {

    @objc(addFeedItemsObject:)
    @NSManaged public func addToFeedItems(_ value: FeedItemMO)

    @objc(removeFeedItemsObject:)
    @NSManaged public func removeFromFeedItems(_ value: FeedItemMO)

    @objc(addFeedItems:)
    @NSManaged public func addToFeedItems(_ values: NSSet)

    @objc(removeFeedItems:)
    @NSManaged public func removeFromFeedItems(_ values: NSSet)

}
