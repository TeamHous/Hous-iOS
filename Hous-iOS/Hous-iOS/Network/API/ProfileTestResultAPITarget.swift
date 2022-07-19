//
//  ProfileTestResultAPITarget.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/20.
//

import Alamofire
import UIKit

enum ProfileTestResultAPITarget {
  case getTestResult(typeId: String)
}

extension ProfileTestResultAPITarget: TargetType {
  
  var method: HTTPMethod {
    switch self {
    case .getTestResult:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .getTestResult(let typeId):
      return "/user/me/type/\(typeId)"
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .getTestResult(_):
      return .requestPlain
    }
  }
  
  var header: HeaderType {
    return .auth
  }
}
