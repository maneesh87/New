//
//  EmptyDataViewController.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 13/11/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import UIKit

//Mark: - DataSource Protocol
protocol EmptyDataViewControllerDataSource {
  func titleForEmptyDataSet() -> NSAttributedString
  func descriptionForEmptyDataSet() -> NSAttributedString
  func backgroundColor() -> UIColor
}

//Mark: - EmptyDataViewController
class EmptyDataViewController: UIViewController {
  
  //Mark: - Outlet
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  //Mark: - DataSource
  var datasource: EmptyDataViewControllerDataSource?
  
  //Mark: - Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    titleLabel.attributedText = datasource?.titleForEmptyDataSet()
    descriptionLabel.attributedText = datasource?.descriptionForEmptyDataSet()
    setBackGrounColor()
  }
  
  func setBackGrounColor() {
    let color = datasource?.backgroundColor()
    self.view.backgroundColor = color
    for subView in self.view.subviews {
      subView.backgroundColor = color
    }
  }
    
}
