//
//  ProfileMainAPITarget.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/18.
//

import Alamofire
import UIKit

enum ProfileMainAPITarget {
  case getProfile
  case getHomieDetail(userId: String)
}

extension ProfileMainAPITarget: TargetType {
  
  var method: HTTPMethod {
    switch self {
    case .getProfile, .getHomieDetail:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .getProfile:
      return "/user/profile"
    case .getHomieDetail(let userId):
      return "/user/\(userId)"
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .getProfile, .getHomieDetail:
      return .requestPlain
    }
  }
  
  var header: HeaderType {
    return .auth
  }
}
