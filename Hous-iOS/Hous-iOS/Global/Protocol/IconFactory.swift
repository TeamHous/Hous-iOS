//
//  IconFactory.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/14.
//

import UIKit

enum IconImage: String {
  case party, cake, beer, coffee
}

protocol IconProtocol {
  var bigIconImage: UIImage { get set }
  var smallIconImage: UIImage { get set }
}

struct PartyIcon: IconProtocol {
  var bigIconImage = R.Image.partyYellow
  var smallIconImage = R.Image.partyFrameFixed
}

struct CakeIcon: IconProtocol {
  var bigIconImage = R.Image.cakeYellow
  var smallIconImage = R.Image.cakeFrameFixed
}

struct BeerIcon: IconProtocol {
  var bigIconImage = R.Image.beerYellow
  var smallIconImage = R.Image.beerYellowSmall
}

struct CoffeeIcon: IconProtocol {
  var bigIconImage = R.Image.coffeeYellow
  var smallIconImage = R.Image.coffeeFrameFixed
}

struct IconFactory {
  static func makeIcon(type: IconImage) -> IconProtocol {
    switch type {
    case .party:
      return PartyIcon()
    case .coffee:
      return CoffeeIcon()
    case .beer:
      return BeerIcon()
    case .cake:
      return CakeIcon()
    }
  }
}
