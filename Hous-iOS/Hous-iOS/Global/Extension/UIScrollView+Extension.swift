//
//  UIScrollView+Extension.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/22.
//

import Foundation
import UIKit

extension UIScrollView {
  
  func scrollToTop() {
    self.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
  }
  
}


