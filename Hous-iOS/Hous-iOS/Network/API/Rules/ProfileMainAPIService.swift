//
//  ProfileMainAPIService.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/18.
//

import Foundation
import Alamofire

struct ProfileMainAPIService {
  static let shared = ProfileMainAPIService()
  private init() {}
}

extension ProfileMainAPIService {
  
  func requestGetProfileMain(completion: @escaping(NetworkResult<ProfileDTO>) -> Void) {
    let target = ProfileMainAPITarget.getProfile
    AF.request(target)
      .responseData {dataResponse in
        responseData(dataResponse, completion: completion)
      }
  }
}

extension ProfileMainAPIService {
  
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
