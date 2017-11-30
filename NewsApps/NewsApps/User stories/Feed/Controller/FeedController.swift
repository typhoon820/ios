//
//  FeedController.swift
//  NewsApps
//
//  Created by xcode on 17.10.2017.
//  Copyright © 2017 VSU. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FeedController: UIViewController, UITableViewDataSource {
    
    let model = FeedModel()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<FeedItemMO> = {
        let request: NSFetchRequest<FeedItemMO> = FeedItemMO.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "pubDate", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: model.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performFetch()
        model.retreiveFeed()
    }
    
    private func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        guard let objects = fetchedResultsController.fetchedObjects else { return 0 }
        return objects.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        if let newsCell = cell as? NewsCell,
            let items = fetchedResultsController.fetchedObjects
        {
            let feedItem = items[indexPath.row]
            newsCell.newsTitleLabel.text = feedItem.title
            newsCell.newsDescriptionLabel.text = feedItem.desc
        }
        return cell
    }
}

extension FeedController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        tableView.reloadData()
    }
}
