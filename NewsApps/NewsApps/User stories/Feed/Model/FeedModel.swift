//
//  FeedModel.swift
//  NewsApps
//
//  Created by xcode on 17.10.2017.
//  Copyright © 2017 VSU. All rights reserved.
//

import Foundation
import CoreData

class FeedModel: NSObject, XMLParserDelegate {
    
    private let session = URLSession(configuration: .default)
    private let parser: FeedItemParsable = FeedItemXMLParser()
    private lazy var coreDataManager: CoreDataManager = {
        let manager = CoreDataManager()
        let context = manager.persistentContaner.viewContext
        context.automaticallyMergesChangesFromParent = true
        return manager
    }()
    private var saver: FeedItemSaver {
        let container = coreDataManager.persistentContaner
        let context = container.newBackgroundContext()
        return FeedItemCoreDataSaver(context: context)
    }
    
    var viewContext: NSManagedObjectContext {
        return coreDataManager.persistentContaner.viewContext
    }
    
    func retreiveFeed() {
        guard let url = URL(string: "https://wylsa.com/feed") else { return }
        
        let task = session.dataTask(with: url)
        { (data, response, error) in
            if let data = data {
                do {
                    let items = try self.parser.parse(data: data)
                    try self.saver.save(feedItems: items)
                } catch {
                    print(error)
                }
            }
            if let error = error {
                print(error)
            }
        }
        task.resume()
    }
}
