//
//  FeedListViewController.swift
//  SwiftNewsApp
//
//  Created by Maneesh Yadav on 25/06/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import UIKit

class FeedListViewController: UIViewController {
  
  //MARK: - Outlet
  @IBOutlet weak var siteCollectionView: UICollectionView!
  @IBOutlet weak var emptyContainerView: UIView!
  
  // MARK: - Private Properties
  private var coreDataStack = CoreDataStack()

  private lazy var cellSize: CGSize = {
    let screenWidth = UIScreen.main.bounds.width
    let widthTakenByCell = screenWidth - 30
    let cellWidth = CGFloat(widthTakenByCell/2)
    return CGSize(width: cellWidth, height: cellWidth)
  }()

  private lazy var headlineDataManager: SourceListDataManager = {
    return SourceListDataManager(context: coreDataStack.managedObjectContext, dataType: .SelectedSource)
  }()

  private lazy var dataManagerCollectionViewAdapter: DataManagerSourcesCollectionViewAdaptor = {
    return DataManagerSourcesCollectionViewAdaptor(for: siteCollectionView , withDataManager: headlineDataManager)
  }()
  
  // MARK: - Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    headlineDataManager.setDataManagerDelegate(viewAdaptor: dataManagerCollectionViewAdapter)
    siteCollectionView.dataSource = dataManagerCollectionViewAdapter
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let rowCount = headlineDataManager.rowCount
    siteCollectionView.isHidden = rowCount == 0
    emptyContainerView.isHidden = rowCount != 0
  }
  
}

// MARK: - CollectionView Delegate
extension FeedListViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let destination = self.storyboard?.instantiateViewController(withIdentifier: "HeadlineListViewController") as? HeadlineListViewController else { return }
    destination.selectedSource = headlineDataManager.getCoreDataModel(index: indexPath.row)
    destination.coreDataStack = coreDataStack
    self.navigationController?.pushViewController(destination, animated: true)
  }
  
}

// MARK: - CollectionView DelegateFlowLayout
extension FeedListViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return cellSize
  }
  
}

// MARK: - Segue Handling
extension FeedListViewController: SegueHandlerType {

  enum SegueIdentifier: String {
    case ShowNewsSelectionView
    case EmptyDataView
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    switch segueIdentifier(for: segue) {
    case .ShowNewsSelectionView:
      let destination = segue.destination as? NewsSiteSelectionController
      destination?.coreDataStack = coreDataStack
    case .EmptyDataView:
      let destination = segue.destination as? EmptyDataViewController
      destination?.datasource = EmptyFeedListViewModel()
    }
    
  }
  
}




