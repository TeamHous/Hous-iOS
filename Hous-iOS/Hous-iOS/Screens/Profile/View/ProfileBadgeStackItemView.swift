//
//  ProfileBadgeStackItemView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/12.
//

import UIKit

class profileBadgeStackItemView : UIView {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let circleSize = CGSize(width: 70, height: 70)
  }
  
  private let circle = CircleView()
  
  var badgeImage = UIImageView().then {
    $0.image = R.Image.badgeLocked
  }
  
  var badgeLabel = UILabel().then {
    $0.text = "규칙 한걸음"
    $0.textColor = .black
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 12)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configUI()
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configUI(){
    self.backgroundColor = .veryLightPinkTwo
  }
  
  private func render(){
    self.addSubViews([circle, badgeImage, badgeLabel])
    
    circle.snp.makeConstraints {make in
      make.top.equalToSuperview()
      make.width.height.equalTo(Size.circleSize)
    }
    
    badgeImage.snp.makeConstraints {make in
      make.top.bottom.leading.trailing.equalTo(circle).inset(22)
    }
    
    badgeLabel.snp.makeConstraints {make in
      make.top.equalTo(circle.snp.bottom).offset(12)
      make.centerY.equalToSuperview()
      make.centerX.equalTo(circle.snp.centerX)
    }
  }
}
