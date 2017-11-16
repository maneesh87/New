//
//  News+CoreDataClass.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 20/09/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//
//

import Foundation
import CoreData
import FeedKit

public class News: NSManagedObject {
  
  convenience init(fromFeedItem feedItem: RSSFeedItem, forFeed selectedFeed: NewsSources, inContext context: NSManagedObjectContext) {
    self.init(context: context)
    self.content = feedItem.description?.stringByDecodingHTMLEntities
    self.title = feedItem.title
    self.date = feedItem.pubDate
    self.identifier = feedItem.link
    self.link = feedItem.link
    if let mediaContent = feedItem.media?.mediaContents, let url = mediaContent[0].attributes?.url {
      self.thumbnail = url
    } else if let mediaThumbnail = feedItem.media?.mediaThumbnails, let url = mediaThumbnail[0].attributes?.url {
      self.thumbnail = url
    }
    self.feed = selectedFeed
  }
  
  @nonobjc public class func getAllNewsFetchRequest(forSource feedName: String?) -> NSFetchRequest<NSFetchRequestResult>  {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(News.date), ascending: false)]
    if let feedName = feedName {
      fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(News.feed.name), feedName)
    }
    return fetchRequest
  }
  
}
