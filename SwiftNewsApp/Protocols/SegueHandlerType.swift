//
//  SegueHandlerType.swift
//  NewsApp
//
//  Created by Administrator on 16/11/2017.
//  Copyright © 2017 Administrator. All rights reserved.
//

import UIKit

public protocol SegueHandlerType {
  
  associatedtype SegueIdentifier: RawRepresentable
  
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
  
  public func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
    
    guard let identifier = segue.identifier, let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
      fatalError("Unknown segue: \(String(describing: segue.identifier)))")
    }
    
    return segueIdentifier
  }
  
  public func performSegue(segueIdentifier: SegueIdentifier) {
    
    performSegue(withIdentifier: segueIdentifier.rawValue, sender: nil)
  }
  
}
