//
//  SettingsController.swift
//  NewsApps
//
//  Created by Andrey Zonov on 11/12/2017.
//  Copyright © 2017 VSU. All rights reserved.
//

import UIKit
import CoreData

class FavoritesController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var model = FeedModel(with: UIApplication.container)
    
    let imgSelected = UIImage(named: "heart-selected.png") as UIImage!
    
    private lazy var fetchedResultsController: NSFetchedResultsController<FeedItemMO> = {
        let request: NSFetchRequest<FeedItemMO> = FeedItemMO.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "pubDate", ascending: true)]
        request.predicate = NSPredicate(format: "isInFavorites = true")
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: model.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        if let newsCell = cell as? FavoriteCell,
         let items = fetchedResultsController.fetchedObjects
        {
            let feedItem = items[indexPath.row]
            newsCell.newsTitleLabel.text = feedItem.title
            newsCell.newsDescriptionLabel.text = feedItem.desc
            newsCell.isInFavorites.setImage(imgSelected, for: .normal)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            if let items = fetchedResultsController.fetchedObjects
            {
                let feedItem = items[indexPath.row]
                feedItem.isInFavorites = !feedItem.isInFavorites
                model.update(item: feedItem)
            }
            
        }
    }
    

    
}

extension FavoritesController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        performFetch()
        tableView.reloadData()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        performFetch()
//        self.tableView.reloadData()
//    }
}
