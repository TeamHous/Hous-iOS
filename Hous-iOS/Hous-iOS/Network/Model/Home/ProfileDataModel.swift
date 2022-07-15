//
//  ProfileDataModel.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import Foundation

struct ProfileDataModel {
  let profileName: String
  let isTested: Bool
}


extension ProfileDataModel {
  static let sampleData: [ProfileDataModel] = [
    ProfileDataModel(profileName: "김민재", isTested: false),
    ProfileDataModel(profileName: "김지현", isTested: false),
    ProfileDataModel(profileName: "김호세", isTested: true),
    ProfileDataModel(profileName: "이의진", isTested: true),
  ]
}
