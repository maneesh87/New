//
//  NewsSources+CoreDataClass.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 20/09/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//
//

import Foundation
import CoreData

public class NewsSources: NSManagedObject {
  
  convenience init(fromNewsSite newsSite: NewsSite, inContext context: NSManagedObjectContext) {
    self.init(context: context)
    self.name = newsSite.name
    self.imageName = newsSite.imageName
    self.url = newsSite.url
    self.isLanguageLeftAligned = newsSite.isLanguageLeftAligned
    self.isSelected = newsSite.selected
  }
  
  @nonobjc public class func getSelectedNewsSourcesFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
    let fetchRequest = getAllFeedFetchRequest()
    let predicate = NSPredicate(format: "%K == true", #keyPath(NewsSources.isSelected))
    fetchRequest.predicate = predicate
    return fetchRequest
  }
  
  @nonobjc public class func getAllFeedFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsSources")
    fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: #keyPath(NewsSources.name), ascending: true)]
    return fetchRequest
  }
  
  func contains(link: String) -> Bool {
    let existingRecord = (self.news?.value(forKey: #keyPath(News.link)) as AnyObject).contains(link as Any)
    return existingRecord
  }
  
}
