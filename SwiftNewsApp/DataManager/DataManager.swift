//
//  HeadlineDataManager.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 11/11/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import Foundation
import CoreData

// MARK: - DataManagerDelegate
/// Responds to changes in CoreData
protocol DataManagerDelegate {
  func dataManagerWillChangeContent(dataManager: DataManager)
  func dataManagerDidChangeContent(dataManager: DataManager)
  func dataManager(dataManager: DataManager, didInsertRowAtIndexPath: IndexPath)
  func dataManager(dataManager: DataManager, didDeleteRowAtIndexPath indexPath: IndexPath)
}

/// Optional Method for DataManagerDelegate
extension DataManagerDelegate {
  
  func dataManager(dataManager: DataManager, didDeleteRowAtIndexPath indexPath: IndexPath) { }
  
}

// MARK: - DataManager
/// Checks For any change in coredata objects
class DataManager: NSObject {
  
  // MARK: - Variables
  var fetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
  var delegate: DataManagerDelegate?
  
  // MARK: - Initialization
  ///
  /// - parameter context: Context in which changes needs to be observed
  /// - parameter dataType: Type of data on which changes needs to be observed
  init(context: NSManagedObjectContext, dataType: DataType) {
    super.init()
    let fetchRequest = dataType.getFetchRequest(context: context)
    self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    do {
      try fetchedResultsController.performFetch()
    } catch {
      print(error.localizedDescription)
    }
    fetchedResultsController.delegate = self
  }  
}

// MARK: - NSFetchedResultsControllerDelegate
extension DataManager: NSFetchedResultsControllerDelegate {
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    delegate?.dataManagerWillChangeContent(dataManager: self)
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    delegate?.dataManagerDidChangeContent(dataManager: self)
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch (type) {
    case .insert:
      if let newIndexPath = newIndexPath {
        delegate?.dataManager(dataManager: self, didInsertRowAtIndexPath: newIndexPath)
      }
    case .delete:
      if let indexPath = indexPath {
        delegate?.dataManager(dataManager: self, didDeleteRowAtIndexPath: indexPath)
      }
    default:
      return
    }
  }
  
}
