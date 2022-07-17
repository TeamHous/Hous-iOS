//
//  ProfileEditingScrollContentsView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/16.
//

import UIKit

final class ProfileEditingScrollContentsView : UIView {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let profileImageSize = CGSize(width: 88, height: 88)
  }
  
  private let textViewMaxCount = 20
  
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
    $0.textContainerInset = UIEdgeInsets(top: 18, left: 14, bottom: 18, right: 50)
    //$0.contentInset = UIEdgeInsets(top: 18, left: -5, bottom: 18, right: 50)
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    $0.text = "나이 등 간단한 자기소개"
    $0.textColor = .veryLightPinkFour
  }
  
  private var textViewCountLabel = UILabel().then {
    $0.text = "0/20"
    $0.textColor = .veryLightPinkFour
    $0.font = .font(.montserratRegular, ofSize: 13)
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
    setTextView()
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
    
    self.addSubViews([profileImage, profileEditingStackView, textViewCountLabel])
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
    
    textViewCountLabel.snp.makeConstraints {make in
      make.trailing.equalTo(selfIntroductionTextView).inset(17)
      make.top.equalTo(selfIntroductionTextView).inset(18)
    }
  }
  
  private func setTextView() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(textDidChange),
      name: UITextView.textDidChangeNotification,
      object: selfIntroductionTextView
    )
  }
  
}

extension ProfileEditingScrollContentsView : UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.text == "나이 등 간단한 자기소개" {
      textView.text = nil
      textView.textColor = .black
    }
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let currentText = selfIntroductionTextView.text ?? ""
    guard let stringRange = Range(range, in: currentText) else {return false}
    
    let changedText = currentText.replacingCharacters(in: stringRange, with: text)
    
    if changedText.count >= 20 {
      textViewCountLabel.text = "20/20"
    } else { textViewCountLabel.text = "\(changedText.count)/20" }
    
    return changedText.count <= 21
  }
}

extension ProfileEditingScrollContentsView {
  @objc private func textDidChange(_ notification: Notification) {
    if let selfIntroductionTextView = notification.object as? UITextView {
      guard let text = selfIntroductionTextView.text else { return }
      
      if text.count >= textViewMaxCount {
        let index = text.index(text.startIndex, offsetBy: textViewMaxCount)
        let newString = text[text.startIndex..<index]
        selfIntroductionTextView.text = String(newString)
      }
    }
  }
}
