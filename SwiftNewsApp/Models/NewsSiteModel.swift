//
//  NewsSiteModel.swift
//  NewsApp
//
//  Created by Maneesh Yadav on 21/09/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import Foundation

public func readDataFromPlist() -> [Dictionary<String, Any>]? {
    
  guard let path = Bundle.main.path(forResource: "SiteList", ofType: "plist") else { return nil }
  let ary = NSArray.init(contentsOfFile: path)
  var siteList = [Dictionary<String, Any>]()
  
  let sortDescriptors = [NSSortDescriptor.init(key: "Name", ascending: true)]
  siteList = ary?.sortedArray(using: sortDescriptors) as! [Dictionary<String, Any>]
  return siteList
    
}

struct NewsSite {
  var name : String?
  var imageName : String?
  var isLanguageLeftAligned : Bool = false
  var url : String?
  var selected : Bool = false
  
  init?(newsSite: Dictionary<String, Any>) {
    self.name = newsSite["Name"] as? String
    self.imageName = newsSite["Image"] as? String
    self.url = newsSite["RssURL"] as? String
    self.isLanguageLeftAligned = newsSite["Language"] as? Bool ?? false
  }

}
