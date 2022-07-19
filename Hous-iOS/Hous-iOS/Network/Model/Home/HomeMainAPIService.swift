//
//  HomeMainAPIService.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/18.
//

import Foundation
import Alamofire

struct HomeMainAPIService {
  static let shared = HomeMainAPIService()
  private init() {}
}

extension HomeMainAPIService {
  
  func requestGetHomeMain(roomId: String, completion: @escaping (NetworkResult<HomeDTO>) -> Void) {
    
    let target = HomeMainAPITarget.getHomeMain(roomId: roomId)
    AF.request(target)
      .responseData { dataResponse in
        responseData(dataResponse, completion: completion)
      }
  }
  
  func requestGetEventDetail(roomId: String, eventId: String, completion: @escaping (NetworkResult<EventDTO>) -> Void) {
    
    let target = HomeMainAPITarget.getEventDetail(roomId: roomId, eventId: eventId)
    AF.request(target)
      .responseData { dataResponse in
        responseData(dataResponse, completion: completion)
      }
  }
  
  func requestPostNewEvent(roomId: String, eventName: String, eventIcon: String, date: String, participants: [String], completion: @escaping (NetworkResult<CreateEventDTO>) -> Void) {
    
    let target = HomeMainAPITarget.postNewEvent(roomId: roomId, eventName: eventName, eventIcon: eventIcon, date: date, participants: participants)
    
    AF.request(target)
      .responseData { dataResponse in
        responseData(dataResponse, completion: completion)
      }
  }
  
  func requestUpdateEventDetail(roomId: String, eventId: String, eventName: String, eventIcon: String, participants: [String], date: String, completion: @escaping (NetworkResult<CreateEventDTO>) -> Void) {
    
    let target = HomeMainAPITarget.updateEventDetail(roomId: roomId, eventId: eventId, eventName: eventName, eventIcon: eventIcon, participants: participants, date: date)
    AF.request(target)
      .responseData { dataResponse in
        responseData(dataResponse, completion: completion)
      }
  }
  
  func requestDeleteEvent(roomId: String, eventId: String, completion: @escaping (NetworkResult<CreateEventDTO>) -> Void) {
    
    let target = HomeMainAPITarget.deleteEvent(roomId: APIConstants.roomID, eventId: eventId)
    AF.request(target)
      .responseData { dataResponse in
        responseWithNoData(dataResponse, completion: completion)
      }
  }
  
}

extension HomeMainAPIService {
  
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
