//
//  RecommendRuleView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/17.
//

import UIKit

final class ProfileRecommendRuleStackItemView : UIView {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let imageSize = CGSize(width: 14, height: 14)
  }
  
  private let indexImageView = UIImageView().then {
    $0.image = R.Image.resultCircle
  }
  
  private let recommendRuleLabel = UILabel().then {
    $0.text = "default"
    $0.textColor = .black
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  
  private func render(){
    self.addSubViews([indexImageView, recommendRuleLabel])
    
    indexImageView.snp.makeConstraints {make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview()
      make.width.height.equalTo(Size.imageSize)
    }
    
    recommendRuleLabel.snp.makeConstraints {make in
      make.centerY.equalToSuperview()
      make.leading.equalTo(indexImageView.snp.trailing).offset(10)
    }
  }
  
  func setLabelText(_ text: String) {
    recommendRuleLabel.text = text
  }
  
}

final class ProfileRecommendRuleView : UIView {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
  }

  private let recommendRuleStackView = UIStackView().then {
    $0.distribution = .fillProportionally
    $0.alignment = .leading
    $0.spacing = 6
    $0.axis = .vertical
  }
  
  private var recommendRuleStackItems: [ProfileRecommendRuleStackItemView] = []
  
  private var recommendRuleList = ["밥 먹고 바로 설거지하기", "샤워 후 머리카락 치우기"]
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configUI()
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configUI(){
    self.backgroundColor = .offWhite
    self.layer.cornerRadius = 15
    self.layer.masksToBounds = true
  }
  
  private func render(){
    for i in 0...1 {
      let recommendRuleStackItem = ProfileRecommendRuleStackItemView()
      recommendRuleStackItem.setLabelText(recommendRuleList[i])
      recommendRuleStackItems.append(recommendRuleStackItem)
    }
    
    recommendRuleStackView.addArrangedSubviews(recommendRuleStackItems[0], recommendRuleStackItems[1])
    self.addSubViews([recommendRuleStackView])
    
    recommendRuleStackView.snp.makeConstraints {make in
      make.top.equalToSuperview().offset(21)
      make.leading.equalToSuperview().offset(16)
      make.bottom.equalToSuperview().offset(-16)
    }
  }
}
