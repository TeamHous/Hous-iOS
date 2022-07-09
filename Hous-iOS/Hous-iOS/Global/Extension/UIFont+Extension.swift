//
//  UIFont+Extension.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/07.
//

import UIKit

enum FontName: String, CaseIterable {
  case spoqaHanSansNeoBold = "SpoqaHanSansNeo-Bold"
  case spoqaHanSansNeoMedium = "SpoqaHanSansNeo-Medium"

  case montserratSemiBold = "Montserrat-SemiBold"
  case montserratBold = "Montserrat-Bold"
  case montserratMedium = "Montserrat-Medium"
  case montserratRegular = "Montserrat-Regular"
}

extension UIFont {
  static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
    return UIFont(name: style.rawValue, size: size)!
  }
}

public class FontLoader {
  static public func registerFont() {
    FontName.allCases.forEach {
      if let fontURL = Bundle(for: FontLoader.self).url(forResource: $0.rawValue, withExtension: "otf"),
         let dataProvider = CGDataProvider(url: fontURL as CFURL),
         let newFont = CGFont(dataProvider) {

        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(newFont, &error) {
          print("Error Loading Font")
        } else {
          print("Loaded Font")
        }
      } else {
        assertionFailure("Error Loading Font!")
      }
    }
  }
}
