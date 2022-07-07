//
//  Asset.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/07.
//

import UIKit

public struct R {

  public struct Color { }
  public struct Image { }

}

extension R.Color {
  static var color1: UIColor {
    .dynamicColor(light: .primaryLight, dark: .white)
  }
}

extension R.Image {
//  static var test = UIImage(named: "Image_name")
  static var systemImage = UIImage(systemName:"flame")

}

extension UIColor {
  static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
    guard #available(iOS 13.0, *) else { return light }
    return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
  }
  @nonobjc class var primaryLight: UIColor {
    return UIColor(red: 111.0 / 255.0, green: 100.0 / 255.0, blue: 1.0, alpha: 1.0)
  }
}
