//
//  Todo.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/18.
//

import Foundation

// getRulesTodayTodo
struct RulesTodayTodoDTO: Codable {
  let homeRuleCategories: [HomeRuleCategoriesDTO]
  let todayTodoRules: [TodayTodoRulesDTO]
}

struct HomeRuleCategoriesDTO: Codable {
  let id: String
  let categoryIcon: String
  let categoryName: String

  enum CodingKeys: String, CodingKey {
      case id = "_id"
      case categoryIcon, categoryName
  }
}

struct TodayTodoRulesDTO: Codable {
  let id: String
  let ruleName: String
  let todayMembersWithTypeColor: [TodayMembersWithTypeColorDTO]
  let isTmpMember: Bool
  let isAllChecked: Bool

  enum CodingKeys: String, CodingKey {
      case id = "_id"
      case ruleName, todayMembersWithTypeColor, isTmpMember,isAllChecked
  }
}

struct TodayMembersWithTypeColorDTO: Codable {
  let userName: String
  let typeColor: String
}

// getRulesMyTodo
struct RulesMyTodoDTO: Codable {
  let id: String
  let categoryIcon: String
  let ruleName: String
  let isChecked: Bool

  enum CodingKeys: String, CodingKey {
      case id = "_id"
      case categoryIcon, ruleName, isChecked
  }
}

// updateRulesMyTodoState
struct UpdateRulesMyTodoDTO: Codable {
  let isCheck: Bool
}

// getRulesByCategory
struct RulesByCategoryDTO: Codable {
  let keyRules: [KeyRulesDTO]
  let rules: [RulesDTO]
}

struct KeyRulesDTO: Codable {
  let id: String
  let ruleName: String

  enum CodingKeys: String, CodingKey {
      case id = "_id"
      case ruleName
  }
}

struct RulesDTO: Codable {
  let id: String
  let ruleName: String
  let membersCnt: Int
  let typeColors: [String]

  enum CodingKeys: String, CodingKey {
      case id = "_id"
      case ruleName, membersCnt, typeColors
  }
}

// getTodayTodoAssignee

struct TodayTodoAssigneeDTO: Codable {
  let id: String
  let homies: [Participant]
}
