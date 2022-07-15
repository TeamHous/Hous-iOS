//
//  ProfileCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
  
  var profileImage = UIImageView().then {
    $0.image = UIImage(systemName: "person")
    $0.contentMode = .scaleAspectFit
    $0.layer.cornerRadius = $0.bounds.width / 2
  }
  
  var profileNameLabel = UILabel().then {
    $0.font = .font(.montserratSemiBold, ofSize: 12)
    $0.textColor = .greyishBrown
  }
  
  var codeImage = UIImageView().then {
    $0.isHidden = true
    $0.image = R.Image.moreHomie
    $0.tintColor = .paleGold
    $0.contentMode = .scaleAspectFit
  }
  
  var codeLabel = UILabel().then {
    $0.isHidden = true
    $0.text = "룸메이트 초대코드 복사하기"
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 12)
    $0.textColor = .veryLightPinkFive
    $0.lineBreakMode = .byWordWrapping
    $0.lineBreakStrategy = .hangulWordPriority
    $0.textAlignment = .center
    $0.numberOfLines = 0
    $0.minimumScaleFactor = 0.5
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configUI()
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func render() {
    contentView.addSubViews([profileImage, profileNameLabel, codeImage, codeLabel])
    
    codeLabel.snp.makeConstraints {
      $0.width.equalTo(self.bounds.width / 2)
    }
    
    profileImage.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(15)
      make.centerX.equalToSuperview()
      make.size.equalTo(52)
    }
    
    profileNameLabel.snp.makeConstraints { make in
      make.centerX.equalTo(profileImage)
      make.top.equalTo(profileImage.snp.bottom).offset(8)
      make.bottom.equalToSuperview().inset(13)
    }
    
    codeImage.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(25)
      make.centerX.equalToSuperview()
    }
    
    codeLabel.snp.makeConstraints { make in
      make.top.equalTo(codeImage.snp.bottom).offset(12)
      make.centerX.equalTo(codeImage)
      make.bottom.equalToSuperview().inset(8)
    }
    
  }
  
  private func configUI() {
    self.backgroundColor = R.Color.offWhite
    layer.cornerRadius = 10
    self.contentView.clipsToBounds = true
  }
  
  func setProfileData(_ data: HomieProfileList) {
    let factory = AssigneeFactory.makeAssignee(type: AssigneeColor(rawValue: data.userName.lowercased()) ?? .none)
    profileImage.image = factory.faceImage
    profileNameLabel.text = data.userName
  }
  
}
