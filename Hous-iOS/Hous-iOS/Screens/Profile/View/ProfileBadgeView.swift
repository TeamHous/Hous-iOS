//
//  ProfileBadgeView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/11.
//

import UIKit

class ProfileBadgeView : UIView {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let badgeItemSize = CGSize(width: 70, height: 100)
  }
  
  private lazy var badgeGuideStackView = UIStackView().then {
    $0.alignment = .center
    $0.distribution = .fill
    $0.axis = .horizontal
    $0.spacing = Size.screenWidth * (30 / 375)
  }
  
  var profileBadgeItems = [profileBadgeStackItemView(),profileBadgeStackItemView(),profileBadgeStackItemView()]
  
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
    self.layer.cornerRadius = 10
    self.layer.masksToBounds = true
  }
  
  private func render(){
    self.addSubViews([badgeGuideStackView])
    profileBadgeItems.forEach {badgeGuideStackView.addArrangedSubview($0)}
    
    badgeGuideStackView.snp.makeConstraints {make in
      make.top.bottom.equalToSuperview().inset(28)
      make.centerX.equalToSuperview()
    }
    
    profileBadgeItems.forEach{
      $0.snp.makeConstraints {make in
        make.width.height.equalTo(Size.badgeItemSize)
      }
    }
  }
}
