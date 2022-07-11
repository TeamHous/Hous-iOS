//
//  EventIconsView.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/12.
//

import UIKit

class EventIconView: UIView {
  
  let iconImageView = UIImageView().then {
    $0.isUserInteractionEnabled = true
    $0.backgroundColor = .offWhite
    $0.clipsToBounds = true
  }

  let iconForegroundImageView = UIImageView().then {
    $0.isUserInteractionEnabled = true
    $0.isHidden = true
    $0.image = R.Image.categoryCheck
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func render() {
    self.addSubview(iconImageView)
    iconImageView.addSubview(iconForegroundImageView)
    
    iconImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    iconForegroundImageView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}