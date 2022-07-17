//
//  Todo.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/18.
//

import Foundation

// getRulesTodayTodo
struct RulesTodayTodoDTO: Codable {
  let homeRuleCategories: HomeRuleCategoriesDTO
  let todayTodoRules: TodayTodoRulesDTO
}

struct HomeRuleCategoriesDTO: Codable {
  let id: String
  let categoryIcon: String
  let categoryName: String
}

struct TodayTodoRulesDTO: Codable {
  let id: String
  let ruleName: String
  let todayMemberWithTypeColor: [TodayMembersWithTypeColorDTO]
  let isTmpMember: Bool
  let isAllChecked: Bool
}

struct TodayMembersWithTypeColorDTO: Codable {
  let userName: String
  let typeColor: String
}

