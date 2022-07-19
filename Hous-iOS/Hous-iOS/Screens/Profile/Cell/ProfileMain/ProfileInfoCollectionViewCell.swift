//
//  ProfileInfoCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/11.
//

import UIKit

final class ProfileInfoCollectionViewCell: UICollectionViewCell {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
  }
  
  var profileImage = UIImageView().then {
    $0.image = R.Image.facePurple
  }
  
  private var profileGuideStackView = UIStackView().then {
    $0.alignment = .leading
    $0.distribution = .fillProportionally
    $0.axis = .vertical
    $0.spacing = 4
  }
  
  private var tagGuideStackView = UIStackView().then {
    $0.alignment = .center
    $0.distribution = .fillProportionally
    $0.axis = .horizontal
    $0.spacing = 8
  }
  
  private var userName = UILabel().then {
    $0.text = "이름"
    $0.textColor = .black
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 20)
    $0.backgroundColor = .white
  }
  
  private var userJob = UILabel().then {
    $0.text = "직업"
    $0.textColor = .veryLightPinkFour
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
    $0.backgroundColor = .white
  }
  
  private var statusMessage = UILabel().then {
    $0.text = "상태 메시지"
    $0.textColor = .gray
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
    $0.backgroundColor = .white
  }
  
  private var tags : [BasePaddingLabel] = []
  
  
  override init(frame: CGRect){
    super.init(frame: frame)
    render()
  }
  
  
  required init?(coder: NSCoder){
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    tagGuideStackView.subviews.forEach {
      $0.removeFromSuperview()
    }
  }
  
  private func configUI(datapack: ProfileNetworkDataPack){
    self.backgroundColor = .white
  }
  
  private func render(){
    self.addSubViews([profileImage, userJob, profileGuideStackView])
    tags.forEach {tagGuideStackView.addArrangedSubview($0)}
    [userName, statusMessage, tagGuideStackView].forEach { profileGuideStackView.addArrangedSubview($0)}
    
    
    profileImage.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().offset(24)
      make.width.equalTo(Size.screenWidth * (88 / 375))
      make.height.equalTo(Size.screenWidth * (88 / 375))
    }
    
    profileGuideStackView.snp.makeConstraints { make in
      make.bottom.equalTo(profileImage.snp.bottom)
      make.leading.equalTo(profileImage.snp.trailing).offset(24)
    }
    
    userJob.snp.makeConstraints {make in
      make.centerY.equalTo(userName.snp.centerY).offset(3)
      make.leading.equalTo(userName.snp.trailing).offset(8)
    }
  }
  
  func dataBinding(_ dataPack : ProfileNetworkDataPack){
    self.profileImage.image = dataPack.personalityType.profileImage
    self.userName.text = dataPack.userName
    
    if dataPack.userJob == "" {
      self.userJob.textColor = .veryLightPinkFour
      self.userJob.text = "직업"
    } else {
      self.userJob.textColor = .salmon
      self.userJob.text = dataPack.userJob
    }
    
    if dataPack.statusMessage == "" {
      self.statusMessage.text = "소개와 태그를 작성해주세요"
    } else {
      self.statusMessage.text = dataPack.statusMessage
    }
    
    tags = []
    if dataPack.hashTag.count == 0 {
      let tag = BasePaddingLabel(padding: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)).then {
        $0.text = ""
        $0.textColor = .white
        $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
      }
      tags.append(tag)
    } else {
      for item in dataPack.hashTag {
        let tag = BasePaddingLabel(padding: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)).then {
          $0.text = item
          $0.textColor = .white
          $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
          $0.backgroundColor = dataPack.personalityType.profileMainColor
          $0.layer.cornerRadius = 10
          $0.layer.masksToBounds = true
        }
        tags.append(tag)
      }
    }
    tags.forEach {tagGuideStackView.addArrangedSubview($0)}    
  }
}
