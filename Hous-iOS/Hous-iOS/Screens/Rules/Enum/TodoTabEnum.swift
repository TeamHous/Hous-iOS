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

  var popupTitleText: String {
    switch self {
    case .add:
      return "작성 취소"
    case .update:
      return "카테고리 삭제"
    }
  }

  var popupDescriptionText: String {
    switch self {
    case .add:
      return "이 화면을 벗어나면\n작성한 내용이 모두 취소됩니다."
    case .update:
      return "이 카테고리를 삭제하면 포함된 규칙이\n모두 사라집니다. 계속 진행 하시겠습니까?"
    }
  }

  var popupButtonText: String {
    switch self {
    case .add:
      return "작성 취소하기"
    case .update:
      return "삭제"
    }
  }

  var editViewTitleText: String {
    switch self {
    case .add:
      return "새로운 카테고리 추가"
    case .update:
      return "카테고리 수정"
    }
  }

  var editViewBorderButtonText: String {
    switch self {
    case .add:
      return "작성 취소"
    case .update:
      return "삭제하기"
    }
  }

  var editViewFilledButtonText: String {
    switch self {
    case .add:
      return "추가하기"
    case .update:
      return "저장하기"
    }
  }

}
