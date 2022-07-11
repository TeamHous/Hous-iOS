//
//  CategoryRulesAssignedView.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/12.
//

import UIKit

class CategoryRulesAssignedView: UIView {

  lazy var assignCircleStackView: UIStackView = {
    let stackView = UIStackView()
    return stackView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
