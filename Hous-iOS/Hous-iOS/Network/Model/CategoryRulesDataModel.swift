//
//  CategoryRulesDataModel.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/12.
//

import Foundation

struct CategoryRulesDataModel {
  let assigneeColor: [AssigneeColor]
  let assigneeCount: Int
  let ruleTitle: String
}


extension CategoryRulesDataModel {
  static let sampleData: [CategoryRulesDataModel] = [
    CategoryRulesDataModel(assigneeColor: [.blue, .green], assigneeCount: 2, ruleTitle: "거실 청소기 돌리기"),
    CategoryRulesDataModel(assigneeColor: [.blue, .green, .red, .yellow], assigneeCount: 4, ruleTitle: "저녁 거실불 점등"),
    CategoryRulesDataModel(assigneeColor: [.red], assigneeCount: 1, ruleTitle: "화장실 청소"),
    CategoryRulesDataModel(assigneeColor: [.none], assigneeCount: 0, ruleTitle: "와우와우와우")
  ]
}
