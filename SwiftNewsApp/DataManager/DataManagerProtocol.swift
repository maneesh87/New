//
//  DataManagerProtocol.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 12/11/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import CoreData

/// Protocol to use DataManager class
protocol DataManagerProtocol {
  
  // MARK: - Associated Types
  associatedtype ManagedObjectType
  associatedtype ViewModel
  associatedtype ViewAdaptor: DataManagerDelegate
  
  // MARK: - Variables
  var dataManager: DataManager { get set}
  var rowCount: Int {get}
  
  // MARK: - Functions
  init(context: NSManagedObjectContext, dataType: DataType)
  func setDataManagerDelegate(viewAdaptor: ViewAdaptor)
  func getViewModel(index: Int) -> ViewModel?
  func getCoreDataModel(index: Int) -> ManagedObjectType?
  
}

extension DataManagerProtocol {
  
  func getCoreDataModel(index: Int) -> ManagedObjectType? {
    guard let cellModels = dataManager.fetchedResultsController.fetchedObjects else { return nil }
    guard let news = cellModels[index] as? ManagedObjectType else { return nil }
    return news
  }
  
  var rowCount: Int {
    guard let count = dataManager.fetchedResultsController.fetchedObjects?.count else { return 0 }
    return count
  }
  
  func setDataManagerDelegate(viewAdaptor: ViewAdaptor) {
    dataManager.delegate = viewAdaptor
  }

}
