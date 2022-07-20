//
//  RulesViewModel.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/12.
//

import Foundation

final class RulesViewModel {

  func getRulesTodayTodo(roomId: String, completion: @escaping (RulesTodayTodoDTO) -> Void) {
    RulesMainAPIService.shared.requestGetRulesTodayTodo(roomId: roomId) { result in

      if let responseResult = NetworkResultFactory.makeResult(resultType: result)
          as? Success<RulesTodayTodoDTO> {
        guard let response = responseResult.response else { return }
        completion(response)
      } else {
        let responseResult = NetworkResultFactory.makeResult(resultType: result)
        responseResult.resultMethod()
      }
    }
  }
}

extension RulesViewModel {

  func getRulesMyTodo(roomId: String, completion: @escaping ([RulesMyTodoDTO]) -> Void) {
    RulesMainAPIService.shared.requestGetRulesMyTodo(roomId: roomId) { result in

      if let responseResult = NetworkResultFactory.makeResult(resultType: result)
          as? Success<[RulesMyTodoDTO]> {
        guard let response = responseResult.response else { return }
        completion(response)
      } else {
        let responseResult = NetworkResultFactory.makeResult(resultType: result)
        responseResult.resultMethod()
      }
    }
  }
}

extension RulesViewModel {

  func updateRulesMyTodoState(roomId: String, ruleId: String, isCheck: Bool, completion: @escaping (UpdateRulesMyTodoDTO) -> Void) {
    RulesMainAPIService.shared.requestUpdateRulesMyTodoState(roomId: roomId, ruleId: ruleId, isCheck: isCheck) { result in

      if let responseResult = NetworkResultFactory.makeResult(resultType: result)
          as? Success<UpdateRulesMyTodoDTO> {
        guard let response = responseResult.response else { return }
        completion(response)
      } else {
        let responseResult = NetworkResultFactory.makeResult(resultType: result)
        responseResult.resultMethod()
      }
    }
  }
}

extension RulesViewModel {

  func getRulesByCategory(roomId: String, categoryId: String, completion: @escaping (RulesByCategoryDTO) -> Void) {
    RulesMainAPIService.shared.requestGetRulesByCategory(roomId: roomId, categoryId: categoryId) { result in

      if let responseResult = NetworkResultFactory.makeResult(resultType: result)
          as? Success<RulesByCategoryDTO> {
        guard let response = responseResult.response else { return }
        completion(response)
      } else {
        let responseResult = NetworkResultFactory.makeResult(resultType: result)
        responseResult.resultMethod()
      }
    }
  }
}
