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
    case .getTestResult:
      return "/user/me/type"
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .getTestResult:
      return .requestPlain
    }
  }
  
  var header: HeaderType {
    return .auth
  }
}
