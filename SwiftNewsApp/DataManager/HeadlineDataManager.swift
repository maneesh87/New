//
//  HeadlineDataManager.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 11/11/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import CoreData

struct HeadlineDataManager: DataManagerProtocol {

  typealias ManagedObjectType = News
  typealias ViewModel = HeadlineCellModel
  typealias ViewAdaptor = DataManagerHeadlineTableAdaptor

  var dataManager: DataManager
  
  init(context: NSManagedObjectContext, dataType: DataType) {
    dataManager = DataManager(context: context, dataType: dataType)
  }
  
  func getViewModel(index: Int) -> ViewModel? {
    guard let news = self.getCoreDataModel(index: index) else { return nil }
    let cellModel = HeadlineCellModel(news: news)
    return cellModel
  }
  
}
