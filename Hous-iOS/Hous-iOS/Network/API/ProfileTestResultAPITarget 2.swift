//
//  ProfileTestResultAPITarget.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/20.
//

import Alamofire
import UIKit

enum ProfileTestResultAPITarget {
  case getProfile
}

extension ProfileTestResultAPITarget: TargetType {
  
  var method: HTTPMethod {
    switch self {
    case .getProfile:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .getProfile:
      return "/user/profile"
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .getProfile:
      return .requestPlain
    }
  }
  
  var header: HeaderType {
    return .auth
  }
}
