//
//  ProfileSettingView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/14.
//

import UIKit
import SnapKit
import Then

class ProfileSettingNavigationBarView: UIView {
  
  var popNavigationController : (() -> Void)?
  
  private var titleLabel = UILabel().then {
    $0.textColor = R.Color.housBlack
    $0.font = .font(.montserratSemiBold, ofSize: 26)
    $0.text = "Settings"
  }
  
  private let navigationBackButton = UIButton().then {
    $0.setImage(R.Image.naviBackButton, for: .normal)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup(){
    navigationBackButton.addTarget(self, action: #selector(tabNavigationBackButton), for: .touchUpInside)
  }
  
  private func render() {
    self.addSubViews([titleLabel, navigationBackButton])
    
    titleLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview().multipliedBy(1.5)
      make.centerX.equalToSuperview()
    }
    
    navigationBackButton.snp.makeConstraints {make in
      make.centerY.equalToSuperview().multipliedBy(1.5)
      make.leading.equalToSuperview().offset(24)
    }
  }
}

extension ProfileSettingNavigationBarView {
  @objc func tabNavigationBackButton(){
    popNavigationController!()
  }
}


