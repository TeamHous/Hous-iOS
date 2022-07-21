//
//  UIWindow+.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/14.
//

import UIKit

extension UIWindow {

  static func visibleWindow() -> UIWindow? {
    var currentWindow = UIApplication.shared.keyWindow

    if currentWindow == nil {
      let frontToBackWindows = Array(UIApplication.shared.windows.reversed())

      for window in frontToBackWindows {
        if window.windowLevel == UIWindow.Level.normal {
          currentWindow = window
          break
        }
      }
    }
    return currentWindow
  }
}

extension UIView {
  var windowFrame: CGRect? {
    return superview?.convert(frame, to: nil)
  }

}

