//
//  AssigneeFactory.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/14.
//

import UIKit

enum AssigneeColor: String {
  case yellow, blue, purple, red, green, none
}

protocol AssigneeProtocol {
  var image: UIImage { get set }
  var color: UIColor { get set }
}

struct YellowAssignee: AssigneeProtocol {
  var image = R.Image.faceYellow
  var color = R.Color.paleGold
}

struct BlueAssignee: AssigneeProtocol {
  var image = R.Image.faceBlue
  var color = R.Color.softBlue
}

struct PurpleAssignee: AssigneeProtocol {
  var image = R.Image.facePurple
  var color = R.Color.lilac
}

struct RedAssignee: AssigneeProtocol {
  var image = R.Image.faceRed
  var color = R.Color.salmon
}
//
struct GreenAssignee: AssigneeProtocol {
  var image = R.Image.faceGreen
  var color = R.Color.easterGreen
}

struct NoAssignee: AssigneeProtocol {
  var image = R.Image.assignAdd
  var color = R.Color.veryLightPinkFour
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
      case .none:
        return NoAssignee()
      }
    }
}
