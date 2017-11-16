//
//  SourceListDataManager.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 11/11/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import CoreData

struct SourceListDataManager: DataManagerProtocol {
  
  typealias ManagedObjectType = NewsSources
  typealias ViewModel = SourceCellModel
  typealias ViewAdaptor = DataManagerSourcesCollectionViewAdaptor
  
  var dataManager: DataManager
  
  init(context: NSManagedObjectContext, dataType: DataType) {
    dataManager = DataManager(context: context, dataType: dataType)
  }
  
  func getViewModel(index: Int) -> ViewModel? {
    guard let selectedFeed = self.getCoreDataModel(index: index) else { return nil }
    let cellModel = SourceCellModel(source: selectedFeed )
    return cellModel
  }

}
