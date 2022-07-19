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
}

struct YellowAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedYellow
  var faceImage = R.Image.faceYellow
  var color = R.Color.paleGold
}

struct BlueAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedBlue
  var faceImage = R.Image.faceBlue
  var color = R.Color.softBlue
}

struct PurpleAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedPurple
  var faceImage = R.Image.facePurple
  var color = R.Color.lilac
}

struct RedAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedRed
  var faceImage = R.Image.faceRed
  var color = R.Color.salmon
}

struct GreenAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedRed
  var faceImage = R.Image.faceGreen
  var color = R.Color.easterGreen
}

struct GrayAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedRed
  var faceImage = R.Image.faceEmpty
  var color = R.Color.veryLightPinkFour
}

struct NoAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedGray
  var faceImage = R.Image.faceEmpty
  var color = R.Color.lightPeriwinkle
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
