//
//  RulesTodoView.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit

class RulesTodosView: UIView {
  
  let circleImageView = UIImageView().then {
    $0.image = R.Image.rulesDot
    $0.tintColor = .softBlue
  }
  
  let checkButton = UIButton().then {
    $0.setImage(R.Image.todoUnchecked, for: .normal)
    $0.setImage(R.Image.todoChecked, for: .selected)
    $0.tintColor = R.Color.softBlue
  }
  
  private let ruleLabel = UILabel().then {
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
    $0.textColor = .housBlack
    $0.textAlignment = .left
    $0.numberOfLines = 1
  }
  
  private lazy var stackView = UIStackView(arrangedSubviews: [circleImageView, checkButton, ruleLabel]).then {
    $0.axis = .horizontal
    $0.alignment = .center
    $0.spacing = 8
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func render() {
    addSubViews([stackView])
    circleImageView.snp.makeConstraints {
      $0.height.width.equalTo(8)
    }
    
    checkButton.snp.makeConstraints {
      $0.height.width.equalTo(14)
    }
    
    ruleLabel.snp.makeConstraints {
      $0.leading.equalTo(circleImageView.snp.trailing).offset(8)
      $0.trailing.equalToSuperview()
    }
    
    stackView.snp.makeConstraints {
      $0.top.bottom.leading.trailing.equalToSuperview()
    }
  }
  
  func setRulesLabelData(rule: String) {
    ruleLabel.text = rule
  }
  
  func setCheckButton(_ isDone: Bool) {
    checkButton.isSelected = isDone
  }
}
