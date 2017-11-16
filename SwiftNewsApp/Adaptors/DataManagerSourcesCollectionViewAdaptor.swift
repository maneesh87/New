//
//  DataManagerFeedsCollectionViewAdaptor.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 10/11/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import UIKit

class DataManagerSourcesCollectionViewAdaptor: NSObject {
  
  // MARK: - Properties
  let collectionView : UICollectionView
  
  // MARK: - Private Variables
  private let headlineDataManager: SourceListDataManager
  private var blockOperations: [BlockOperation] = []

  // MARK: - Functions
  init(for collectionView: UICollectionView, withDataManager: SourceListDataManager) {
    self.collectionView = collectionView
    self.headlineDataManager = withDataManager
  }
  
  deinit {
    for operation: BlockOperation in blockOperations {
      operation.cancel()
    }
    blockOperations.removeAll(keepingCapacity: false)
  }
  
  private func getNewsCell(for indexPath: IndexPath) -> FeedCollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.identifier, for: indexPath) as? FeedCollectionViewCell else { return FeedCollectionViewCell() }
    let item = headlineDataManager.getViewModel(index: indexPath.row)
    cell.cellModel = item
    return cell
  }
  
}

// MARK: - CollectionView DataSource
extension DataManagerSourcesCollectionViewAdaptor: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return headlineDataManager.rowCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return getNewsCell(for: indexPath)
  }
  
}

// MARK: - DataManagerDelegate
extension DataManagerSourcesCollectionViewAdaptor: DataManagerDelegate {
  
  func dataManagerWillChangeContent(dataManager: DataManager) {

  }
  
  func dataManagerDidChangeContent(dataManager: DataManager) {
    collectionView.performBatchUpdates({ () -> Void in
      for operation: BlockOperation in self.blockOperations {
        operation.start()
      }
    }, completion: { (finished) -> Void in
      self.blockOperations.removeAll(keepingCapacity: false)
    })
  }
  
  func dataManager(dataManager: DataManager, didInsertRowAtIndexPath indexPath: IndexPath) {
    blockOperations.append(
      BlockOperation(block: { [weak self] in
        if let this = self {
          this.collectionView.insertItems(at: [indexPath])
        }
      })
    )
  }
  
  func dataManager(dataManager: DataManager, didDeleteRowAtIndexPath indexPath: IndexPath) {
    blockOperations.append(
      BlockOperation(block: { [weak self] in
        if let this = self {
          this.collectionView.deleteItems(at: [indexPath])
        }
      })
    )
  }

}
