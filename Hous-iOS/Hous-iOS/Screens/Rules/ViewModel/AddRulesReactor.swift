//
//  AddRulesReactor.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/15.
//

import RxSwift
import RxCocoa
import ReactorKit
import Foundation

final class AddRulesReactor: Reactor {


  let initialState = State()

  private let createRuleRepository = CreateRepositoryImp()

  enum Action {
    case viewWillAppearCategories
    case viewWillAppearInitialMember
    case viewWillAppearRemainingMember

    case didTapKeyRuleButton
    case didTapPlusButton([HomieDTO])
    case didTapAdd

  }

  enum Mutation {

    case setCategories([RuleCategoryDTO])
    case setInitialMembers([HomieDTO])
    case setRemainingMember([HomieDTO])
    case setSelectedKeyRule
    case addRulesMember([HomieDTO])
    case setLoading(Bool)
    case setError(Error)
    case setIsEnabledAdd
    case setBack(Bool)
  }

  struct State {
    var ruleName: String = ""
    var catergories: [RuleCategoryDTO] = []
    var initialMembers: [HomieDTO] = []
    var isSelectedKeyRule = false
    var isEnabledKeyRule = true
    var isEnabledPlus = true
    var isEnableAdd = false
    var remainingMembers: [HomieDTO] = []
    var isLoading = false

    var back: Bool = false

  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {

    case .viewWillAppearCategories:
      return getCategories(roomID: APIConstants.roomID)

    case .viewWillAppearInitialMember:
      return getInitialMember(roomID: APIConstants.roomID)

    case .viewWillAppearRemainingMember:
      return getRemainMember(roomID: APIConstants.roomID)

    case .didTapKeyRuleButton:
      return Observable.concat([
        Observable.just(Mutation.setSelectedKeyRule),
        Observable.just(Mutation.setIsEnabledAdd)
      ])

    case .didTapPlusButton(let members):

      return Observable.concat([
        Observable.just(Mutation.addRulesMember(members)),
        Observable.just(Mutation.setIsEnabledAdd)
      ])

    case .didTapAdd:
      return .just(Mutation.setBack(true))
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

    case .setError(_):
      newState = state

    case .setLoading(let isLoading):

      newState.isLoading = isLoading

    case .setIsEnabledAdd:

      if newState.isSelectedKeyRule {
        newState.isEnableAdd = true
      } else {
        newState.isEnableAdd = (newState.remainingMembers.count == newState.initialMembers.count) ? false : true

        print(newState.remainingMembers.count, newState.initialMembers.count)
      }
    case .setBack(let back):
      newState.back = back
      break
    }

    return newState
  }
}


extension AddRulesReactor {
  func getInitialMember(roomID: String) -> Observable<Mutation> {

    return createRuleRepository.fetchNewRuleInfo(roomID: roomID)
      .asObservable()
      .flatMap {
        Observable.just(Mutation.setInitialMembers($0.homies))
      }
      .catch { err -> Observable<Mutation> in
        return Observable.just(Mutation.setError(err))
      }
  }

  func getRemainMember(roomID: String) -> Observable<Mutation> {

    return createRuleRepository.fetchNewRuleInfo(roomID: roomID)
      .asObservable()
      .flatMap {

        Observable.just(Mutation.setRemainingMember($0.homies))
      }
      .catch { err -> Observable<Mutation> in
        return Observable.just(Mutation.setError(err))
      }
  }

  func getCategories(roomID: String) -> Observable<Mutation> {

    return createRuleRepository.fetchNewRuleInfo(roomID: roomID)
      .asObservable()
      .flatMap {

        Observable.just(Mutation.setCategories($0.ruleCategories))
      }
      .catch { err -> Observable<Mutation> in
        return Observable.just(Mutation.setError(err))
      }
  }

}

