//
//  TodayTodoCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit

class TodayTodoCollectionViewCell: UICollectionViewCell {
  
  // add, 여러명, 한명 분기처리 해야함
  
  private var labelStackView = UIStackView().then {
    $0.alignment = .fill
    $0.distribution = .fillProportionally
    $0.axis = .vertical
    $0.spacing = 8
  }
  var todoTitleLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 16)
    $0.text = "화장실 청소"
  }
  var managerLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 13)
    $0.textColor = R.Color.lightPeriwinkle
    $0.text = "담당자 선택하기"
  }
  var addManagerButton = UIButton().then {
    $0.setImage(R.Image.assignAdd, for: .normal)
  }
  var doneCheckBoxImageView = UIImageView().then {
    $0.image = R.Image.rulesChecked
    //$0.isHidden = true
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
    
    self.addSubViews([labelStackView, addManagerButton, doneCheckBoxImageView])
    labelStackView.addArrangedSubview(todoTitleLabel)
    labelStackView.addArrangedSubview(managerLabel)
    
    labelStackView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(20)
      make.leading.equalTo(addManagerButton.snp.trailing).offset(20)
      make.trailing.greaterThanOrEqualTo(doneCheckBoxImageView.snp.leading).inset(20)
    }
    
    addManagerButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(20)
      make.size.equalTo(40)
      make.centerY.equalTo(labelStackView.snp.centerY)
    }
    doneCheckBoxImageView.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(20)
      make.size.equalTo(24)
      make.centerY.equalTo(labelStackView.snp.centerY)
    }
  }
  
  private func configure() {
    self.layer.cornerRadius = 15
    self.backgroundColor = R.Color.paleGrey
  }
}
