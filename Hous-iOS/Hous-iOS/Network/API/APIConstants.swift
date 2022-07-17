//
//  APIConstants.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/17.
//

import Foundation

struct APIConstants {
  // MARK: - Base URL
  static let baseURL = "http://13.125.139.188:8000"

  static let roomID = "62d4335e17e70062873f3d23"

  // MARK: - Home Path

  // 홈 화면 조회 GET
  static let getHomeMain = "/room/:roomId/home"
  // 이벤트 추가 POST
  static let postNewEvent = "/room/:roomId/event"
  // 이벤트 조회 GET
  static let getEventDetail = "/room/:roomId/event/:eventId"
  // 이벤트 수정 PUT
  static let updateEventDetail = "/room/:roomId/event/:eventId"
  // 이벤트 삭제 DELETE
  static let deleteEventDetail = "/room/:roomId/event/:eventId"
  // 룸메이트 프로필 조회 GET
  static let getHomieDetail = "/user/:userId"
  // 룸메이트 성향테스트 결과 조회 GET
  static let getHomieTestResult = "/user/:userId/type"

  // MARK: - Rules Path

  // 규칙 홈화면 조회 (오늘의 todo) GET
  static let getRulesTodayTodo = "/room/:roomId/rules"
  // 규칙 홈화면 조회 (나의 todo) GET
  static let getRulesMyTodo = "/room/:roomId/rules/me"
  // 오늘 나의 todo 체크/체크해제 PUT
  static let updateMyTodoState = "/room/:roomId/rule/:ruleId/check"
  // 오늘의 임시 담당자 조회 GET
  static let getTodayTodoAssignee = "/room/:roomId/rule/:ruleId/today"
  // 오늘의 임시 담당자 설정 PUT
  static let updateTodayTodoAssignee = "/room/:roomId/rule/:ruleId/today"
  // 카테고리 별 규칙 GET
  static let getRulesByCategory = "/room/:roomId/category/:categoryId/rule"
  // 규칙 카테고리 추가하기 - (후순위) POST
  static let postNewCategory = "/room/:roomId/rules/category"
  // 규칙 카테고리 수정하기 - (후순위) PUT
  static let updateCategory = "/room/:roomId/rules/category/:categoryId"
  // 규칙 카테고리 삭제하기 - (후순위) DELETE
  static let deleteCategory = "/room/:roomId/rules/category/:categoryId"

  // 규칙 생성시 불러올 정보들 GET
  static let getNewRuleInfo = "/room/:roomId/rule/new"
  // 규칙 추가 POST
  static let postNewRule = "/room/:roomId/rule"
  // 규칙 수정 시 기존 정보 조회 GET
  static let getRuleWhenUpdate = "/room/:roomId/rule/:ruleId"
  // 규칙 수정 PUT
  static let updateRule = "/room/:roomId/rule/:ruleId"
  // 규칙 삭제 DELETE
  static let deleteRule = "/room/:roomId/rule/:ruleId"

  // MARK: - Profile Path

  // 프로필 홈 화면 조회 GET
  static let getProfileMain = "/user/profile"
  // 나의 프로필 조회 GET - (후순위)
  static let getMyProfile = "/user/profile/me"
  // 나의 프로필 수정 - (후순위) PUT
  static let updateMyProfile = "/user/profile/me"
  // 성향테스트 등록 및 수정 PUT
  static let updateTest = "/user/type/test"
  // 성향테스트 과정 내용 조회 GET
  static let getTestContent = "/type/test"
  // 나의 성향테스트 결과 조회 GET
  static let getMyTestResult = "/user/me/type"
}
