//
//  Date+Extension.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/16.
//

import Foundation

extension Date {
  var year: Int {
    let calendar = Calendar.current
    return calendar.component(.year, from: self)
  }
  
  var month: Int {
    let calendar = Calendar.current
    return calendar.component(.month, from: self)
  }
  
  var day: Int {
    let calendar = Calendar.current
    return calendar.component(.day, from: self)
  }
  
  func formatted(_ format: String) -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = format
      formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)

      return formatter.string(from: self)
  }
}
