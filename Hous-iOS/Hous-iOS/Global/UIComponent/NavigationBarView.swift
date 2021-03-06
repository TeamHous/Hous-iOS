//
//  NavigationBarView.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

enum TabType: String {
  case home = "Hous-"
  case rules = "Hous- 규칙"
  case profile = "Hous- ME"
}

class NavigationBarView: UIView {
  
  var moveToSettingViewController : (() -> Void)?
  var moveToEditingViewController : (() -> Void)?
  
  private var titleLabel = UILabel().then {
    $0.textColor = R.Color.housBlack
    $0.font = .font(.montserratSemiBold, ofSize: 26)
    $0.text = "Hous-"
  }
  
  private let editingProfileButton = UIButton().then{
    $0.setImage(R.Image.updateProfile, for: .normal)
  }
  
  private let settingProfileButton = UIButton().then{
    $0.setImage(R.Image.settingProfile, for: .normal)
  }
  
  convenience init(tabType: TabType) {
    self.init(frame: .zero)
    render(tabType)
    configure(tabType)
    setup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup(){
    settingProfileButton.addTarget(self, action: #selector(tabSettingProfileButton), for: .touchUpInside)
    editingProfileButton.addTarget(self, action: #selector(tabEditingProfileButton), for: .touchUpInside)
  }
  
  private func render(_ tabType: TabType) {
    
    self.addSubViews([titleLabel])
    titleLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview().multipliedBy(1.3)
      make.leading.equalToSuperview().inset(24)
    }
    
    if tabType == .profile{
      self.addSubViews([editingProfileButton, settingProfileButton])
      
      editingProfileButton.snp.makeConstraints {make in
        make.trailing.equalToSuperview().offset(-60)
        make.centerY.equalToSuperview().multipliedBy(1.5)
        make.width.height.equalTo(24)
      }
      
      settingProfileButton.snp.makeConstraints {make in
        make.trailing.equalToSuperview().offset(-24)
        make.centerY.equalToSuperview().multipliedBy(1.5)
        make.width.height.equalTo(24)
      }
    }
  }
  
  private func configure(_ tabType: TabType) {
    titleLabel.text = tabType.rawValue
  }
}

extension NavigationBarView {
  @objc func tabSettingProfileButton(){
    moveToSettingViewController!()
  }
  
  @objc func tabEditingProfileButton(){
    moveToEditingViewController!()
  }
}
