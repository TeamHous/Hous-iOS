//
//  RulesCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit

class RulesCollectionViewCell: UICollectionViewCell {

  var assigneeView = CategoryRulesAssigneeView()

  var rulesTitleLabel = UILabel().then {
    $0.textColor = R.Color.housBlack
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

    self.addSubViews([assigneeView, rulesTitleLabel])

    assigneeView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.8)
      make.width.lessThanOrEqualTo(37).priority(.high)
      make.leading.equalToSuperview().offset(8)
    }

    rulesTitleLabel.snp.makeConstraints { make in
      make.leading.equalTo(assigneeView.snp.trailing).offset(10)
      make.trailing.equalToSuperview().inset(8)
      make.centerY.equalTo(assigneeView.snp.centerY)
    }
  }

  private func configure() {
    self.assigneeView.backgroundColor = .paleGrey
    self.assigneeView.makeRounded(cornerRadius: 10)
    self.layer.cornerRadius = 15
    self.backgroundColor = .white
  }

  func setCategoryAssigneeData(_ item: CategoryRulesDataModel) {

    self.rulesTitleLabel.text = item.ruleTitle
    assigneeView.assignedNumLabel.text = String(item.assigneeCount)
    
    var color = item.assigneeColor
    if (color.count > 2) { color = Array(color.prefix(3)) }
    color.forEach { color in
      let view = CategoryAssigneeCircleView()
      view.setColor(color)
      assigneeView.assignedCircleStackView.addArrangedSubview(view)
    }
  }
}
