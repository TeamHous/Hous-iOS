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
  let userName: String
  let job: String
  let introduction: String
  let hashTag: [String]
  let typeId: String
  let typeName: String
  let typeColor: String
  let typeScore: [Int]
  let notificationState: Bool?
  
  enum CodingKeys: String, CodingKey {
    case userName
    case job
    case introduction
    case hashTag
    case typeName
    case typeId
    case typeColor
    case typeScore
    case notificationState
  }
}
