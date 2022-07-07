//
//  Strings.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/07.
//

import Foundation

// MARK: - Localization bundle setup

class BundleClass {}

public struct Strings {
  public static let bundle = Bundle(for: BundleClass.self)
}

// Used as a helper enum to keep track of what app version strings were last updated in.

// 버전 관리
private enum StringLastUpdatedAppVersion {
  case v01
}

// MARK: - Localization helper function
private func HousLocalizedString(_ key: String, tableName: String? = nil, value: String = "", comment: String, lastUpdated: StringLastUpdatedAppVersion) -> String {
  return NSLocalizedString(key, tableName: tableName, bundle: Strings.bundle, value: value, comment: comment)
}

extension String {
  public struct Alerts {
  }
}

extension String {
  struct Home {
    static let HomeHI = HousLocalizedString("HomeHI", comment: "그냥 테스트용", lastUpdated: .v01)
    // 다국어 지원안하고 걍 일단 밸류값 때려넣을 수도 있음 (string 한번에 모아두기)
    static let HomeBye = HousLocalizedString("HomeBye", value: "그냥 바이", comment: "그냥테스트용2", lastUpdated: .v01)
  }
  struct Profile {
//    static let sdgsdfgsg = HousLocalizedString("adsd", comment: "그냥 테스트용", lastUpdated: .v01)
  }
}
