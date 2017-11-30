//
//  FeedItemMO+CoreDataProperties.swift
//  NewsApps
//
//  Created by xcode on 14.11.2017.
//  Copyright © 2017 VSU. All rights reserved.
//
//

import Foundation
import CoreData


extension FeedItemMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeedItemMO> {
        return NSFetchRequest<FeedItemMO>(entityName: "FeedItem")
    }

    @NSManaged public var id: String?
    @NSManaged public var pubDate: Date
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var image: String?
    @NSManaged public var source: SourceMO?

}
