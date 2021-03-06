//
//  ProfileTestAPIService.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/20.
//

import Foundation
import Alamofire

struct ProfileTestAPIService {
  static let shared = ProfileTestAPIService()
  private init() {}
}

extension ProfileTestAPIService {
  
  func requestGetTypeTest(completion: @escaping (NetworkResult<TypeTestsDTO>) -> Void) {
    
    let target = ProfileTestAPITarget.getTestContent
    
    AF.request(target)
      .responseData { dataResponse in
        responseData(dataResponse, completion: completion)
      }
  }
  
  func requestUpdateTest(typeScore: [Int], completion: @escaping (NetworkResult<UpdateTestDTO>) -> Void) {
    
    let target = ProfileTestAPITarget.updateTest(typeScore: typeScore)
    AF.request(target)
      .responseData { dataResponse in
        responseData(dataResponse, completion: completion)
      }
  }
  
}

extension ProfileTestAPIService {
  
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
