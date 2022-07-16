//
//  ProfileTestResultTextCell.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/17.
//

import UIKit

class ProfileTestResultTextCollectionViewCell : UICollectionViewCell {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let descriptionViewSize = CGSize(width: Size.screenWidth - 48, height: 179)
    static let recommendRuleTitleViewSize = CGSize(width: Size.screenWidth - 48, height: 44)
    static let recommendRuleViewSIze = CGSize(width: Size.screenWidth - 48, height: 86)
  }
  
  private let descriptionView = ProfileDescriptionView()
  
  private let recommendRuleTitleView = ProfileRecommendTitleView()
  
  private let recommendRuleView = ProfileRecommendView()
  
  override init(frame: CGRect){
    super.init(frame: frame)
    configUI()
    render()
  }
  
  required init?(coder: NSCoder){
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configUI(){
    self.backgroundColor = .white
  }
  
  private func render(){
    self.addSubViews([descriptionView, recommendRuleTitleView, recommendRuleView])
    
    descriptionView.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(11)
      make.width.height.equalTo(Size.descriptionViewSize)
    }
    
    recommendRuleTitleView.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalTo(descriptionView.snp.bottom).offset(24)
      make.width.height.equalTo(Size.recommendRuleTitleViewSize)
    }
    
    recommendRuleView.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalTo(recommendRuleTitleView.snp.bottom).offset(8)
      make.width.height.equalTo(Size.recommendRuleViewSIze)
    }
  
  }
}
