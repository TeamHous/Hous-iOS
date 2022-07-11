//
//  CategoryRulesAssignedView.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/12.
//

import UIKit
import SnapKit
import Then

class CategoryRulesAssignedView: UIView {

  private enum Size {
    static let circleSize: CGFloat = 16
  }

  lazy var assignedCircleStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = -10
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.axis = .horizontal
    return stackView
  }()

  var assignedCircleView = UIView().then {
    $0.backgroundColor = .veryLightPinkFour
    $0.makeRounded(cornerRadius: Size.circleSize/2)
  }

  var assignedNumLabel = UILabel().then {
    $0.textColor = .softBlue
    $0.font = .font(.montserratMedium, ofSize: 13)
    $0.text = "0"
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func render() {
    self.addSubViews([assignedCircleStackView, assignedNumLabel])
    assignedCircleStackView.addArrangedSubview(assignedCircleView)

    assignedCircleStackView.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(5)
      make.centerY.equalToSuperview()
      make.height.equalTo(16)
    }

    assignedCircleView.snp.makeConstraints { make in
      make.size.equalTo(16)
    }

    assignedNumLabel.snp.makeConstraints { make in
      make.left.equalTo(assignedCircleStackView.snp.right).offset(3)
      make.centerY.equalToSuperview()
      make.right.equalToSuperview().inset(5)
    }
  }
}
