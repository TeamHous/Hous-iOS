//
//  CommonPopUpViewController.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/16.
//

import UIKit
import SnapKit
import Then

class CommonPopUpViewController: UIViewController {

  var buttonAction : (() -> Void)?

  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let assigneeSize = CGSize(width: 56, height: 82)
  }

  // MARK: - 변수

  private lazy var blurView = UIVisualEffectView().then {
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    $0.effect = blurEffect
    $0.frame = view.bounds
    $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

  var titleLabel = UILabel().then {
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 18)
    $0.textColor = R.Color.greyishBrown
    $0.textAlignment = .center
  }

  var descriptionLabel = UILabel().then {
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 14)
    $0.textColor = R.Color.brownGrey
    $0.numberOfLines = 2
    $0.textAlignment = .center
  }

  private let popUpView = UIView().then {
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 20
  }

  private lazy var popUpCloseButton = UIButton().then {
    $0.setImage(R.Image.popupCloseHome, for: .normal)
    $0.addTarget(self, action: #selector(cancelButtonDidTapped), for: .touchUpInside)
  }

  private lazy var blueBigButton = FilledCustomButton().then {
    $0.configUI(font: .font(.spoqaHanSansNeoMedium, ofSize: 16),
                text: "", color: .softBlue, corner: 10)
    $0.addTarget(self, action: #selector(blueBigButtonTapped), for: .touchUpInside)
  }

  //MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    render()
  }

  private func render() {

    self.view.addSubView(blurView)
    self.view.addSubview(popUpView)
    popUpView.addSubViews([titleLabel, descriptionLabel, popUpCloseButton, blueBigButton])

    popUpView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.equalTo(UIScreen.main.bounds.width * (272/375))
      make.height.equalTo(popUpView.snp.width).multipliedBy(0.68)
    }

    titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(24)
    }

    descriptionLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(titleLabel.snp.bottom).offset(16)
    }

    popUpCloseButton.snp.makeConstraints { make in
      make.centerY.equalTo(titleLabel.snp.centerY)
      make.trailing.equalTo(popUpView).inset(24)
      make.size.equalTo(24)
    }

    blueBigButton.snp.makeConstraints { make in
      make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
      make.leading.trailing.bottom.equalToSuperview().inset(24)
      make.height.equalTo(40)
      make.bottom.equalToSuperview().inset(24)
    }
  }

  func setText(titleText: String, descriptionText: String, buttonText: String) {
    self.titleLabel.text = titleText
    self.descriptionLabel.text = descriptionText
    self.blueBigButton.setTitle(buttonText, for: .normal)
  }
}

//MARK: - Objective-C methods

extension CommonPopUpViewController {
  @objc private func cancelButtonDidTapped() {
    self.dismiss(animated: true)
  }

  @objc private func blueBigButtonTapped() {
    // 서버통신
    self.buttonAction?()
    self.dismiss(animated: true)
  }
}
