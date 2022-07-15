//
//  TwoCustomButton.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/15.
//

import UIKit

class BorderCustomButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configUI(font: UIFont, text: String, borderColor: UIColor, backColor: UIColor, corner: CGFloat) {

    self.titleLabel?.font = font
    self.setTitleColor(borderColor, for: .normal)
    self.setTitle(text, for: .normal)
    self.layer.borderColor = borderColor.cgColor
    self.layer.backgroundColor = backColor.cgColor
    self.layer.borderWidth = 2.0
    self.layer.cornerRadius = corner
    self.layer.masksToBounds = true
  }

}

class FilledCustomButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configUI(font: UIFont, text: String, color: UIColor, corner: CGFloat) {

    self.titleLabel?.font = font
    self.setTitleColor(.white, for: .normal)
    self.setTitle(text, for: .normal)
    self.layer.backgroundColor = color.cgColor
    self.layer.cornerRadius = corner
    self.layer.masksToBounds = true
  }

}
