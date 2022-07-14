//
//  TodoTabEnum.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/14.
//

import Foundation

enum RulesType {
  case category, todo, editCategory
}

enum TodoType {
  case todayTodo, myTodo
}

enum TodayTodoType {
  case notAssigned, manyAssinged, oneAssinged
}

enum CategoryEditType {
  case add, update
}
