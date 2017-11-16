//
//  GradientView.swift
//  SwiftNewsApp
//
//  Created by Maneesh Yadav on 17/07/2017.
//  Copyright © 2017 Maneesh Yadav. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
  
  override func draw(_ rect: CGRect) {
    let sublayerCount = self.layer.sublayers?.count
    if sublayerCount != nil && sublayerCount! > 0 {
        return
    }
    let gradientLayer = CAGradientLayer.init()
    gradientLayer.frame = rect
    gradientLayer.colors = [UIColor.clear.cgColor, UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor]
    self.layer.insertSublayer(gradientLayer, at: 0)
  }
  
}
