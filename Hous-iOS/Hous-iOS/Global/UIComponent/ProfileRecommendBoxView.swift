//
//  ProfileRecommendBoxView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/17.
//

import UIKit

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
  
  let titleLabel = UILabel().then {
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 12)
  }
  
  let personalityLabel = UILabel().then {
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    $0.textColor = .housBlack
  }
  
  let personalityImageView = UIImageView().then {
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
