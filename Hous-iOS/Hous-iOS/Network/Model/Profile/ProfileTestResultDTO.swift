//
//  ProfileTestResultDTO.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/18.
//

import UIKit
import Alamofire

// user/me/type
struct ProfileTestResultDTO: Codable {
  let userName, typeName, typeColor: String
  let typeImg: String
  let typeOneComment, typeDesc, typeRulesTitle: String
  let typeRules: [String]
  let good : Good
  let bad : Bad
}

struct Good: Codable {
  let typeName: String
  let typeImg: String
}

struct Bad: Codable {
  let typeName: String
  let typeImg: String
}



