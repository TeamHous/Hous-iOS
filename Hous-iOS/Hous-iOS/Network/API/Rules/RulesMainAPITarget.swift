//
//  RulesMainAPITarget.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/17.
//

import Alamofire
import UIKit

enum RulesMainAPITarget {
  case getRulesTodayTodo(roomId: String)
  case getRulesMyTodo(roomId: String)
  case updateMyTodoState(roomId: String, ruleId: String, isCheck: Bool)
  case getTodayTodoAssignee(roomId: String, ruleId: String)
  case updateTodayTodoAssignee(roomId: String, ruleId: String, tmpRuleMembers: [String])
  case getRulesByCategory(roomId: String, categoryId: String, status: Int, success: Bool, message: String, data: String)
  case postNewCategory(roomId: String, categoryName: String, categoryIcon: String)
  case updateCategory(roomId: String, eventId: String, email: String, password: String, userName: String, gender: String, birthday: String)
  case deleteCategory(roomId: String, eventId: String)
}

extension RulesMainAPITarget: TargetType {

  var method: HTTPMethod {
    switch self {
    case .getRulesTodayTodo, .getRulesMyTodo, .getTodayTodoAssignee, .getRulesByCategory:
      return .get
    case .postNewCategory:
      return .post
    case .updateMyTodoState, .updateTodayTodoAssignee, .updateCategory:
      return .put
    case .deleteCategory:
      return .delete
    }
  }
  
  var path: String {
    switch self {
    case .getRulesTodayTodo(let roomId):
      return "/room/\(roomId)/rules"

    case .getRulesMyTodo(let roomId):
      return "/room/\(roomId)/rules/me"

    case .updateMyTodoState(let roomId, let ruleId, _):
      return "/room/\(roomId)/rule/\(ruleId)/check"

    case .getTodayTodoAssignee(let roomId, let ruleId):
      return "/room/\(roomId)/rule/\(ruleId)/today"

    case .updateTodayTodoAssignee(let roomId, let ruleId, _):
      return "/room/\(roomId)/rule/\(ruleId)/today"

    case .getRulesByCategory(let roomId, let categoryId, _,_,_,_):
      return "/room/\(roomId)/category/\(categoryId)/rule"

    case .postNewCategory(let roomId, _,_):
      return "/room/\(roomId)/rule/category"

    case .updateCategory(let roomId, let eventId, _,_,_,_,_):
      return "/room/\(roomId)/event/\(eventId)"

    case .deleteCategory(let roomId, let eventId):
      return "/room/\(roomId)/event/\(eventId)"
    }
  }

  var parameters: RequestParams {
    switch self {
    case .getRulesTodayTodo, .getRulesMyTodo, .getTodayTodoAssignee, .getRulesByCategory, .deleteCategory:
      return .requestPlain
    case .updateMyTodoState(_,_, let isCheck):
      let body: [String: Any] = [
        "isCheck": isCheck
      ]
      return .requestBody(body)
    case .updateTodayTodoAssignee(_,_, let tmpRuleMembers):
      let body: [String: Any] = [
        "tmpRuleMembers": tmpRuleMembers
      ]
      return .requestBody(body)
    case .postNewCategory(_, let categoryName, let categoryIcon):
      let body: [String: Any] = [
        "categoryName": categoryName,
        "categoryIcon": categoryIcon
      ]
      return .requestBody(body)
    case .updateCategory(_,_, let email, let password, let userName, let gender, let birthday):
      let body: [String: Any] = [
        "email": email,
        "password": password,
        "userName": userName,
        "gender": gender,
        "birthday": birthday
      ]
      return .requestBody(body)
    }
  }

  var header: HeaderType {
    return .basic
  }
}
