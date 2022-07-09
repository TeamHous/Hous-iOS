//
//  HeaderCollectionReusableView.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
  
  let subtitleLabel = UILabel().then {
    $0.font = .font(.montserratSemiBold, ofSize: 20)
    $0.textColor = .greyishBrown
    $0.textAlignment = .left
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func render() {
    addSubview(subtitleLabel)
    subtitleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.top.trailing.bottom.equalToSuperview()
    }
  }
  
  func setSubTitleLabel(data: String) {
    subtitleLabel.text = data
  }
  
}
