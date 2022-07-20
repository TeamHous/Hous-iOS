//
//  File.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/15.
//

import UIKit
import Alamofire

struct TypeTestsDTO: Codable {
  let typeTests: [TypeTestDTO]
}

struct TypeTestDTO: Codable {
  let id: String
  let question: String
  let testNum: Int
  let questionImg: String
  let answers: [String]
  let questionType: String
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case question
    case testNum
    case questionImg
    case answers
    case questionType
  }
}

// updateTest
struct UpdateTestDTO: Codable {
  let id: String
  let typeId: String
  let typeScore: [Int]
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case typeId, typeScore
  }
}
