//
//  TodoDataModel.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import Foundation

struct TodoDataModel {
  let todoString: String
  let isDone: Bool
}


extension TodoDataModel {
  static let sampleData: [TodoDataModel] = [
    TodoDataModel(todoString: "다영언니랑 마트", isDone: false),
    TodoDataModel(todoString: "거실 청소기 돌리기", isDone: false)
    //        TodoDataModel(todoString: "저녁 설거지", isDone: false)
    //        TodoDataModel(todoString: "야식 설거지", isDone: true)
    //        TodoDataModel(todoString: "급하게 산 물 청구", isDone: true)
  ]
}
