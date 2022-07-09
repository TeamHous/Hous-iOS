//
//  RulesTodoCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit

class RulesTodoCollectionViewCell: UICollectionViewCell {
  
  private let ruleTitleLabel = UILabel().then {
    $0.text = "Key Rules"
    $0.font = .font(FontName.montserratSemiBold, ofSize: 20)
    $0.textColor = R.Color.greyishBrown
    $0.textAlignment = .left
  }
  
  private lazy var ruleLabelStackView = UIStackView().then {
    $0.axis = .vertical
    $0.alignment = .leading
    $0.distribution = .fillEqually
    $0.spacing = 8
  }
  
  private let ruleBackground = UIView().then {
    $0.clipsToBounds = true
  }
  
  private let todoTitleLabel = UILabel().then {
    $0.text = "To-Do"
    $0.font = .font(FontName.montserratSemiBold, ofSize: 20)
    $0.textColor = R.Color.greyishBrown
    $0.textAlignment = .left
  }
  
  private let todoBackground = UIView().then {
    $0.clipsToBounds = true
  }
  
  private lazy var todoLabelStackView = UIStackView().then {
    $0.axis = .vertical
    $0.alignment = .leading
    $0.distribution = .fillEqually
    $0.spacing = 8
  }
  
  let emptyRuleLabel = UILabel().then {
    $0.text = "아직 규칙이 없어요:("
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
    $0.textColor = .brownGreyTwo
    $0.isHidden = true
  }
  
  let emptyTodoLabel = UILabel().then {
    $0.text = "아직 할 일이 없어요:("
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
    $0.textColor = .brownGreyTwo
    $0.isHidden = true
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    configUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    super.preferredLayoutAttributesFitting(layoutAttributes)
    
    layoutIfNeeded()
    
    let titleHeight = ruleTitleLabel.bounds.height
    let stackViewHeight = ruleLabelStackView.bounds.height > todoLabelStackView.bounds.height ? ruleLabelStackView.bounds.height : todoLabelStackView.bounds.height
    
    var frame = layoutAttributes.frame
    frame.size.height = ceil(stackViewHeight + titleHeight + 44)
    layoutAttributes.frame = frame
    
    return layoutAttributes
  }
  
  private func render() {
    contentView.addSubViews([ruleTitleLabel,ruleBackground, todoTitleLabel, todoBackground])
    ruleBackground.addSubview(ruleLabelStackView)
    ruleBackground.addSubview(emptyRuleLabel)
    
    todoBackground.addSubview(todoLabelStackView)
    todoBackground.addSubview(emptyTodoLabel)
    
    ruleTitleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.equalToSuperview().offset(24)
    }
    
    ruleBackground.snp.makeConstraints { make in
      make.top.equalTo(ruleTitleLabel.snp.bottom).offset(12)
      make.leading.equalTo(ruleTitleLabel.snp.leading)
      make.width.equalTo((UIScreen.main.bounds.width - 48 - 15) / 2)
    }
    
    ruleLabelStackView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(20)
    }
    
    todoTitleLabel.snp.makeConstraints { make in
      make.centerY.equalTo(ruleTitleLabel)
      make.leading.equalTo(ruleBackground.snp.trailing).offset(15)
    }
    
    todoBackground.snp.makeConstraints { make in
      make.top.equalTo(todoTitleLabel.snp.bottom).offset(12)
      make.leading.equalTo(todoTitleLabel.snp.leading)
      make.trailing.equalToSuperview().inset(24)
      make.width.equalTo((UIScreen.main.bounds.width - 48 - 15) / 2)
    }
    
    todoLabelStackView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(20)
    }
    
    emptyRuleLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(20)
    }
    
    emptyTodoLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(20)
    }
    
  }
  
  private func configUI() {
    ruleBackground.backgroundColor = UIColor(hex: "EFF5FF")
    todoBackground.backgroundColor = UIColor(hex: "EFF5FF")
    
    ruleBackground.layer.cornerRadius = 16
    todoBackground.layer.cornerRadius = 16
  }
  
  func setRulesData(_ data: [RulesDataModel]) {
    
    data.forEach { item in
      let label = RulesTodosView()
      label.checkButton.isHidden = true
      label.setRulesLabelData(rule: item.ruleString)
      
      ruleLabelStackView.addArrangedSubview(label)
    }
  }
  
  func setTodosData(_ data: [TodoDataModel]) {
    
    data.forEach { item in
      let label = RulesTodosView()
      label.circleImageView.isHidden = true
      label.setRulesLabelData(rule: item.todoString)
      label.setCheckButton(item.isDone)
      
      todoLabelStackView.addArrangedSubview(label)
    }
  }
  
  
}
