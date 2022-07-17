//
//  ProfileRecommendBoxView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/17.
//

import UIKit

enum PersonalityType : String {
  case round = "동글이"
  case triangle = "셋돌이"
  case rectangle = "네각이"
  case pentagon = "오각이"
  case hexagon = "육각이"
  
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
    }
  }
}

enum CellType: String {
  case bad = "맞춰가요"
  case good = "찰떡궁합"
}

final class ProfileRecommendBoxView: UIView {
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let imageSize = CGSize(width: 120, height: 120)
  }
  
  private let titleLabel = UILabel().then {
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 12)
  }
  
  private let personalityLabel = UILabel().then {
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    $0.textColor = .housBlack
  }
  
  private let personalityImageView = UIImageView().then {
    $0.image = nil
  }
  
  convenience init(personalityType: PersonalityType, cellType : CellType) {
    self.init(frame: .zero)
    configUI(personalityType: personalityType, cellType: cellType)
    render()
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configUI(personalityType: PersonalityType, cellType: CellType){
    self.backgroundColor = personalityType.backgroundColor
    self.layer.cornerRadius = 15
    self.layer.masksToBounds = true
    
    titleLabel.text = cellType.rawValue
    titleLabel.textColor = personalityType.textColor
    
    personalityLabel.text = personalityType.personalityTitleText
    
    // 서버 통신 시 URL로 설정
    personalityImageView.image = R.Image.resultImage1
  }
  
  private func render(){
    self.addSubViews([titleLabel, personalityLabel, personalityImageView])
    
    titleLabel.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(16)
    }
    
    personalityLabel.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalTo(titleLabel.snp.bottom)
    }
    
    personalityImageView.snp.makeConstraints {make in
      make.width.height.equalTo(Size.imageSize)
      make.centerX.equalToSuperview()
      make.top.equalTo(personalityLabel.snp.bottom)
    }
  }
}
