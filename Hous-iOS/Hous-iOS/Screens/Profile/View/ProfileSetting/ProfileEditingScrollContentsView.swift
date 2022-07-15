//
//  ProfileEditingScrollContentsView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/16.
//

import UIKit

class ProfileEditingScrollContentsView : UIView {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let profileImageSize = CGSize(width: 88, height: 88)
  }
  
  private let profileImage = UIImageView().then {
    $0.image = R.Image.facePurple
  }
  
  private let nameTextField = FormTextField(insetY: 14).then {
    $0.placeholder = "이름"
    $0.backgroundColor = .whitishGrey
    $0.layer.cornerRadius = 10
    $0.layer.masksToBounds = true
    $0.setPlaceholderStyle(placeholderColor: .veryLightPinkFour, placeholderFont: .font(.spoqaHanSansNeoMedium, ofSize: 16))
  }
  
  private let jobTextField = FormTextField(insetY: 14).then {
    $0.placeholder = "직업"
    $0.backgroundColor = .whitishGrey
    $0.layer.cornerRadius = 10
    $0.layer.masksToBounds = true
    $0.setPlaceholderStyle(placeholderColor: .veryLightPinkFour, placeholderFont: .font(.spoqaHanSansNeoMedium, ofSize: 16))
  }
  
  private let selfIntroductionTextView = UITextView().then {
    $0.backgroundColor = .whitishGrey
    $0.layer.cornerRadius = 10
    $0.layer.masksToBounds = true
    $0.textContainerInset = UIEdgeInsets(top: 18, left: 20, bottom: 18, right: 20)
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    $0.text = "나이 등 간단한 자기소개"
    $0.textColor = .veryLightPinkFour
  }
  
  private var hashTagTextFields : [FormTextField] = []
  
  private let profileEditingStackView = UIStackView().then {
    $0.distribution = .fill
    $0.spacing = 16
    $0.axis = .vertical
  }
  
  private let profileEditingSubStackView = UIStackView().then {
    $0.distribution = .fillEqually
    $0.alignment = .fill
    $0.spacing = 17
    $0.axis = .horizontal
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configUI()
    setDelegate()
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configUI(){
    self.backgroundColor = .white
    
    for _ in 0...2 {
      let hashTagTextField = FormTextField(insetY: 12).then {
        $0.placeholder = "나를 소개하는 해시태그"
        $0.backgroundColor = .whitishGrey
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.setPlaceholderStyle(placeholderColor: .veryLightPinkFour, placeholderFont: .font(.spoqaHanSansNeoMedium, ofSize: 16))
      }
      hashTagTextFields.append(hashTagTextField)
    }
  }
  
  private func setDelegate(){
    self.selfIntroductionTextView.delegate = self
  }
  
  private func render(){
    
    self.addSubViews([profileImage, profileEditingStackView])
    profileEditingSubStackView.addArrangedSubviews(nameTextField, jobTextField)
    profileEditingStackView.addArrangedSubviews(profileEditingSubStackView, selfIntroductionTextView, hashTagTextFields[0], hashTagTextFields[1], hashTagTextFields[2])
    
    profileImage.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(40)
      make.width.height.equalTo(Size.profileImageSize)
    }
    
    nameTextField.snp.makeConstraints {make in
      make.height.equalTo(52)
    }
    
    jobTextField.snp.makeConstraints {make in
      make.height.equalTo(52)
    }
    
    selfIntroductionTextView.snp.makeConstraints {make in
      make.height.equalTo(88)
    }
    
    hashTagTextFields.forEach {
      $0.snp.makeConstraints {make in
        make.height.equalTo(45)
      }
    }
  
    profileEditingStackView.snp.makeConstraints {make in
      make.top.equalTo(profileImage.snp.bottom).offset(48)
      make.width.equalToSuperview()
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview()
    }
    
    profileEditingSubStackView.snp.makeConstraints {make in
      make.height.equalTo(52)
    }
  }
}

extension ProfileEditingScrollContentsView : UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.text == "나이 등 간단한 자기소개" {
      textView.text = nil
      textView.textColor = .black
    }
  }
}
