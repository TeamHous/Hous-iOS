//
//  TestCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/14.
//

import UIKit


class TestCollectionViewCell: UICollectionViewCell {
  
  var buttonAction: ((UIButton) -> Void)?
  
  private let testTitleLabel = UILabel().then {
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 20)
    $0.numberOfLines = 2
    $0.lineBreakStrategy = .hangulWordPriority
    $0.lineBreakMode = .byWordWrapping
    $0.textAlignment = .center
  }
  
  private let testImageView = UIImageView().then {
    $0.image = R.Image.testImage1
    $0.contentMode = .scaleAspectFit
  }
  
  private lazy var optionButton1 = UIButton().then {
//    /
    setOptionButton(sender: $0)
  }
  
  private lazy var optionButton2 = UIButton().then {
    setOptionButton(sender: $0)
  }
  
  private lazy var optionButton3 = UIButton().then {
    setOptionButton(sender: $0)
  }
  
  private lazy var buttonStackView = UIStackView(arrangedSubviews: [optionButton1, optionButton2, optionButton3]).then {
    $0.axis = .vertical
    $0.spacing = 16
    $0.distribution = .fillEqually
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setOptionButton(sender: UIButton) {
    var config = UIButton.Configuration.filled()
    config.baseBackgroundColor = R.Color.whitishGrey
    config.baseForegroundColor = R.Color.brownGreyTwo
    
    sender.titleLabel?.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    sender.layer.cornerRadius = 15
    sender.layer.masksToBounds = true
    sender.configuration = config
    sender.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
  }
  
  private func render() {
    self.addSubViews([testTitleLabel, testImageView, buttonStackView])
    
    testTitleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.centerX.equalToSuperview()
    }
    
    testImageView.snp.makeConstraints { make in
      make.top.equalTo(testTitleLabel.snp.bottom).offset(18)
      make.centerX.equalTo(testTitleLabel)
      make.leading.trailing.equalToSuperview().inset(25)
    }
    
    buttonStackView.snp.makeConstraints { make in
      make.top.equalTo(testImageView.snp.bottom).offset(30)
      make.centerX.equalTo(testImageView)
      make.leading.trailing.equalToSuperview().inset(24)
      make.bottom.equalTo(self.safeAreaLayoutGuide)
    }
  }
  
  func setTestData(_ data: TestInfoDataModel) {
    testTitleLabel.text = data.testTitle
    // url -> image
//    testImageView.urlToImage(urlString: data.testImg)
    
    let sequence = zip([optionButton1, optionButton2, optionButton3], data.testAnswers)
    for (button, text) in sequence {
      button.setTitle(text, for: .normal)
      button.titleLabel?.textAlignment = .center
    }
  }
}

extension TestCollectionViewCell {
  @objc private func buttonPressed(_ sender: UIButton) {
    var config = UIButton.Configuration.filled()
    config.baseBackgroundColor = R.Color.veryLightPinkTwo
    config.baseForegroundColor = R.Color.salmon
    
    sender.configuration = config
    
    self.buttonAction?(sender)
  }
}
