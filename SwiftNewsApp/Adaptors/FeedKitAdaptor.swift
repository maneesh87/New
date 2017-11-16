//
//  FeedKitAdaptor.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 04/11/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import Foundation
import FeedKit
import CoreData

enum FeedKitResponse {
  case success
  case error(NSError)
}

struct FeedKitAdaptor {
  
  let selectedFeed: NewsSources
  let context: NSManagedObjectContext
  
  /// Fetch news from FeedKit
  func saveNewsFeed(completion: @escaping (_ response: FeedKitResponse) -> ()) {
    guard let url = selectedFeed.url, let feedURL = URL(string: url) else { return }
    DispatchQueue.global(qos: .userInitiated).async { // Run parsing in a background thread
      guard let feedParser = FeedParser(URL: feedURL) else { return }
      let result = feedParser.parse()
      DispatchQueue.main.async {
        switch result {
        case let .rss(rssFeed):
          self.saveNews(withResult: rssFeed)
          completion(FeedKitResponse.success)
        case let .failure(error):
          print(error.description)
          completion(FeedKitResponse.error(error))
        default:
          print("Only RSS supported for now")
        }
      }
    }
  }
  
  /// Save news in CoreData
  fileprivate func saveNews(withResult rssFeed: RSSFeed) {
    guard let feedItems = rssFeed.sortedFeedItemByDate() else { return }
    for feedItem in feedItems {
      guard let link = feedItem.link else { continue }
      let existingRecord = selectedFeed.contains(link: link)
      if !existingRecord {
        _ = News(fromFeedItem: feedItem, forFeed: selectedFeed, inContext: context)
      }
    }
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
}
