//
//  FeedItemParser.swift
//  NewsApps
//
//  Created by xcode on 28.11.2017.
//  Copyright © 2017 VSU. All rights reserved.
//

import Foundation

protocol FeedItemParsable {
    
    func parse(data: Data) throws -> [FeedItem]
}

enum ParsingError: Error {
    case wrongStructure(key: String)
    case wrongDataFormat()
}

class FeedItemXMLParser: FeedItemParsable {
    
    func parse(data: Data) throws -> [FeedItem] {
        let xml = XMLCodable.parse(data)
        var result: [FeedItem] = []
        for item in xml["rss"]["channel"]["item"].all {
            guard let title = item["title"].element?.text else {
                throw ParsingError.wrongStructure(key: "title")
            }
            guard let description = item["description"].element?.text else {
                throw ParsingError.wrongStructure(key: "description")
            }
            guard let dateString = item["pubDate"].element?.text else {
                throw ParsingError.wrongStructure(key: "pubDate")
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss ZZ"
            
            guard let date = dateFormatter.date(from: dateString) else {
                throw ParsingError.wrongDataFormat()
            }
            
            result.append(FeedItem(title: title,
                                   description: description,
                                   pubDate: date,
                                   image: nil))
        }
        return result
    }
}
