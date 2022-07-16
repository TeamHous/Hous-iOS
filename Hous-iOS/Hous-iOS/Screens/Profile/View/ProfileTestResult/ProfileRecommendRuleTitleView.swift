//
//  recommendRultTitleView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/17.
//

import UIKit

class ProfileRecommendTitleView : UIView {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
  }
  
  private let recommendTitleLabel: UILabel = {
    let recommendTitleLabel = UILabel()
    let attributedString = NSMutableAttributedString(string: "동글이와 함께 정하면 좋은 Rule!")
    let stringLength = attributedString.length
    
    attributedString.addAttributes([.foregroundColor: UIColor.darkYellow, .font: UIFont.font(.spoqaHanSansNeoBold, ofSize: 18)], range: NSRange(location: 0, length : 14))
    attributedString.addAttributes([.foregroundColor: UIColor.darkYellow, .font: UIFont.font(.montserratSemiBold, ofSize: 20)], range: NSRange(location: 14, length: stringLength - 14))
    
    recommendTitleLabel.attributedText = attributedString
    return recommendTitleLabel
  }()
    
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
    self.addSubViews([recommendTitleLabel])
    
    recommendTitleLabel.snp.makeConstraints {make in
      make.centerX.centerY.equalToSuperview()
    }
  }
}
