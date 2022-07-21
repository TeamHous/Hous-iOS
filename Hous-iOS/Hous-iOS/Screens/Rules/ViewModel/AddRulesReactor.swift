//
//  AddRulesReactor.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/15.
//

import RxSwift
import RxCocoa
import ReactorKit

final class AddRulesReactor: Reactor {


  let initialState = State()

  enum Action {
    case viewWillAppear
    case didTapKeyRuleButton

    case didTapPlusButton([String])

  }

  enum Mutation {

    case setCategories([String])
    case setInitialMembers([String])
    case setRemainingMember([String])
    case setSelectedKeyRule

    case addRulesMember([String])

  }

  struct State {
    var ruleName: String = ""
    var catergories: [String] = []
    var initialMembers: [String] = []



    var isSelectedKeyRule = false
    var isEnabledKeyRule = true
    var isEnabledPlus = true


    var remainingMembers: [String] = []

  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {

    case .viewWillAppear:

      return Observable.concat([
        .just(Mutation.setCategories(["청소", "서재청소", "주방청소", "화장실청소", "거실청소", "침소청소"])),
        .just(Mutation.setInitialMembers(["김호세", "김민재", "이의진", "김지현", "iOS"])),
        .just(Mutation.setRemainingMember(["김호세", "김민재", "이의진", "김지현", "iOS"]))
      ])

    case .didTapKeyRuleButton:
      return Observable.just(Mutation.setSelectedKeyRule)

    case .didTapPlusButton(let members):
      return Observable.just(Mutation.addRulesMember(members))


    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {

    case .setCategories(let categories):
      newState.catergories = categories

    case .setInitialMembers(let initialMembers):
      newState.initialMembers = initialMembers

    case .setRemainingMember(let remainingMembers):
      newState.remainingMembers = remainingMembers

    case .setSelectedKeyRule:
      newState.isSelectedKeyRule = !(newState.isSelectedKeyRule)

    case .addRulesMember(let members):
      newState.remainingMembers = members

    }

    return newState
  }
}


struct Homie {
  let homieName: String
  let index: String
  let day: [Day]
}
