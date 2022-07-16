//
//  EventDTO.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/15.
//

import Foundation


// MARK: - EventDTO
struct EventDTO: Decodable {
  let id: String
  let eventName: String
  let eventIcon:String
  let date: String
  let participant: [Participant]
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case eventName, eventIcon, date, participant
  }
}

// MARK: - Participant
struct Participant: Decodable {
  let id: String
  let userName: String
  let typeIcon: String
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case userName, typeIcon
  }
}

extension EventDTO {
  static let sampleData: EventDTO = EventDTO(
    id: "62c940dfa940516bebb8c668",
    eventName: "혜정이 생파",
    eventIcon: "BEER",
    date: "2023-11-15",
    participant: [
      Participant(id: "62cc7420d7868591384e4eb0", userName: "고구마", typeIcon: "GRAY")
    ]
  )
}
