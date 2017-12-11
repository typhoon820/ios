//
//  FeedItem.swift
//  NewsApps
//
//  Created by xcode on 14.11.2017.
//  Copyright © 2017 VSU. All rights reserved.
//

import UIKit

struct FeedItem: FeedItemProtocol {
    let title: String
    let desc: String
    let pubDate: Date
    let link: URL
}

protocol FeedItemProtocol {
    var title: String { get }
    var desc: String { get }
    var pubDate: Date { get }
    var link: URL { get }
}
