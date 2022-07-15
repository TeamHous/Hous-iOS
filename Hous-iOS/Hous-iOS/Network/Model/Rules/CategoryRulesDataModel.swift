//
//  CategoryRulesDataModel.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/12.
//

import Foundation

typealias Categories = [Category]
struct Category: Codable {
    let id, categoryName, categoryIcon: String

    enum CodingKeys: String, CodingKey {
      case id
      case categoryName = "ruleCategoryName"
      case categoryIcon = "ruleCategoryIcon"
    }
}

extension Category {
  static let sampleData: Categories = [
    Category(id: "62cc752dd7868591384e4ed4", categoryName: "다섯글자임", categoryIcon: "CLEAN"),
    Category(id: "62cc752dd7868591384e4ed4", categoryName: "하뚜하뚜", categoryIcon: "HEART"),
    Category(id: "62cc752dd7868591384e4ed4", categoryName: "커피", categoryIcon: "COFFEE"),
    Category(id: "62cc752dd7868591384e4ed4", categoryName: "팬케이크", categoryIcon: "CAKE"),
    Category(id: "62cc752dd7868591384e4ed4", categoryName: "불끄세요", categoryIcon: "LIGHT"),
    Category(id: "62cc752dd7868591384e4ed4", categoryName: "빨래", categoryIcon: "LAUNDRY")
  ]
}


// --------------------------------------------------
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
