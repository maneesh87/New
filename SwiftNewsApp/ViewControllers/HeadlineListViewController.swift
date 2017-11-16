//
//  HeadlineListViewController.swift
//  SwiftNewsApp
//
//  Created by Maneesh Yadav on 22/07/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import UIKit
import MBProgressHUD
import SafariServices

class HeadlineListViewController: UIViewController {
  
  //MARK: - Dependency
  public var selectedSource: NewsSources!
  public var coreDataStack: CoreDataStack!

  //MARK: - Outlet
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Private Properties
  private lazy var dataManagerTableViewAdapter: DataManagerHeadlineTableAdaptor = {
    return DataManagerHeadlineTableAdaptor(withTable: self.tableView, headlineDataManager: headlineDataManager)
  }()
  
  private lazy var headlineDataManager: HeadlineDataManager = {
    return HeadlineDataManager(context: coreDataStack.managedObjectContext, dataType: .Headlines(selectedFeed: selectedSource))
  }()
  
  // MARK: - Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = selectedSource.name
    fetchAndSaveNews()
    headlineDataManager.setDataManagerDelegate(viewAdaptor: dataManagerTableViewAdapter)
    tableView.dataSource = dataManagerTableViewAdapter
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowNewsDetail" {
      guard
        let selectedCell = tableView.indexPathForSelectedRow,
        let destination = segue.destination as? NewsWebViewController
        else {
          return
      }
      let site = headlineDataManager.getCoreDataModel(index: selectedCell.row)
      guard let link = site?.link else { return }
      destination.link = link
    }
  }
  
  func fetchAndSaveNews() {
    MBProgressHUD.showAdded(to: view, animated: true)
    tableView.isHidden = true
    let feedKitAdaptor = FeedKitAdaptor(selectedFeed: selectedSource, context: coreDataStack.managedObjectContext)
    feedKitAdaptor.saveNewsFeed { [unowned self] (response: FeedKitResponse) in
      switch response {
      case .success:
        self.tableView.isHidden = false
        MBProgressHUD.hide(for: self.view, animated: true)
      case let .error(error):
        self.displayAlert(error.localizedDescription)
      }
    }
  }
  
  private func displayAlert(_ message: String) {
      MBProgressHUD.hide(for: self.view, animated: true)
      let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
      self.present(alert, animated: true, completion: nil)
  }
    
}
