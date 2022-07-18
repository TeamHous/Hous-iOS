//
//  RulesViewModel.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/12.
//

import Foundation
import RxSwift
import RxCocoa

//class RulesViewModel {
//
//  let rulesTodayTodoData = PublishSubject<RulesTodayTodoDTO>()
//
//  struct Input {
//    let todayTodoButtonTap : ControlProperty<Void>
//    let myTodoButtonTap: ControlEvent<Void>
//  }
//
//  struct Output {
//    let genderSelected: Observable<GenderFilter>
//    let todoButtonClicked: ControlEvent<Void>
//  }
//
//
//  return Output(genderSelected: genderObservable, floatingButtonClicked: floatingObservable)
//}
//
//func getRulesTodayTodo() {
//  RulesMainAPIService.shared.requestGetRulesTodayTodo(roomId: APIConstants.roomID) { result in
//
//    if let responseResult = NetworkResultFactory.makeResult(resultType: result)
//        as? Success<RulesTodayTodoDTO> {
//      rulesTodayTodoData = responseResult.response ??
//      RulesTodayTodoDTO(homeRuleCategories: [], todayTodoRules: [])
//
//      print(rulesTodayTodoData)
//    } else {
//      let responseResult = NetworkResultFactory.makeResult(resultType: result)
//      responseResult.resultMethod()
//    }
//
//  }
//}
