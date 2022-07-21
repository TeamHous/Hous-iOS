//
//  ProfileTestResultAPITarget.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/20.
//

import Alamofire
import UIKit

enum ProfileTestResultAPITarget {
  case getTestResult
  case getRoomMateTestResult (userId: String)
}

extension ProfileTestResultAPITarget: TargetType {
  
  var method: HTTPMethod {
    switch self {
    case .getTestResult:
      return .get
    
    case .getRoomMateTestResult(_):
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .getTestResult:
      return "/user/me/type"
    
    case .getRoomMateTestResult(let userId):
      return "/user/\(userId)/type"
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .getTestResult:
      return .requestPlain
    
    case .getRoomMateTestResult(_):
      return .requestPlain
    }
  }
  
  var header: HeaderType {
    return .auth
  }
}
