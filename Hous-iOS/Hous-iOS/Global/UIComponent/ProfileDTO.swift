//
//  ProfileDTO.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/18.
//

import UIKit
import Alamofire

// user/profile

struct ProfileDTO: Codable {
  let userName, job, introduction: String
  let hashTag: [String]
  let typeName, typeColor: String
  let typeScore: [Int]
  let notificationState: Bool
  
  enum CodingKeys: String, CodingKey {
    case userName
    case job
    case introduction
    case hashTag
    case typeName
    case typeColor
    case typeScore
    case notificationState
  }
}
