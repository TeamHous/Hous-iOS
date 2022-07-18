//
//  HomeDataModel.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/15.
//

import Foundation

// MARK: - HomeDTO
struct HomeDTO: Codable {
  let eventList: [EventList]
  let keyRulesList: [String]
  let todoList: [TodoList]
  let homieProfileList: [HomieProfileList]
  let roomCode: String
}

// MARK: - EventList
struct EventList: Codable {
  let id: String
  let eventIcon: String
  let dDay: String
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case eventIcon, dDay
  }
}

// MARK: - HomieProfileList
struct HomieProfileList: Codable {
  let id: String
  let userName: String
  let typeName: String
  let typeColor: String
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case userName, typeName, typeColor
  }
}

// MARK: - TodoList
struct TodoList: Codable {
  let isChecked: Bool
  let ruleName: String
}

extension HomeDTO {
  static let sampleData: HomeDTO =
  HomeDTO(
    eventList: [
      EventList(id: "62cc752dd7868591384e4ed4", eventIcon: "BEER", dDay: "364")
    ],
    keyRulesList: ["상단규칙","개발개발"],
    todoList: [
      TodoList(
        isChecked: true, ruleName: "개발하기")],
    homieProfileList: [
      HomieProfileList(id: "62cc7420d7868591384e4eb0", userName: "고구마", typeName: "임시 디폴트", typeColor: "GRAY"),
      HomieProfileList(id: "62cc7420d7868512384e4eb9", userName: "김민재", typeName: "임시 디폴트", typeColor: "RED")
    ],
    roomCode: "JEVY4Q2G"
  )
}
