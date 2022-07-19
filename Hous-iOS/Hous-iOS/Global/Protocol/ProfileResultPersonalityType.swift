//
//  ProfileResultAssigneeFactory.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/19.
//

import UIKit

enum PersonalityType: String {
  
  case round = "동글이"
  case triangle = "셋돌이"
  case rectangle = "네각이"
  case pentagon = "오각이"
  case hexagon = "육각이"
  case empty = "default"
  
  var profileImage: UIImage {
    switch self {
    case .round:
      return R.Image.faceYellow
      
    case .triangle:
      return R.Image.faceRed
      
    case .rectangle:
      return R.Image.faceBlue
      
    case .pentagon:
      return R.Image.facePurple
      
    case .hexagon:
      return R.Image.faceGreen
    
    case .empty:
      return R.Image.profileEmpty
    }
  }
  
  var profileMainColor: UIColor {
    switch self {
    case .round:
      return R.Color.paleGold
      
    case .triangle:
      return R.Color.salmon
      
    case .rectangle:
      return R.Color.softBlue
      
    case .pentagon:
      return R.Color.lilac
      
    case .hexagon:
      return R.Color.easterGreen
      
    case .empty:
      return R.Color.veryLightPink
    }
  }
  
  var graphbackGroundColor: UIColor {
    switch self {
    case .round:
      return R.Color.eggShell
      
    case .triangle:
      return R.Color.veryLightPink
      
    case .rectangle:
      return R.Color.lightPeriwinkle
      
    case .pentagon:
      return R.Color.paleLavender
      
    case .hexagon:
      return R.Color.blueMint
    
    case .empty:
      return R.Color.veryLightPinkTwo
    }
  }
  
  var backgroundColor: UIColor {
    switch self {
    case .round:
      return R.Color.offWhite
      
    case .triangle:
      return R.Color.veryLightPinkTwo
      
    case .rectangle:
      return R.Color.paleGrey
      
    case .pentagon:
      return R.Color.paleGreyTwo
      
    case .hexagon:
      return R.Color.iceMint
      
    case .empty:
      return R.Color.veryLightPink
    }
    
  }
  
  var textColor: UIColor {
    switch self {
    case .round:
      return R.Color.orangeYellow
      
    case .triangle:
      return R.Color.salmon
      
    case .rectangle:
      return R.Color.softBlue
      
    case .pentagon:
      return R.Color.lilac
      
    case .hexagon:
      return R.Color.easterGreen
      
    case .empty:
      return R.Color.veryLightPink
    }
  }
  
  var personalityTitleText : String {
    switch self {
    case .round:
      return "늘 행복한 동글이"
      
    case .triangle:
      return "슈퍼 팔로워 셋돌이"
      
    case .rectangle:
      return "룸메 맞춤형 네각이"
      
    case .pentagon:
      return "하이레벨 오각이"
      
    case .hexagon:
      return "룰 세터 육각이"
      
    case .empty:
      return "Default"
    }
  }
  
  
}

