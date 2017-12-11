//
//  WylsaComFeedParser.swift
//  NewsApps
//
//  Created by Andrey Zonov on 11/12/2017.
//  Copyright © 2017 VSU. All rights reserved.
//

import Foundation

class WylsaComFeedParser: FeedItemXMLParser {
    
    override func parse(data: Data) throws -> [FeedItem] {
        let items = try super.parse(data: data)
        
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let mappedItems = items.flatMap { (item) -> FeedItem? in
            guard let data = item.desc.data(using: .utf8) else {
                return nil
            }
            guard let attributedString = try? NSAttributedString(data: data,
                                                                 options: options,
                                                                 documentAttributes: nil)
                else { return nil }
            
            return FeedItem(title: item.title,
                            desc: attributedString.string,
                            pubDate: item.pubDate,
                            link: item.link)
        }
        return mappedItems
    }
}
