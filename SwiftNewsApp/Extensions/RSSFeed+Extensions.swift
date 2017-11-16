//
//  RSSFeed+Extensions.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 26/10/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import Foundation
import FeedKit

extension RSSFeed {
  
  func sortedFeedItemByDate() -> [RSSFeedItem]? {
    guard let feedItems = self.items else { return nil }
    let sortedFeedItems = feedItems.sorted {
      if let first = $0.pubDate, let second = $1.pubDate {
        return first > second
      } else {
        return false
      }
    }
    return sortedFeedItems
  }
  
}
