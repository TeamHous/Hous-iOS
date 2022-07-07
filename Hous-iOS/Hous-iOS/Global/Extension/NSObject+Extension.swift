//
//  NSObject+Extension.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/07.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
