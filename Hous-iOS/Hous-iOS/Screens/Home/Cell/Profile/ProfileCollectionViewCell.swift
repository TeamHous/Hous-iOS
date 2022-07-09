//
//  ProfileCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
  
  private let profileImage = UIImageView().then {
    $0.image = UIImage(systemName: "person")
    $0.contentMode = .scaleAspectFit
    $0.layer.cornerRadius = $0.bounds.width / 2
  }
  
  private let profileNameLabel = UILabel().then {
    $0.font = .font(.montserratSemiBold, ofSize: 12)
    $0.textColor = .greyishBrown
  }
  
  lazy var profileStack = UIStackView(arrangedSubviews: [profileImage, profileNameLabel]).then {
    $0.axis = .vertical
    $0.spacing = 12
    $0.alignment = .center
  }
  
  private let codeImage = UIImageView().then {
    $0.image = R.Image.moreHomie
    $0.tintColor = .paleGold
    $0.contentMode = .scaleAspectFit
  }
  
  private let codeLabel = UILabel().then {
    $0.text = "룸메이트 초대 코드 복사하기"
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 12)
    $0.textColor = .veryLightPinkFive
    $0.lineBreakMode = .byWordWrapping
    $0.lineBreakStrategy = .hangulWordPriority
    $0.textAlignment = .center
    $0.numberOfLines = 0
    $0.minimumScaleFactor = 0.5
  }
  
  lazy var codeViewStack = UIStackView(arrangedSubviews: [codeImage, codeLabel]).then {
    $0.axis = .vertical
    $0.spacing = 12
    $0.alignment = .center
    $0.isHidden = true
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
    contentView.addSubViews([profileStack, codeViewStack])
    
    codeLabel.snp.makeConstraints {
      $0.width.equalTo(self.bounds.width / 2)
    }
    
    profileStack.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    
    codeViewStack.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalToSuperview().inset(8)
    }
    
  }
  
  private func configUI() {
    self.backgroundColor = R.Color.offWhite
    layer.cornerRadius = 10
    self.contentView.clipsToBounds = true
  }
  
  func setProfileData(_ data: ProfileDataModel) {
    if data.isTested {
      profileImage.image = R.Image.facePurple
    } else {
      profileImage.image = R.Image.faceGreen
    }
    profileNameLabel.text = data.profileName
  }
  
}
