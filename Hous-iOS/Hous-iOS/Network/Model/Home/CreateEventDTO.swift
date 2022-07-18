//
//  CreateEventDTO.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/19.
//

import Foundation

struct CreateEventDTO: Codable {
  let id: String
  let eventName: String
  let eventIcon: String
  let date: String
  let participants: [String]
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case eventName, eventIcon, date, participants
  }
}
