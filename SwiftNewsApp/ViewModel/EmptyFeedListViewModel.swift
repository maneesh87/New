//
//  EmptyFeedListViewModel.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 20/10/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import UIKit

struct EmptyFeedListViewModel: EmptyDataViewControllerDataSource {
  
  func titleForEmptyDataSet() -> NSAttributedString {
    let text = "No News Feed Selected"
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = .byWordWrapping
    paragraphStyle.alignment = .center
    
    let shadow = NSShadow()
    shadow.shadowColor = UIColor.white
    shadow.shadowOffset = CGSize.init(width: 0.0, height: 1.0)
    
    let attributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17.0), NSAttributedStringKey.foregroundColor: TintColor , NSAttributedStringKey.paragraphStyle: paragraphStyle, NSAttributedStringKey.shadow: shadow]
    let attributedString = NSAttributedString.init(string: text, attributes: attributes)
    
    return attributedString
  }
  
  func descriptionForEmptyDataSet() -> NSAttributedString {
    let text = "Tap on the + icon to subscribe to RSS Feed."
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = .byWordWrapping
    paragraphStyle.alignment = .center
    
    let attributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0), NSAttributedStringKey.foregroundColor: TintColor , NSAttributedStringKey.paragraphStyle: paragraphStyle]
    let attributedString = NSAttributedString.init(string: text, attributes: attributes)
    
    return attributedString
  }
  
  func backgroundColor() -> UIColor {
    return UIColor.white
  }

}
