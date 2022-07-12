//
//  Asset.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/07.
//

import UIKit

public struct R {

  public struct Color { }
  public struct Image { }

}

extension R.Color {
  
  static var salmon: UIColor {
    .dynamicColor(light: .salmon, dark: .white)
  }
  static var veryLightPink: UIColor {
    .dynamicColor(light: .veryLightPink, dark: .white)
  }
  static var veryLightPinkTwo: UIColor {
    .dynamicColor(light: .veryLightPinkTwo, dark: .white)
  }
  static var softBlue: UIColor {
    .dynamicColor(light: .softBlue, dark: .white)
  }
  static var lightPeriwinkle: UIColor {
    .dynamicColor(light: .lightPeriwinkle, dark: .white)
  }
  static var paleGrey: UIColor {
    .dynamicColor(light: .paleGrey, dark: .white)
  }
  static var paleGold: UIColor {
    .dynamicColor(light: .paleGold, dark: .white)
  }
  static var eggShell: UIColor {
    .dynamicColor(light: .eggShell, dark: .white)
  }
  static var offWhite: UIColor {
    .dynamicColor(light: .offWhite, dark: .white)
  }
  static var lilac: UIColor {
    .dynamicColor(light: .lilac, dark: .white)
  }
  static var paleLavender: UIColor {
    .dynamicColor(light: .paleLavender, dark: .white)
  }
  static var paleGreyTwo: UIColor {
    .dynamicColor(light: .paleGreyTwo, dark: .white)
  }
  static var easterGreen: UIColor {
    .dynamicColor(light: .easterGreen, dark: .white)
  }
  static var veryLightPinkThree: UIColor {
    .dynamicColor(light: .veryLightPinkThree, dark: .white)
  }
  static var veryLightPinkFour: UIColor {
    .dynamicColor(light: .veryLightPinkFour, dark: .white)
  }
  static var veryLightPinkFive: UIColor {
    .dynamicColor(light: .veryLightPinkFive, dark: .white)
  }
  static var brownGrey: UIColor {
    .dynamicColor(light: .brownGrey, dark: .white)
  }
  static var brownGreyTwo: UIColor {
    .dynamicColor(light: .brownGreyTwo, dark: .white)
  }
  static var greyishBrown: UIColor {
    .dynamicColor(light: .greyishBrown, dark: .white)
  }
  static var housBlack: UIColor {
    .dynamicColor(light: .housBlack, dark: .white)
  }
  static var whitishGrey: UIColor {
    .dynamicColor(light: .whitishGrey, dark: .white)
  }
}

extension UIColor {
  static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
    guard #available(iOS 13.0, *) else { return light }
    return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
  }
}

extension UIColor {

  @nonobjc class var salmon: UIColor {
    return UIColor(red: 1.0, green: 102.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var veryLightPink: UIColor {
    return UIColor(red: 1.0, green: 222.0 / 255.0, blue: 222.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var veryLightPinkTwo: UIColor {
    return UIColor(red: 1.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var softBlue: UIColor {
    return UIColor(red: 94.0 / 255.0, green: 158.0 / 255.0, blue: 1.0, alpha: 1.0)
  }
  @nonobjc class var lightPeriwinkle: UIColor {
    return UIColor(red: 204.0 / 255.0, green: 225.0 / 255.0, blue: 1.0, alpha: 1.0)
  }
  @nonobjc class var paleGrey: UIColor {
    return UIColor(red: 239.0 / 255.0, green: 245.0 / 255.0, blue: 1.0, alpha: 1.0)
  }
  @nonobjc class var paleGold: UIColor {
    return UIColor(red: 1.0, green: 214.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var eggShell: UIColor {
    return UIColor(red: 1.0, green: 239.0 / 255.0, blue: 196.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var offWhite: UIColor {
    return UIColor(red: 1.0, green: 248.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var lilac: UIColor {
    return UIColor(red: 217.0 / 255.0, green: 156.0 / 255.0, blue: 1.0, alpha: 1.0)
  }
  @nonobjc class var paleLavender: UIColor {
    return UIColor(red: 241.0 / 255.0, green: 218.0 / 255.0, blue: 1.0, alpha: 1.0)
  }
  @nonobjc class var paleGreyTwo: UIColor {
    return UIColor(red: 249.0 / 255.0, green: 241.0 / 255.0, blue: 1.0, alpha: 1.0)
  }
  @nonobjc class var easterGreen: UIColor {
    return UIColor(red: 143.0 / 255.0, green: 242.0 / 255.0, blue: 141.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var whitishGrey: UIColor {
    return UIColor(white: 250.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var veryLightPinkThree: UIColor {
    return UIColor(white: 242.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var veryLightPinkFour: UIColor {
    return UIColor(white: 225.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var veryLightPinkFive: UIColor {
    return UIColor(white: 200.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var brownGrey: UIColor {
    return UIColor(white: 175.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var brownGreyTwo: UIColor {
    return UIColor(white: 150.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var greyishBrown: UIColor {
    return UIColor(white: 61.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var housBlack: UIColor {
    return UIColor(white: 22.0 / 255.0, alpha: 1.0)
  }
}

extension R.Image {
  // Common
  // Category
  static var beer: UIImage { .load(named: "beer") }
  static var cake: UIImage { .load(named: "cake") }
  static var clean: UIImage { .load(named: "clean") }
  static var coffee: UIImage { .load(named: "coffee") }
  static var heart: UIImage { .load(named: "heart") }
  static var laundry: UIImage { .load(named: "laundry") }
  static var light: UIImage { .load(named: "light") }
  static var trash: UIImage { .load(named: "trash") }
  
  // Face
  static var faceBlue: UIImage { .load(named: "faceBlue") }
  static var faceGreen: UIImage { .load(named: "faceGreen") }
  static var facePurple: UIImage { .load(named: "facePurple") }
  static var faceRed: UIImage { .load(named: "faceRed") }
  static var faceYellow: UIImage { .load(named: "faceYellow") }
  
  static var faceCheckedBlue: UIImage { .load(named: "faceCheckedBlue") }
  static var faceCheckedGreen: UIImage { .load(named: "faceCheckedGreen") }
  static var faceCheckedPurple: UIImage { .load(named: "faceCheckedPurple") }
  static var faceCheckedRed: UIImage { .load(named: "faceCheckedRed") }
  static var faceCheckedYellow: UIImage { .load(named: "faceCheckedYellow") }
  
  // Tab
  static var homeTabUnselected: UIImage { .load(named: "homeTabUnselected") }
  static var homeTabSelected: UIImage { .load(named: "homeTabSelected") }
  static var rulesTabUnselected: UIImage { .load(named: "rulesTabUnselected") }
  static var rulesTabSelected: UIImage { .load(named: "rulesTabSelected") }
  static var profileTabUnselected: UIImage { .load(named: "profileTabUnselected") }
  static var profileTabSelected: UIImage { .load(named: "profileTabSelected") }
  
  // Home
  static var beerYellow: UIImage { .load(named: "beerYellow") }
  static var cakeYellow: UIImage { .load(named: "cakeYellow") }
  static var partyYellow: UIImage { .load(named: "partyYellow") }
  static var coffeeYellow: UIImage { .load(named: "coffeeYellow") }
  static var eventAdd: UIImage { .load(named: "eventAdd") }
  static var moreHomie: UIImage { .load(named: "moreHomie") }
  static var rulesDot: UIImage { .load(named: "rulesDot") }
  static var todoChecked: UIImage { .load(named: "todoChecked") }
  static var todoUnchecked: UIImage { .load(named: "todoUnchecked") }
  static var beerYellowSmall: UIImage { .load(named: "beerYellowSmall")}
  static var cakeYellowSmall: UIImage { .load(named: "cakeYellowSmall")}
  static var coffeeYellowSmall: UIImage { .load(named: "coffeeYellowSmall")}
  static var partyYellowSmall: UIImage { .load(named: "partyYellowSmall")}
  //Home Popup
  static var categoryCheck: UIImage { .load(named: "categoryCheck") }
  static var popupCloseHome: UIImage { .load(named: "popupCloseHome") }
  
  // Rules
  static var alarmOff: UIImage { .load(named: "alarmOff") }
  static var alarmOn: UIImage { .load(named: "alarmOn") }
  static var assignAdd: UIImage { .load(named: "assignAdd") }
  static var assignRemove: UIImage { .load(named: "assignRemove") }
  static var categoryAdd: UIImage { .load(named: "categoryAdd") }
  static var dropdownMore: UIImage { .load(named: "dropdownMore") }
  static var keyRulesUnchecked: UIImage { .load(named: "keyRulesUnchecked") }
  static var myTodoChecked: UIImage { .load(named: "myTodoChecked") }
  static var myTodoUnchecked: UIImage { .load(named: "myTodoUnchecked") }
  static var myTodoSelected: UIImage { .load(named: "myTodoSelected") }
  static var myTodoUnselected: UIImage { .load(named: "myTodoUnselected") }
  static var popupCloseRules: UIImage { .load(named: "popupCloseRules") }
  static var rulesChecked: UIImage { .load(named: "rulesChecked") }
  static var todoSelected: UIImage { .load(named: "todoSelected") }
  static var todoUnselected: UIImage { .load(named: "todoUnselected") }
  
  // Profile
  static var badgeLocked: UIImage { .load(named: "badgeLocked") }
  static var naviBackButton: UIImage { .load(named: "naviBackButton") }
  static var notiOn: UIImage { .load(named: "notiOn") }
  static var notiOff: UIImage { .load(named: "notiOff") }
  static var settingProfile: UIImage { .load(named: "settingProfile") }
  static var updateProfile: UIImage { .load(named: "updateProfile") }
  static var viewMoreButton: UIImage { .load(named: "viewMoreButton") }
  static var viewMoreSettingButton: UIImage { .load(named: "viewMoreSettingButton") }
}

extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName) else {
            return UIImage()
        }
        image.accessibilityIdentifier = imageName
        return image
    }
}
