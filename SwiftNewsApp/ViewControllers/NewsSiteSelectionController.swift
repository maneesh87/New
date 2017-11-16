//
//  NewsSiteSelectionController.swift
//  SwiftNewsApp
//
//  Created by Maneesh Yadav on 15/07/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import Foundation
import UIKit
import BEMCheckBox
import CoreData

class NewsSiteSelectionController: UIViewController {
  
  //MARK: - Dependency
  public var coreDataStack: CoreDataStack!

  //MARK: - Outlet
  @IBOutlet weak var siteTableView: UITableView!

  // MARK: - Private Properties
  fileprivate var newsFeedList = [NewsSources]()

  fileprivate var selectedRows = 0 {
    didSet {
      if selectedRows == newsFeedList.count && selectedRows != 0 {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "UnSelect All", style: .plain, target: self, action: #selector(unSelectAllFeeds(_:)))
      } else {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Select All", style: .plain, target: self, action: #selector(selectAllFeeds(_:)))
      }
    }
  }
  
  // MARK: - Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    getnewsFeedList()
    updateFeedList()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
      coreDataStack.saveContext()
  }

  func addNewsFeedToCoreData(newsSite: NewsSite) {
    let selectedFeed = NewsSources(fromNewsSite: newsSite, inContext: coreDataStack.managedObjectContext)
    newsFeedList.append(selectedFeed)
  }
  
  @IBAction func selectAllFeeds(_ sender: UIBarButtonItem) {
    markAllFeed(asSelected: true)
  }
  
  @IBAction func unSelectAllFeeds(_ sender: UIBarButtonItem) {
    markAllFeed(asSelected: false)
  }
  
  func markAllFeed(asSelected selected: Bool) {
    newsFeedList = newsFeedList.map{
      $0.isSelected = selected
      return $0
    }
    selectedRows = selected ? newsFeedList.count : 0
    siteTableView.reloadData()
  }
  
  func feedDidSelect(selected : Bool, atIndexPath indexPath: IndexPath) {
    newsFeedList[indexPath.row].isSelected = selected
    selectedRows = selected ? selectedRows + 1 : selectedRows - 1
    siteTableView.reloadRows(at: [indexPath], with: .none)
  }
  
  func getCell(forNeswFeed feed: NewsSources) -> FeedSelectionTableViewCell {
    let cell = siteTableView.dequeueReusableCell(withIdentifier: FeedSelectionTableViewCell.identifier) as? FeedSelectionTableViewCell ?? FeedSelectionTableViewCell()
    cell.configureCell(withFeed: feed)
    return cell
  }
  
  private func getnewsFeedList() {
    let context = coreDataStack.managedObjectContext //(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NewsSources.getAllFeedFetchRequest()
    do {
      newsFeedList = try context.fetch(fetchRequest) as! [NewsSources]
    }
    catch {
      print("Fetching Failed")
    }
    selectedRows = newsFeedList.filter{ $0.isSelected }.count
  }
  
  func updateFeedList() {
    guard let siteList = readDataFromPlist() else { return }
    for site in siteList {
      if newsFeedList.index(where: { $0.name == site["Name"] as? String }) != nil {
        continue
      }
      guard let newsSite = NewsSite(newsSite: site) else { continue }
      addNewsFeedToCoreData(newsSite: newsSite)
    }
  }
  
}

// MARK: - BEMCheckBoxDelegate
extension NewsSiteSelectionController : BEMCheckBoxDelegate {
    
  func didTap(_ checkBox: BEMCheckBox) {
    let center = checkBox.center;
    guard let rootViewPoint = checkBox.superview?.convert(center, to: siteTableView) else { return }
    guard let indexPath = siteTableView.indexPathForRow(at: rootViewPoint) else { return }
  
    if checkBox.on {
      newsFeedList[(indexPath.row)].isSelected = true
      siteTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
      selectedRows = selectedRows + 1
    } else {
      newsFeedList[(indexPath.row)].isSelected = false
      siteTableView.deselectRow(at: indexPath, animated: false)
      selectedRows = selectedRows - 1
    }
  }

}

// MARK: - TableView
extension NewsSiteSelectionController : UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return newsFeedList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let site = newsFeedList[indexPath.row]
    let cell = getCell(forNeswFeed: site)
    if site.isSelected {
      tableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    feedDidSelect(selected: true, atIndexPath: indexPath)
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    feedDidSelect(selected: false, atIndexPath: indexPath)
  }
  
}
