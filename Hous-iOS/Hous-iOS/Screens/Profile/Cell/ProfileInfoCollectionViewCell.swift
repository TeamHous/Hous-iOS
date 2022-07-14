//
//  ProfileInfoCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/11.
//

import UIKit
import SwiftUI

class ProfileInfoCollectionViewCell: UICollectionViewCell {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
  }
  
  var profileImage = UIImageView().then {
    $0.image = R.Image.facePurple
  }
  
  private lazy var profileGuideStackView = UIStackView().then {
    $0.alignment = .leading
    $0.distribution = .fillProportionally
    $0.axis = .vertical
    $0.spacing = 4
  }
  
  var userName = UILabel().then {
    $0.text = "최인영"
    $0.textColor = .black
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 20)
    $0.backgroundColor = .white
  }
  
  var userJob = UILabel().then {
    $0.text = "대학생"
    $0.textColor = .red
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
    $0.backgroundColor = .white
  }
  
  var statusMessage = UILabel().then {
    $0.text = "낮에 자고 밤에 일하는 부엉이"
    $0.textColor = .gray
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
    $0.backgroundColor = .white
  }
  
  // Tag 는 차후 서버 붙일 때 구조 List로 변경
  
  var tag1 = BasePaddingLabel(padding: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)).then {
    $0.text = "이의진"
    $0.textColor = .white
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
    $0.backgroundColor = .lilac
    $0.layer.cornerRadius = 10
    $0.layer.masksToBounds = true
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
    self.addSubViews([profileImage, userName, userJob, profileGuideStackView])
    [userName, statusMessage, tag1].forEach {profileGuideStackView.addArrangedSubview($0)}

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

  
  func setProfile(color : UIColor){
    self.tag1.backgroundColor = color
    self.profileImage.image = R.Image.faceEmpty
  }
}
