//
//  CreateRepository.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/22.
//

import RxSwift
import RxCocoa
import Foundation


protocol CreateRepository {
  func fetchNewRuleInfo(roomID: String) -> Observable<GetNewRuleInfoDTO>
  func addNewRuleInfo(roomId: String, notificationState: Bool, ruleName: String, categoryId: String, isKeyRules: Bool, ruleMembers: [RuleMemberWhenRequest]) -> Observable<PostOrUpdateNewRuleDTO>
}

final class CreateRepositoryImp: CreateRepository {


  func fetchNewRuleInfo(roomID: String) -> Observable<GetNewRuleInfoDTO> {
    Observable.just(())
      .flatMapLatest {
        self.newRuleInfoDTO(roomId: roomID)
      }
      .compactMap { $0 }
  }
  func addNewRuleInfo(
    roomId: String,
    notificationState: Bool,
    ruleName: String,
    categoryId: String,
    isKeyRules: Bool,
    ruleMembers: [RuleMemberWhenRequest]
  ) -> Observable<PostOrUpdateNewRuleDTO> {
    Observable.just(())
      .flatMapLatest {
        self.postNewRuleInfoDTO(
          roomId: roomId,
          notificationState: notificationState,
          ruleName: ruleName,
          categoryId: categoryId,
          isKeyRules: isKeyRules,
          ruleMembers: ruleMembers
        )
      }
      .compactMap { $0 }
  }

}


extension CreateRepositoryImp {

  private func getNewRuleInfoDTO(roomId: String, completion: @escaping (GetNewRuleInfoDTO?, NSError?) -> Void) {

    RulesCreateAPIService.shared.requestGetNewRuleInfo(roomId: roomId) { res in
      switch res {
      case .success(let t):
        completion(t, nil)
      case .networkFail:
        completion(nil, NSError())
      case .requestErr(_):
        completion(nil, NSError())
      case .serverErr:
        completion(nil, NSError())
      case .pathErr:
        completion(nil, NSError())
      }
    }
  }

  private func newRuleInfoDTO(roomId: String) -> Observable<GetNewRuleInfoDTO> {
    Observable<GetNewRuleInfoDTO>.create { [self] observer in
      getNewRuleInfoDTO(roomId: roomId) { (res, err) in
        if let err = err {
          observer.onError(err)
        }
        if let res = res {
          observer.onNext(res)
        }
      }
      return Disposables.create()
    }
  }

  private func addNewRuleInfoDTO(roomId: String, notificationState: Bool, ruleName: String, categoryId: String, isKeyRules: Bool, ruleMembers: [RuleMemberWhenRequest], completion: @escaping (PostOrUpdateNewRuleDTO?, NSError?) -> Void) {

    RulesCreateAPIService.shared.requestPostNewRule(roomId: roomId, notificationState: notificationState, ruleName: ruleName, categoryId: categoryId, isKeyRules: isKeyRules, ruleMembers: ruleMembers) { res in
      switch res {
      case .success(let t):
        completion(t, nil)
      case .networkFail:
        completion(nil, NSError())
      case .requestErr(_):
        completion(nil, NSError())
      case .serverErr:
        completion(nil, NSError())
      case .pathErr:
        completion(nil, NSError())
      }
    }
  }

  private func postNewRuleInfoDTO(roomId: String, notificationState: Bool, ruleName: String, categoryId: String, isKeyRules: Bool, ruleMembers: [RuleMemberWhenRequest]) -> Observable<PostOrUpdateNewRuleDTO> {
    Observable<PostOrUpdateNewRuleDTO>.create { [self] observer in
      addNewRuleInfoDTO(
        roomId: roomId,
        notificationState: notificationState,
        ruleName: ruleName,
        categoryId: categoryId,
        isKeyRules: isKeyRules,
        ruleMembers: ruleMembers
      ) { (res, err) in
        if let err = err {
          observer.onError(err)
        }
        if let res = res {
          observer.onNext(res)
        }
      }
      return Disposables.create()
    }
  }





}



//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYyZDk0YWQwMjczN2JjNzM1ZjA2NDI5OSJ9LCJpYXQiOjE2NTg0MDc2MzIsImV4cCI6MTY2MDk5OTYzMn0.YAIpqy2bIPyUs9SsF1QBrNco6aAiNpR4lfYjgacW3qs

//62d94af52737bc735f0642c8
