//
//  AssigneeFactory.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/14.
//

import UIKit

enum AssigneeColor: String {
  case yellow, blue, purple, red, green, gray, none
}

protocol AssigneeProtocol {
  var checkedFaceImage: UIImage { get set }
  var faceImage: UIImage { get set }
  var color: UIColor { get set }
  var profileBackgroundColor: UIColor { get set }
}

struct YellowAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedYellow
  var faceImage = R.Image.faceYellow
  var color = R.Color.paleGold
  var profileBackgroundColor = R.Color.offWhite
}

struct BlueAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedBlue
  var faceImage = R.Image.faceBlue
  var color = R.Color.softBlue
  var profileBackgroundColor = R.Color.paleGrey
}

struct PurpleAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedPurple
  var faceImage = R.Image.facePurple
  var color = R.Color.lilac
  var profileBackgroundColor = R.Color.paleGreyTwo
}

struct RedAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedRed
  var faceImage = R.Image.faceRed
  var color = R.Color.salmon
  var profileBackgroundColor = R.Color.veryLightPinkTwo
}

struct GreenAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedGreen
  var faceImage = R.Image.faceGreen
  var color = R.Color.easterGreen
  var profileBackgroundColor = R.Color.iceMint
}

struct GrayAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedGray
  var faceImage = R.Image.faceEmpty
  var color = R.Color.veryLightPinkFour
  var profileBackgroundColor = R.Color.veryLightPinkThree
}

struct NoAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedGray
  var faceImage = R.Image.faceEmpty
  var color = R.Color.lightPeriwinkle
  var profileBackgroundColor = R.Color.veryLightPinkThree
}

struct AssigneeFactory {
  
  static func makeAssignee(type: AssigneeColor) -> AssigneeProtocol {
    switch type {
    case .yellow:
      return YellowAssignee()
    case .blue:
      return BlueAssignee()
    case .purple:
      return PurpleAssignee()
    case .red:
      return RedAssignee()
    case .green:
      return GreenAssignee()
    case .gray:
      return GrayAssignee()
    case .none:
      return NoAssignee()
    }
  }
}
