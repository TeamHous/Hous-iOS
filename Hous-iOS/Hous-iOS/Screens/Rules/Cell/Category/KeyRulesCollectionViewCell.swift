//
//  KeyRulesCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit

class KeyRulesCollectionViewCell: UICollectionViewCell {

  static let identifier = "KeyRulesCollectionViewCell"

  var rulesTitleLabel = UILabel().then {
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 18)
    $0.textColor = .softBlue
    $0.text = "거실 청소기 돌리기"
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func render() {

    self.addSubView(rulesTitleLabel)

    rulesTitleLabel.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.centerY.equalToSuperview()
    }
  }

  private func configure() {
    self.layer.cornerRadius = 15
    self.backgroundColor = .lightPeriwinkle
  }
}
