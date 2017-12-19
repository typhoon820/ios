//
//  FeedDetailsViewController.swift
//  NewsApps
//
//  Created by Andrey Zonov on 11/12/2017.
//  Copyright © 2017 VSU. All rights reserved.
//

import UIKit

class FeedDetailsViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var feedItem: FeedItemProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
