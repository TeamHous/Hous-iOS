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

  func configUI(font: UIFont, text: String, color: UIColor, corner: CGFloat) {
    var container = AttributeContainer()
    container.font = font

    var config = UIButton.Configuration.filled()
    config.attributedTitle = AttributedString(text, attributes: container)
    config.baseBackgroundColor = .white
    config.baseForegroundColor = color
    config.background.strokeColor = color
    config.background.strokeWidth = 2.0

    self.configuration = config
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
    var container = AttributeContainer()
    container.font = font

    var config = UIButton.Configuration.filled()
    config.attributedTitle = AttributedString(text, attributes: container)
    config.baseBackgroundColor = color
    config.baseForegroundColor = .white

    self.configuration = config
    self.layer.cornerRadius = corner
    self.layer.masksToBounds = true
  }

}
