//
//  ProfileTestAPITarget.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/20.
//

import Alamofire
import UIKit

enum ProfileTestAPITarget {
  case getTestContent
}

extension ProfileTestAPITarget: TargetType {
  var method: HTTPMethod {
    switch self {
    case .getTestContent:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .getTestContent:
      return "/type/test"
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .getTestContent:
      return .requestPlain
    }
  }
  
  var header: HeaderType {
    return .auth
  }
}
