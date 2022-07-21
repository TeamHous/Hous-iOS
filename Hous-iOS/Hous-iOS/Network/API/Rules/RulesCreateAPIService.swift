//
//  RulesCreateAPIService.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/22.
//

import Foundation
import Alamofire

struct RulesCreateAPIService {
    static let shared = RulesCreateAPIService()
    private init() {}
}

extension RulesCreateAPIService {
  // 새로운 규칙 생성 시 생성뷰에 띄워야 하는 정보들
  func requestGetNewRuleInfo(roomId: String, completion: @escaping (NetworkResult<GetNewRuleInfoDTO>) -> Void) {

    let target = RulesCreateAPITarget.getNewRuleInfo(roomId: roomId)
    AF.request(target)
      .responseData { dataResponse in
        responseData(dataResponse, completion: completion)
      }
  }

  // 새로운 규칙 생성
  func requestPostNewRule(roomId: String, notificationState: Bool, ruleName: String, categoryId: String, isKeyRules: Bool, ruleMembers: [RuleMemberWhenRequest], completion: @escaping (NetworkResult<PostOrUpdateNewRuleDTO>) -> Void) {

    let target = RulesCreateAPITarget.postNewRule(roomId: roomId, notificationState: notificationState, ruleName: ruleName, categoryId: categoryId, isKeyRules: isKeyRules, ruleMembers: ruleMembers)
    AF.request(target)
      .responseData { dataResponse in
        responseData(dataResponse, completion: completion)
      }
  }

  // 규칙 수정 시 수정뷰에 띄워야 하는 정보들
  func requestGetRuleWhenUpdate(roomId: String, ruleId: String, completion: @escaping (NetworkResult<GetRuleWhenUpdateDTO>) -> Void) {

    let target = RulesCreateAPITarget.getRuleWhenUpdate(roomId: roomId, ruleId: ruleId)
    AF.request(target)
      .responseData { dataResponse in
        responseData(dataResponse, completion: completion)
      }
  }

  // 규칙 수정
  func requestUpdateRule(roomId: String, ruleId: String, notificationState: Bool, ruleName: String, categoryId: String, isKeyRules: Bool, ruleMembers: [RuleMemberWhenRequest], completion: @escaping (NetworkResult<PostOrUpdateNewRuleDTO>) -> Void) {

    let target = RulesCreateAPITarget.updateRule(roomId: roomId, ruleId: ruleId, notificationState: notificationState, ruleName: ruleName, categoryId: categoryId, isKeyRules: isKeyRules, ruleMembers: ruleMembers)
    AF.request(target)
      .responseData { dataResponse in
        responseData(dataResponse, completion: completion)
      }
  }

  // 규칙 삭제
  func requestDeleteRule(roomId: String, ruleId: String, completion: @escaping (NetworkResult<PostOrUpdateNewRuleDTO>) -> Void) {

    let target = RulesCreateAPITarget.deleteRule(roomId: roomId, ruleId: ruleId)
    AF.request(target)
      .responseData { dataResponse in
        responseData(dataResponse, completion: completion)
      }
  }
}

extension RulesCreateAPIService {

    func responseData<T: Codable>(_ dataResponse: AFDataResponse<Data>, completion: @escaping (NetworkResult<T>) -> Void) {

        switch dataResponse.result {
        case .success:
            switch dataResponse.response?.statusCode {
            case HTTPStatusCode.SERVER_ERROR.rawValue:
                completion(.serverErr)
            default:
                guard let data = dataResponse.value else { return }
                guard let decodedData = try? JSONDecoder().decode(CommonResponse<T>.self, from: data) else {
                    return completion(.pathErr)
                }

                guard let data = decodedData.data else {
                    return completion(.requestErr(decodedData.message))
                }

                completion(.success(data))
            }

        case .failure(let err):
            print(err)
            completion(.networkFail)
        }
    }

    func responseWithNoData<T: Codable>(_ dataResponse: AFDataResponse<Data>, completion: @escaping (NetworkResult<T>) -> Void) {

        switch dataResponse.result {
        case .success:

            switch dataResponse.response?.statusCode {
            case HTTPStatusCode.SERVER_ERROR.rawValue:
                completion(.serverErr)
            default:
                guard let data = dataResponse.value else { return }
                guard let decodedData = try? JSONDecoder().decode(CommonResponse<T>.self, from: data) else {
                    return completion(.pathErr)
                }
                print(decodedData.message)
                completion(.success(nil))
            }

        case .failure(let err):
            print(err)
            completion(.networkFail)
        }
    }
}
