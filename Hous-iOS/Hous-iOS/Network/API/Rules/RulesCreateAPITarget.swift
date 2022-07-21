//
//  RulesCreateAPITarget.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/22.
//

import Alamofire
import UIKit

enum RulesCreateAPITarget {
  case getNewRuleInfo(roomId: String)
  case postNewRule(roomId: String, notificationState: Bool, ruleName: String, categoryId: String, isKeyRules: Bool, ruleMembers: [RuleMemberWhenRequest])
  case getRuleWhenUpdate(roomId: String, ruleId: String)
  case updateRule(roomId: String, ruleId: String, notificationState: Bool, ruleName: String, categoryId: String, isKeyRules: Bool, ruleMembers: [RuleMemberWhenRequest])
  case deleteRule(roomId: String, ruleId: String)
}

extension RulesCreateAPITarget: TargetType {

  var method: HTTPMethod {
    switch self {
    case .getNewRuleInfo, .getRuleWhenUpdate:
      return .get
    case .postNewRule:
      return .post
    case .updateRule:
      return .put
    case .deleteRule:
      return .delete
    }
  }

  var path: String {
    switch self {
    case .getNewRuleInfo(let roomId):
      return "/room/\(roomId)/rule/new"

    case .postNewRule(let roomId, _,_,_,_,_):
      return "/room/\(roomId)/rule"

    case .getRuleWhenUpdate(let roomId, let ruleId):
      return "/room/\(roomId)/rule/\(ruleId)"

    case .updateRule(let roomId, let ruleId, _,_,_,_,_):
      return "/room/\(roomId)/rule/\(ruleId)"

    case .deleteRule(let roomId, let ruleId):
      return "/room/\(roomId)/rule/\(ruleId)"
    }
  }

  var parameters: RequestParams {
    switch self {
    case .getNewRuleInfo, .getRuleWhenUpdate, .deleteRule:
      return .requestPlain
    case .postNewRule(_, let notificationState, let ruleName, let categoryId, let isKeyRules, let ruleMembers),
        .updateRule(_,_, let notificationState, let ruleName, let categoryId, let isKeyRules, let ruleMembers):
      let body: [String: Any] = [
        "notificationState": notificationState,
        "ruleName": ruleName,
        "categoryId": categoryId,
        "isKeyRules": isKeyRules,
        "ruleMembers": ruleMembers
      ]
      return .requestBody(body)
    }
  }

  var header: HeaderType {
    return .auth
  }
}

