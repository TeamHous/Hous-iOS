//
//  TwoCustomButton.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/15.
//

import UIKit

class BorderCustomButton: UIButton {

  convenience init(text: String, font: UIFont, color: UIColor) {
    self.init(frame: .zero)
    configUI(text, font, color)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configUI(_ text: String, _ font: UIFont, _ color: UIColor) {
    var container = AttributeContainer()
    container.font = font

    var config = UIButton.Configuration.filled()
    config.attributedTitle = AttributedString(text, attributes: container)
    config.baseBackgroundColor = .white
    config.baseForegroundColor = color
    config.background.strokeColor = color
    config.background.strokeWidth = 2.0

    self.configuration = config
    self.layer.cornerRadius = 15
    self.layer.masksToBounds = true
  }

}

class FilledCustomButton: UIButton {

  convenience init(text: String, font: UIFont, textColor: UIColor, backgroundColor: UIColor) {
    self.init(frame: .zero)
    configUI(text, font, textColor, backgroundColor)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configUI(_ text: String, _ font: UIFont, _ textColor: UIColor, _ backgroundColor: UIColor) {
    var container = AttributeContainer()
    container.font = font

    var config = UIButton.Configuration.filled()
    config.attributedTitle = AttributedString(text, attributes: container)
    config.baseBackgroundColor = backgroundColor
    config.baseForegroundColor = textColor

    self.configuration = config
    self.layer.cornerRadius = 15
    self.layer.masksToBounds = true
  }

}
