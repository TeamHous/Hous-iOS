//
//  QuitTestPopUpViewController.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class QuitTestPopViewController: UIViewController {
  
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
  }
  
  private lazy var blurView = UIVisualEffectView().then {
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    $0.effect = blurEffect
    $0.frame = view.bounds
    $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
  
  private let popUpView = UIView().then {
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 20
  }
  
  private let titleLabel = UILabel().then {
    $0.text = "테스트를 완료하지 않았어요 \n 여기서 그만둘까요?"
    $0.numberOfLines = 2
    $0.lineBreakMode = .byWordWrapping
    $0.lineBreakStrategy = .hangulWordPriority
    $0.textAlignment = .center
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 18)
  }
  
  private let subtitleLabel = UILabel().then {
    $0.text = "나중에 다시 할 수 있어요"
    $0.textAlignment = .center
    $0.textColor = R.Color.veryLightPinkFive
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 12)
  }
  
  private lazy var cancelButton = UIButton().then {
    var config = UIButton.Configuration.filled()
    var container = AttributeContainer()
    container.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    
    config.attributedTitle = AttributedString("그만두기", attributes: container)
    config.baseBackgroundColor = R.Color.salmon
    config.baseForegroundColor = .white
    
    $0.configuration = config
    $0.layer.cornerRadius = 15
    $0.layer.masksToBounds = true
    $0.addTarget(self, action: #selector(cancelButtonDidTapped), for: .touchUpInside)
  }
  
  private lazy var continueButton = UIButton().then {
    var config = UIButton.Configuration.filled()
    var container = AttributeContainer()
    container.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    
    config.baseBackgroundColor = R.Color.veryLightPinkThree
    config.baseForegroundColor = R.Color.brownGrey
    config.attributedTitle = AttributedString("계속하기", attributes: container)
    
    $0.configuration = config
    $0.layer.cornerRadius = 15
    $0.layer.masksToBounds = true
    $0.addTarget(self, action: #selector(cancelButtonDidTapped), for: .touchUpInside)
  }
  
  private lazy var buttonStackView = UIStackView(arrangedSubviews: [continueButton, cancelButton]).then {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.spacing = 9
  }
  
  //MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    render()
  }
  
  //MARK: Custom Methods
  
  private func render() {
    self.view.addSubview(blurView)
    self.view.addSubview(popUpView)
    popUpView.addSubViews([titleLabel, subtitleLabel, buttonStackView])
    
    popUpView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.equalTo(Size.screenWidth * (295/375))
      make.height.equalTo(Size.screenHeight * (187/812))
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(popUpView).inset(33)
      make.centerX.equalTo(popUpView)
    }
    
    subtitleLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(6)
      make.centerX.equalTo(titleLabel)
    }
    
    buttonStackView.snp.makeConstraints { make in
      make.top.equalTo(subtitleLabel.snp.bottom).offset(20)
      make.leading.trailing.equalTo(popUpView).inset(19)
      make.bottom.equalTo(popUpView).inset(16)
      make.height.equalTo(50)
    }
  }
}


//MARK: Objective-C methods

extension QuitTestPopViewController {
  @objc private func cancelButtonDidTapped() {
    self.dismiss(animated: true)
  }
}
