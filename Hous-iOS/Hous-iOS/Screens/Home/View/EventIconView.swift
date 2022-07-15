//
//  EventIconsView.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/12.
//

import UIKit

class EventIconView: UIView {
  
  var eventCase: IconImage = .party
  
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
    configUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configUI() {
    iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
  }
  
  private func render() {
    self.addSubview(iconImageView)
    iconImageView.addSubview(iconForegroundImageView)
    
    iconImageView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.equalToSuperview()
      make.width.height.equalTo(44)
    }
    
    iconForegroundImageView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}
