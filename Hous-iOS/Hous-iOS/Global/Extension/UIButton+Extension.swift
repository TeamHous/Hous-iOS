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
}
