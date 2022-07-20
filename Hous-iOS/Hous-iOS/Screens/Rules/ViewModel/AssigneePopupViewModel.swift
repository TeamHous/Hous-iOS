//
//  AssigneePopupViewModel.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/20.
//

import Foundation

class AssigneePopupViewModel {

  func getTodayTodoAssignee(roomId: String, ruleId: String, completion: @escaping (TodayTodoAssigneeDTO) -> Void) {
    RulesMainAPIService.shared.requestGetTodayTodoAssignee(roomId: roomId, ruleId: ruleId) { result in

      if let responseResult = NetworkResultFactory.makeResult(resultType: result)
          as? Success<TodayTodoAssigneeDTO> {
        guard let response = responseResult.response else { return }
        completion(response)
      } else {
        let responseResult = NetworkResultFactory.makeResult(resultType: result)
        responseResult.resultMethod()
      }
    }
  }

  func updateTodayTodoAssignee(roomId: String, ruleId: String, tmpRuleMembers: [String], completion: @escaping () -> Void) {
    RulesMainAPIService.shared.requestUpdateTodayTodoAssignee(roomId: roomId, ruleId: ruleId, tmpRuleMembers: tmpRuleMembers) { result in

      if NetworkResultFactory.makeResult(resultType: result)
          is Success<UpdateTodayTodoAssigneeDTO> {
        completion()
      } else {
        let responseResult = NetworkResultFactory.makeResult(resultType: result)
        responseResult.resultMethod()
      }
    }
  }
}
