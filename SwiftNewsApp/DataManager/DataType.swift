//
//  DataType.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 11/11/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import CoreData

enum DataType {
  
  case AllSource
  case SelectedSource
  case Headlines(selectedFeed: NewsSources)
  
  /// Get fetch Request for DataManager
  func getFetchRequest(context: NSManagedObjectContext) -> NSFetchRequest<NSFetchRequestResult>  {
    
    switch self {
    case .AllSource:
      let fetchRequest = NewsSources.getAllFeedFetchRequest()
      return fetchRequest
    case .SelectedSource:
      let fetchRequest = NewsSources.getSelectedNewsSourcesFetchRequest()
      return fetchRequest
    case let .Headlines(selectedFeed):
      let fetchRequest = News.getAllNewsFetchRequest(forSource: selectedFeed.name)
      return fetchRequest
    }
    
  }
  
}
