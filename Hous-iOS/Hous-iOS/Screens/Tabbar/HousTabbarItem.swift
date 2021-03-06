//
//  HousTabbarItem.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/07.
//

import UIKit


enum HousTabbarItem: String, CaseIterable {
  case home
  case rules
  case profile
}

extension HousTabbarItem {
  var viewController: UIViewController {
    switch self {
    case .home:
      return UINavigationController(rootViewController: HomeViewController())
    case .rules:
      return UINavigationController(rootViewController: RulesViewController())
    case .profile:
      return UINavigationController(rootViewController: ProfileViewController(item: .profile))
    }
  }

  var icon: UIImage? {
    switch self {
    case .home:
      return R.Image.homeTabUnselected.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
    case .rules:
      return R.Image.rulesTabUnselected.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
    case .profile:
      return R.Image.profileTabUnselected.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
    }
  }

  var selectedIcon: UIImage? {
    switch self {
    case .home:
      return R.Image.homeTabSelected
    case .rules:
      return R.Image.rulesTabSelected
    case .profile:
      return R.Image.profileTabSelected
    }
  }

  var name: String {
    return self.rawValue.capitalized
  }
}

