//
//  File.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/15.
//

import UIKit
import Alamofire

struct ProfileTestDTO: Decodable {
  let data: TestsListDTO
}

struct TestsListDTO: Decodable {
  let typeTest: [TestInfoDTO]
}

struct TestInfoDTO: Decodable {
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

extension ProfileTestDTO {
  static let sampleData: ProfileTestDTO = ProfileTestDTO(data: TestsListDTO(typeTest: [
    TestInfoDTO(id: "123", question: "알람 소리에 눈을 뜬 당신 \n 방 안은 어떤가요?", testNum: 1, questionImg: "123", answers: ["1번 테스트 선택지1", "선택지2", "선택지3"], questionType: "LIGHT"),
    TestInfoDTO(id: "123", question: "외출 준비를 하려는데 \n 샴푸통이 비어있는 것 같다", testNum: 2, questionImg: "123", answers: ["2번 테스트 선택지1", "선택지2", "선택지3"], questionType: "NOISE"),
    TestInfoDTO(id: "123", question: "옷을 입으려 옷장을 열었다. \n 옷장의 상태는?", testNum: 3, questionImg: "123", answers: ["잠에서 일어나 친구에게 \n 스탠드 불을 줄여달라고 이야기한다", "선택지2", "선택지3"], questionType: "SMELL"),
    TestInfoDTO(id: "123", question: "집을 나가는 순간, 룸메이트가 \n 옷을 내밀며 냄새가 나는지 묻는다면?", testNum: 4, questionImg: "123", answers: ["선택지1", "선택지2", "선택지3"], questionType: "PERSONALITY"),
    TestInfoDTO(id: "123", question: "약속장소를 가는 길, \n 묘한 향이 나는 것 같다.", testNum: 5, questionImg: "123", answers: ["선택지1", "선택지2", "선택지3"], questionType: "CLEAN"),
    TestInfoDTO(id: "123", question: "ddddddddddd, \n 묘한 향이 나는 것 같다.", testNum: 5, questionImg: "123", answers: ["선택지1", "선택지2", "선택지3"], questionType: "CLEAN"),
    TestInfoDTO(id: "123", question: "rrrrrrrrrrr, \n 묘한 향이 나는 것 같다.", testNum: 5, questionImg: "123", answers: ["선택지1", "선택지2", "선택지3"], questionType: "CLEAN"),
  ]))
}
