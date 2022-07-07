//
//  HousTabbarItem.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/07.
//

import UIKit


enum HousTabbarItem: String, CaseIterable {
  case home
  case rulse
  case profile
}

extension HousTabbarItem {
  var viewController: UIViewController {
    switch self {
    case .home:
      return UINavigationController(rootViewController: ViewController(item: .home))
    case .rulse:
      return UINavigationController(rootViewController: ViewController(item: .rulse))
    case .profile:
      return UINavigationController(rootViewController: ViewController(item: .profile))
    }
  }

  var icon: UIImage? {
    switch self {
    case .home:
      return UIImage(systemName: "magnifyingglass.circle")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
    case .rulse:
      return UIImage(systemName: "heart.circle")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
    case .profile:
      return UIImage(systemName: "person.crop.circle")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
    }
  }

  var selectedIcon: UIImage? {
    switch self {
    case .home:
      return UIImage(systemName: "magnifyingglass.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    case .rulse:
      return UIImage(systemName: "heart.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    case .profile:
      return UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    }
  }

  var name: String {
    return self.rawValue.capitalized
  }
}

