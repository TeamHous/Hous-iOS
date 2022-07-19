//
//  ProfileTestResultImageCell.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/17.
//

import UIKit

final class ProfileTestResultImageCollectionViewCell : UICollectionViewCell {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let imageSize = CGSize(width: 300, height: 300)
  }
  
  private let userNameLabel = UILabel().then {
    $0.text = "최호미님은"
    $0.textColor = .brownGrey
    $0.backgroundColor = .white
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
  }
  
  private let personalityTypeLabel = UILabel().then {
    $0.text = "늘 행복한 동글이"
    $0.textColor = .housBlack
    $0.backgroundColor = .white
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 22)
  }
  
  private let personalityImageView = UIImageView().then {
    $0.image = R.Image.resultImage1
  }
  
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
    self.addSubViews([userNameLabel, personalityTypeLabel, personalityImageView])
    
    userNameLabel.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview()
    }
    
    personalityTypeLabel.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalTo(userNameLabel.snp.bottom).offset(2)
    }
    
    personalityImageView.snp.makeConstraints {make in
      make.centerX.equalTo(personalityTypeLabel)
      make.top.equalTo(personalityTypeLabel.snp.bottom).offset(9)
      make.width.height.equalTo(Size.imageSize)
    }
  }
  
  func setData(_ dataPack: ProfileTestResultDataPack){
    self.userNameLabel.text =  dataPack.userNameLabel
    self.personalityTypeLabel.text = dataPack.personalityTypeLabel
    self.personalityImageView.image = dataPack.personalityImage
  }
}
