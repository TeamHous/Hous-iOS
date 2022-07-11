//
//  RulesCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit

class RulesCollectionViewCell: UICollectionViewCell {

  static let identifier = "RulesCollectionViewCell"

  var rulesByCategoryAssignView = UIView()

  var rulesTitleLabel = UILabel().then {
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
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

    self.addSubViews([rulesByCategoryAssignView, rulesTitleLabel])

    rulesByCategoryAssignView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.8)
      make.leading.equalToSuperview().offset(8)
    }

    rulesTitleLabel.snp.makeConstraints { make in
      make.leading.equalTo(rulesByCategoryAssignView.snp.trailing).offset(10)
      make.trailing.equalToSuperview().inset(8)
      make.centerY.equalTo(rulesByCategoryAssignView.snp.centerY)
    }
  }

  private func configure() {
    self.rulesByCategoryAssignView.backgroundColor = .paleGrey
    self.layer.cornerRadius = 15
    self.backgroundColor = .white
  }
}
