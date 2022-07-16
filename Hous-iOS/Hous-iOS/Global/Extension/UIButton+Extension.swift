//
//  UIButton+Extension.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/07.
//

import UIKit

extension UIButton {
  
  var contentSize: CGFloat {
    return intrinsicContentSize.width
  }
  
  var margin: CGFloat {
    return (frame.width - contentSize) / 2
  }
  
  func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
    UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
    guard let context = UIGraphicsGetCurrentContext() else { return }
    context.setFillColor(color.cgColor)
    context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
    
    let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    self.setBackgroundImage(backgroundImage, for: state)
  }
}
