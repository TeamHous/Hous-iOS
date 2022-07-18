//
//  ProfileMainAPITarget.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/18.
//

import Alamofire
import UIKit

enum ProfileMainAPITarget {
  case getProfileMain
}

extension ProfileMainAPITarget: TargetType {
  
  var method: HTTPMethod {
    switch self {
    case .getProfileMain:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .getProfileMain:
      return "/user/profile"
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .getProfileMain:
      return .requestPlain
    }
  }
  
  var header: HeaderType {
    return .auth
  }
}

