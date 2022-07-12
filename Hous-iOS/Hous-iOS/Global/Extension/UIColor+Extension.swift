//
//  UIColor+Extension.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit


extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}

extension UIColor {
  static func assigneeColor(_ name: AssigneeColor) -> UIColor {
    switch name {
    case .yellow:
      return R.Color.paleGold
    case .blue:
      return R.Color.softBlue
    case .purple:
      return R.Color.lilac
    case .red:
      return R.Color.salmon
    case .green:
      return R.Color.easterGreen
    case .none:
      return R.Color.veryLightPinkFour
    }
  }
}
