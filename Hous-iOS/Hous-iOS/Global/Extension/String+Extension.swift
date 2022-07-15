//
//  String+Extension.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/16.
//

import Foundation

extension String {
  func toDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    
    if let date = dateFormatter.date(from: self) {
      return date
    } else {
      return nil
    }
  }
}
