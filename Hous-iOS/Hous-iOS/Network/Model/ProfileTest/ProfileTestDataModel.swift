//
//  File.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/15.
//

import UIKit

struct ProfileTestDataModel {
  let data: [TestInfoDataModel]
}

struct TestInfoDataModel {
  let id: String
  let testTitle: String
  let testIdx: Int
  let testImg: String
  let testAnswers: [String]
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case testTitle
    case testIdx
    case testImg
    case testAnswers
  }
}

extension ProfileTestDataModel {
  static let sampleData: [ProfileTestDataModel] = [
    
    ProfileTestDataModel(data: [
      TestInfoDataModel(id: "123", testTitle: "알람 소리에 눈을 뜬 당신 \n 방 안은 어떤가요?", testIdx: 1, testImg: "123", testAnswers: ["1번 테스트 선택지1", "선택지2", "선택지3"]),
      TestInfoDataModel(id: "123", testTitle: "외출 준비를 하려는데 \n 샴푸통이 비어있는 것 같다", testIdx: 2, testImg: "123", testAnswers: ["2번 테스트 선택지1", "선택지2", "선택지3"]),
      TestInfoDataModel(id: "123", testTitle: "옷을 입으려 옷장을 열었다. \n 옷장의 상태는?", testIdx: 3, testImg: "123", testAnswers: ["잠에서 일어나 친구에게 \n 스탠드 불을 줄여달라고 이야기한다", "선택지2", "선택지3"]),
      TestInfoDataModel(id: "123", testTitle: "집을 나가는 순간, 룸메이트가 \n 옷을 내밀며 냄새가 나는지 묻는다면?", testIdx: 4, testImg: "123", testAnswers: ["선택지1", "선택지2", "선택지3"]),
      TestInfoDataModel(id: "123", testTitle: "집 밖으로 나오니 \n 집 앞 공사 환경이 보인다.", testIdx: 5, testImg: "123", testAnswers: ["선택지1", "선택지2", "선택지3"]),
      TestInfoDataModel(id: "123", testTitle: "약속장소를 가는 길, \n 묘한 향이 나는 것 같다.", testIdx: 6, testImg: "123", testAnswers: ["선택지1", "선택지2", "선택지3"])
    ])
  ]
}
