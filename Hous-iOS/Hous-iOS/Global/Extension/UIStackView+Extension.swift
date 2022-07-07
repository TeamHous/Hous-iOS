//
//  UIStackView+Extension.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/07.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
