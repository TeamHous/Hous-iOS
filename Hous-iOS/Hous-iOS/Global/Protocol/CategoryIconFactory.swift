//
//  CategoryIconFactory.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/15.
//

import UIKit

enum CategoryIconImage: String {
  case light, cake, beer, coffee, clean, trash, heart, laundry
}

protocol CategoryIconProtocol {
  var unCheckedImage: UIImage { get set }
  var checkedImage: UIImage { get set }
}

struct CategoryLightIcon: CategoryIconProtocol {
  var unCheckedImage = R.Image.light
  var checkedImage = R.Image.lightChecked
}

struct CategoryCakeIcon: CategoryIconProtocol {
  var unCheckedImage = R.Image.cake
  var checkedImage = R.Image.cakeChecked
}

struct CategoryBeerIcon: CategoryIconProtocol {
  var unCheckedImage = R.Image.beer
  var checkedImage = R.Image.beerChecked
}

struct CategoryCoffeeIcon: CategoryIconProtocol {
  var unCheckedImage = R.Image.coffee
  var checkedImage = R.Image.coffeeChecked
}

struct CategoryCleanIcon: CategoryIconProtocol {
  var unCheckedImage = R.Image.clean
  var checkedImage = R.Image.cleanChecked
}

struct CategoryTrashIcon: CategoryIconProtocol {
  var unCheckedImage = R.Image.trash
  var checkedImage = R.Image.trashChecked
}

struct CategoryHeartIcon: CategoryIconProtocol {
  var unCheckedImage = R.Image.heart
  var checkedImage = R.Image.heartChecked
}

struct CategoryLaundryIcon: CategoryIconProtocol {
  var unCheckedImage = R.Image.laundry
  var checkedImage = R.Image.laundryChecked
}

struct CategoryIconFactory {
  static func makeIcon(type: CategoryIconImage) -> CategoryIconProtocol {
    switch type {
    case .light:
      return CategoryLightIcon()
    case .cake:
      return CategoryCakeIcon()
    case .beer:
      return CategoryBeerIcon()
    case .coffee:
      return CategoryCoffeeIcon()
    case .clean:
      return CategoryCleanIcon()
    case .trash:
      return CategoryTrashIcon()
    case .heart:
      return CategoryHeartIcon()
    case .laundry:
      return CategoryLaundryIcon()
    }
  }
}
