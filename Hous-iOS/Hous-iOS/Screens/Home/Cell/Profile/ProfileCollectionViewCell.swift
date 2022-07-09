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
    $0.font = .systemFont(ofSize: 18, weight: .bold)
  }
  
  lazy var profileStack = UIStackView(arrangedSubviews: [profileImage, profileNameLabel]).then {
    $0.axis = .vertical
    $0.spacing = 12
    $0.alignment = .center
  }
  
  private let codeImage = UIImageView().then {
    $0.image = UIImage(systemName: "rectangle")
    $0.tintColor = .black
    $0.contentMode = .scaleAspectFit
  }
  
  private let codeLabel = UILabel().then {
    $0.text = "룸메이트 초대 코드 복사하기"
    $0.font = .systemFont(ofSize: 12, weight: .light)
    $0.tintColor = UIColor(hex: "C8C8C8")
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
    self.backgroundColor = UIColor(hex: "FFD66D")
    layer.cornerRadius = self.bounds.width / 4
    self.contentView.clipsToBounds = true
  }
  
  func setProfileData(_ data: ProfileDataModel) {
    if data.isTested {
      profileImage.image = UIImage(systemName: "person.fill")
    } else {
      profileImage.image = UIImage(systemName: "person")
    }
    profileNameLabel.text = data.profileName
  }
  
}
