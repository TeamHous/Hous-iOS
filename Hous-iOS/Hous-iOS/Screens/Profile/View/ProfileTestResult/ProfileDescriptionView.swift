//
//  DescriptionVIew.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/17.
//

import UIKit

final class ProfileDescriptionView : UIView {
  
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
  }
  
  let personalityTitleLabel = UILabel().then {
    $0.text = ""
    $0.textColor = .orangeYellow
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 18)
  }
   
  let personalityDescriptionLabel = UILabel().then {
    $0.text = ""
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
    self.backgroundColor = .white
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
