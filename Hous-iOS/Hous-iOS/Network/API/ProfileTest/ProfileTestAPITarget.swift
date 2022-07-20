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
  case updateTest(typeScore: [Int])
}

extension ProfileTestAPITarget: TargetType {
  var method: HTTPMethod {
    switch self {
    case .getTestContent:
      return .get
    case .updateTest(_):
      return .put
    }
  }
  
  var path: String {
    switch self {
    case .getTestContent:
      return "/type/test"
    case .updateTest(_):
      return "/user/type/test"
    }
  }
  
  var parameters: RequestParams {
    switch self {
    case .getTestContent:
      return .requestPlain
    case .updateTest(let typeScore):
      let body: [String: Any] = [
        "typeScore": typeScore
      ]
      return .requestBody(body)
    }
  }
  
  var header: HeaderType {
    return .auth
  }
}
