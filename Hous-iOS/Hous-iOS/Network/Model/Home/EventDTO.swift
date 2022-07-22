//
//  EventDTO.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/15.
//

import Foundation


// MARK: - EventDTO
struct EventDTO: Codable {
  let id: String
  let eventName: String
  let eventIcon:String
  let date: String
  var participants: [Participant]
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case eventName, eventIcon, date, participants
  }
}

// MARK: - Participant
struct Participant: Codable {
  let id: String
  let userName: String
  let typeColor: String
  var isChecked: Bool
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case userName, typeColor, isChecked
  }
}


// POST - Create Event DTO

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
