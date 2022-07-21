//
//  ProfileTestResultTextCell.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/17.
//

import UIKit

final class ProfileTestResultTextCollectionViewCell : UICollectionViewCell {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let recommendRuleTitleViewSize = CGSize(width: Size.screenWidth - 48, height: 44)
    static let recommendRuleViewSIze = CGSize(width: Size.screenWidth - 48, height: 86)
  }
  
  private let descriptionView = ProfileDescriptionView()
  
  private let recommendRuleTitleView = ProfileRecommendTitleView()
  
  private let recommendRuleView = ProfileRecommendRuleView()
  
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
  
  private func render() {
    self.addSubViews([descriptionView, recommendRuleTitleView, recommendRuleView])
    
    descriptionView.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview()
      make.width.equalTo(Size.screenWidth - 48)
    }
    
    recommendRuleTitleView.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalTo(descriptionView.snp.bottom).offset(18)
      make.width.height.equalTo(Size.recommendRuleTitleViewSize)
    }
    
    recommendRuleView.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalTo(recommendRuleTitleView.snp.bottom).offset(8)
      make.width.height.equalTo(Size.recommendRuleViewSIze)
    }
  }
  
  func setData(_ dataPack: ProfileTestResultDataPack) {
    self.descriptionView.personalityTitleLabel.text = dataPack.personalityTitleLabel
    self.descriptionView.personalityTitleLabel.textColor = dataPack.personalityType.textColor
    
    let descriptionAttributedString = NSAttributedString(string: dataPack.personalityDescriptionLabel).withLineSpacing(2.5)
    self.descriptionView.personalityDescriptionLabel.attributedText = descriptionAttributedString
    
    self.descriptionView.backgroundColor = dataPack.personalityType.backgroundColor
    
    self.recommendRuleTitleView.recommendTitleLabel.text = dataPack.recommandTitleLabel
    self.recommendRuleTitleView.recommendTitleLabel.textColor = dataPack.personalityType.textColor
    self.recommendRuleTitleView.backgroundColor = dataPack.personalityType.backgroundColor
    
    for (index, item) in dataPack.recommandRuleLabel.enumerated() {
      self.recommendRuleView.recommendRuleStackItems[index].setLabelText(item)
    }
    
    self.recommendRuleView.backgroundColor = dataPack.personalityType.backgroundColor
    self.recommendRuleView.recommendRuleStackItems[0].indexImageView.image = dataPack.personalityType.ruleRecommendImage
    self.recommendRuleView.recommendRuleStackItems[1].indexImageView.image = dataPack.personalityType.ruleRecommendImage
    
  }
}
