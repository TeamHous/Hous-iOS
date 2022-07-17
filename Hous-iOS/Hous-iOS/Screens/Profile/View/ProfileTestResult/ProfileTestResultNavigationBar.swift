//
//  ProfileTestResultNavigationBar.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/17.
//

import UIKit

final class ProfileTestResultNavigationBarView: UIView {
  
  var moveToProfileMainView : (() -> Void)?
  
  private let navigationBackButton = UIButton().then {
    $0.setTitle("완료", for: .normal)
    $0.setTitleColor(.salmon, for: .normal)
    $0.titleLabel?.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
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
    self.addSubViews([navigationBackButton])
    
    navigationBackButton.snp.makeConstraints {make in
      make.centerY.equalToSuperview().multipliedBy(1.5)
      make.trailing.equalToSuperview().inset(24)
    }
  }
}

extension ProfileTestResultNavigationBarView {
  @objc func tabNavigationBackButton(){
    moveToProfileMainView!()
  }
}


