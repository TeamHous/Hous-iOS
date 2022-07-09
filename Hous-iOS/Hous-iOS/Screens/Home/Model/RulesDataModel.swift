//
//  RulesDataModel.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import Foundation

struct RulesDataModel {
  let ruleString: String
}


extension RulesDataModel {
  static let sampleData: [RulesDataModel] = [
    RulesDataModel(ruleString: "00시~불끄ㅇㄴㄹ민재민재"),
    RulesDataModel(ruleString: "23시~이어폰 필수"),
    RulesDataModel(ruleString: "세탁기는 화수토"),
    RulesDataModel(ruleString: "일 청소하는날"),
    RulesDataModel(ruleString: "2,4주 토~장보기")
  ]
}
