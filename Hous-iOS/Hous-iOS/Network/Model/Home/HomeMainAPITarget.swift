//
//  HomeMainAPITarget.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/18.
//

import Alamofire
import UIKit

enum HomeMainAPITarget {
  case getHomeMain(roomId: String)
  case getEventDetail(roomId: String, eventId: String)
  case postNewEvent(roomId: String, eventName: String, eventIcon: String, date: String, participants: [String])
}

extension HomeMainAPITarget: TargetType {
  var method: HTTPMethod {
    switch self {
    case .getHomeMain, .getEventDetail:
      return .get
    case .postNewEvent:
      return .post
    }
  }
  
  var path: String {
    switch self {
    case .getHomeMain(let roomId):
      return "/room/\(roomId)/home"
    case .getEventDetail(let roomId, let eventId):
      return "/room/\(roomId)/event/\(eventId)"
    case .postNewEvent(let roomId, _, _, _, _):
      return "/room/\(roomId)/event"
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .getHomeMain, .getEventDetail:
      return .requestPlain
    case .postNewEvent(_, let eventName, let eventIcon, let date, let participants):
      let body: [String: Any] = [
        "eventName": eventName,
        "eventIcon": eventIcon,
        "date": date,
        "participants": participants
      ]
      return .requestBody(body)
    }
  }
  
  var header: HeaderType {
    return .auth
  }
}
