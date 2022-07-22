//
//  TodoCreate.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/22.
//

import Foundation

struct RuleMemberWhenRequest {
  let userId: String
  let day: [Int]
}

// getNewRuleInfo (새로운 규칙 추가 시 뷰에 띄워야 하는 정보들)

struct GetNewRuleInfoDTO: Codable, Equatable {
  static func == (lhs: GetNewRuleInfoDTO, rhs: GetNewRuleInfoDTO) -> Bool {
    return (lhs.ruleCategories == rhs.ruleCategories) && (lhs.homies == rhs.homies)
  }

  let ruleCategories: [RuleCategoryDTO]
  let homies: [HomieDTO]


}

struct RuleCategoryDTO: Codable,Equatable {
  let id: String
  let categoryName: String

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case categoryName
  }
}

struct HomieDTO: Codable, Equatable, Hashable {
  let id: String
  let userName: String
  let typeColor: String

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case userName, typeColor
  }
}

// postNewRule & updateRule (새로운 규칙 추가 시 혹은 규칙 수정 시)
struct PostOrUpdateNewRuleDTO: Codable {
  let roomID: String
  let categoryID: String
  let ruleName: String
  let ruleMembers: [RuleMemberWhenNewDTO]
  let tmpRuleMembers: [String]
  let isKeyRules: Bool
  let notificationState: Bool
  let tmpUpdatedDate: String
  let id: String
  let createdAt: String
  let updatedAt: String
  let v: Int

  enum CodingKeys: String, CodingKey {
    case roomID = "roomId"
    case categoryID = "categoryId"
    case ruleName, ruleMembers, tmpRuleMembers, isKeyRules, notificationState, tmpUpdatedDate
    case id = "_id"
    case createdAt, updatedAt
    case v = "__v"
  }
}

struct RuleMemberWhenNewDTO: Codable {
  let userID: String?
  let day: [Int]
  let id: String?

  enum CodingKeys: String, CodingKey {
    case userID = "userId"
    case day
    case id = "_id"
  }
}

// getRuleWhenUpdate (규칙 수정 시 수정 뷰에 띄워야 하는 정보들)

struct GetRuleWhenUpdateDTO: Codable {
  let rule: RuleDTO
  let ruleCategories: [RuleCategoryDTO]
  let homies: [HomieDTO]
}

struct RuleDTO: Codable {
  let id: String
  let notificationState: Bool
  let ruleName: String
  let ruleCategory: RuleCategoryDTO
  let isKeyRules: Bool
  let ruleMembers: [RuleMemberWhenUpdateDTO]
}

struct RuleMemberWhenUpdateDTO: Codable {
  let homies: HomieDTO
  let day: [Int]
}
