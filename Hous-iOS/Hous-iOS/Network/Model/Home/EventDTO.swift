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
  let participants: [Participant]
  
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
  let isChecked: Bool
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case userName, typeColor, isChecked
  }
}

//extension EventDTO {
//  static let sampleData: EventDTO = EventDTO(
//    id: "62c940dfa940516bebb8c668",
//    eventName: "혜정이 생파",
//    eventIcon: "BEER",
//    date: "2023-11-15",
//    participants: [
//      Participant(id: "62cc7420d7868591384e4eb0", userName: "고구마", typeColor: "GRAY", isChecked: false)
//    ]
//  )
//}
