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
import SafariServices

class FeedController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var model = FeedModel(with: UIApplication.container)
    let imgSelected = UIImage(named: "heart-selected.png") as UIImage!
    
    let imgDeselcted = UIImage(named: "heart-unselected.png") as UIImage!
    

    @IBAction func switchLike(_ sender: UIButton) {
        var superview = sender.superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view.superview
        }
        
        guard let cell = superview as? UITableViewCell else {
            print("button is not contained in a table view cell")
            return
        }
        guard let indexPath = tableView.indexPath(for: cell) else {
            print("failed to get index path for cell containing button")
            return
        }
        if let newsCell = cell as? NewsCell{
            if(newsCell.isInFavorites.image(for: .normal)!.isEqual(imgDeselcted)){
                newsCell.isInFavorites.setImage(imgSelected, for: .normal)

            }
            else{
                newsCell.isInFavorites.setImage(imgDeselcted, for: .normal)
            }
            
            guard let items = fetchedResultsController.fetchedObjects
                else{
                    return
            }
            let item = items[indexPath.item]
            item.isInFavorites = !item.isInFavorites
            model.update(item: item)
        }
    }
    
    
    private lazy var fetchedResultsController: NSFetchedResultsController<FeedItemMO>! = {
        let request: NSFetchRequest<FeedItemMO> = FeedItemMO.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "pubDate", ascending: true)]
        //request.predicate = NSPredicate(format: "isInFavorites = true")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        if let newsCell = cell as? NewsCell,
            let items = fetchedResultsController.fetchedObjects
        {
            let feedItem = items[indexPath.row]
            print(feedItem.isInFavorites, feedItem.title)
            newsCell.newsTitleLabel.text = feedItem.title
            newsCell.newsDescriptionLabel.text = feedItem.desc
            if feedItem.isInFavorites == true{
                newsCell.isInFavorites.setImage(imgSelected, for: .normal)
            }
            else{
                newsCell.isInFavorites.setImage(imgDeselcted, for: .normal)
            }
        }
        return cell
    }
    

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let index = tableView.indexPathForSelectedRow?.row,
            let items = fetchedResultsController.fetchedObjects else { return true }
        
        let item = items[index]
            present(SFSafariViewController(url: item.link), animated: true, completion: nil)
            return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let viewController as FeedDetailsViewController:
            guard let index = tableView.indexPathForSelectedRow?.row,
                let items = fetchedResultsController.fetchedObjects else { return }
            viewController.feedItem = items[index]
            
        default:
            assertionFailure("Handle transiotion to \(segue.destination)")
        }
    }
}

extension FeedController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        performFetch()
        tableView.reloadData()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        print("===========================")
////        model.viewContext.refreshAllObjects()
//        performFetch()
//        tableView.reloadData()
//        
//    }
}
