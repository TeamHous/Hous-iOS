//
//  DescriptionVIew.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/17.
//

import UIKit

class ProfileDescriptionView : UIView {
  
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
  }
  
  private let personalityTitleLabel: UILabel = {
    let recommendTitleLabel = UILabel()
    let attributedString = NSMutableAttributedString(string: "어떤 상황에서도 Happy -")
    let stringLength = attributedString.length
    
    attributedString.addAttributes([.foregroundColor: UIColor.darkYellow, .font: UIFont.font(.spoqaHanSansNeoBold, ofSize: 18)], range: NSRange(location: 0, length : 9))
    attributedString.addAttributes([.foregroundColor: UIColor.darkYellow, .font: UIFont.font(.montserratSemiBold, ofSize: 20)], range: NSRange(location: 9, length: stringLength - 9))
    
    recommendTitleLabel.attributedText = attributedString
    return recommendTitleLabel
  }()
  
  private let personalityDescriptionLabel = UILabel().then {
    $0.text = "동글동글한 사람이에요. 민감하게 생각하는 영역이\n거의 없어 공동생활에 쉽게 적응할 수 있어요.\n동글이님과 함께 생활하는 룸메이트는\n조금 더 세심한 배려가 필요한 영역이 있다면\n동글이님과 직접 얘기해보는 것도 좋을 거예요."
    $0.textColor = .greyishBrown
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 14)
    $0.numberOfLines = 5
    $0.textAlignment = .center
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
    self.backgroundColor = .offWhite
    self.layer.cornerRadius = 15
    self.layer.masksToBounds = true
  }
  
  private func render(){
    self.addSubViews([personalityTitleLabel, personalityDescriptionLabel])
    
    personalityTitleLabel.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(16)
    }
    
    personalityDescriptionLabel.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalTo(personalityTitleLabel.snp.bottom).offset(8)
      make.bottom.equalToSuperview().offset(-20)
    }
  }
}
