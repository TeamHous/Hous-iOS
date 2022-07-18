//
//  RulesMainAPIService.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/18.
//

import Foundation
import Alamofire

struct RulesMainAPIService {
    static let shared = RulesMainAPIService()
    private init() {}
}

extension RulesMainAPIService {
  // 여기에 실질적 서버통신 코드 구현
  func requestGetRulesTodayTodo(roomId: String, completion: @escaping (NetworkResult<RulesTodayTodoDTO>) -> Void) {

    let target = RulesMainAPITarget.getRulesTodayTodo(roomId: roomId)
    AF.request(target)
      .responseData { dataResponse in
        responseData(dataResponse, completion: completion)
      }
  }
}

extension RulesMainAPIService {

    func responseData<T: Codable>(_ dataResponse: AFDataResponse<Data>, completion: @escaping (NetworkResult<T>) -> Void) {

        switch dataResponse.result {
        case .success:
            switch dataResponse.response?.statusCode {
            case HTTPStatusCode.SERVER_ERROR.rawValue:
                completion(.serverErr)
            default:
                guard let data = dataResponse.value else { return }
                guard let decodedData = try? JSONDecoder().decode(CommonResponse<T>.self, from: data) else {
                  print("대체왜")
                    return completion(.pathErr)
                }

                guard let data = decodedData.data else {
                  print("여기로온듯?")
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
