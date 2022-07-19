//
//  RulesViewModel.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/12.
//

import Foundation

class RulesViewModel {

  func getRulesTodayTodo(completion: @escaping (RulesTodayTodoDTO) -> Void) {
    RulesMainAPIService.shared.requestGetRulesTodayTodo(roomId: APIConstants.roomID) { result in

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

  func getRulesMyTodo(completion: @escaping ([RulesMyTodoDTO]) -> Void) {
    RulesMainAPIService.shared.requestGetRulesMyTodo(roomId: APIConstants.roomID) { result in

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
    RulesMainAPIService.shared.requestUpdateRulesMyTodoState(roomId: APIConstants.roomID, ruleId: ruleId, isCheck: isCheck) { result in

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
