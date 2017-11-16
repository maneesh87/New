//
//  DataManagerHealineTableAdaptor.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 10/11/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import UIKit

class DataManagerHeadlineTableAdaptor: NSObject {
  
  // MARK: - Properties
  let tableView : UITableView
  
  // MARK: - Private Variables
  private let headlineDataManager: HeadlineDataManager

  // MARK: - Functions
  init(withTable tableView: UITableView, headlineDataManager: HeadlineDataManager) {
    self.tableView = tableView
    self.headlineDataManager = headlineDataManager
  }
  
  private func getCell(ForHeadline item: HeadlineCellModel?) -> HeadlineCellWithImage {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineCellWithImage.identifier) as? HeadlineCellWithImage else { return HeadlineCellWithImage() }
    cell.cellModel = item
    return cell
  }
  
}

// MARK: - DataManagerDelegate
extension DataManagerHeadlineTableAdaptor: DataManagerDelegate {
  
  func dataManager(didDeleteRowAtIndexPath indexPath: IndexPath) {
  }
  
  func dataManagerWillChangeContent(dataManager: DataManager) {
    UIView.setAnimationsEnabled(false)
    tableView.beginUpdates()
  }
  
  func dataManagerDidChangeContent(dataManager: DataManager) {
    tableView.endUpdates()
    UIView.setAnimationsEnabled(true)
  }
  
  func dataManager(dataManager: DataManager, didInsertRowAtIndexPath indexPath: IndexPath) {
    tableView.insertRows(at: [indexPath], with: .none)
  }
  
}

// MARK: - TableView
extension DataManagerHeadlineTableAdaptor: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return headlineDataManager.rowCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = headlineDataManager.getViewModel(index: indexPath.row)
    let cell = getCell(ForHeadline: item)
    return cell
  }

}
