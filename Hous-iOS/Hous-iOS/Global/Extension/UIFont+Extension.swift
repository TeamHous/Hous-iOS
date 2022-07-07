//
//  UIFont+Extension.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/07.
//

import UIKit

enum FontName: String {
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
