//
//  CategoryButton.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/21.
//

import UIKit

class CategoryButton: UIButton {

  var categoryIcon: CategoryIconImage = .clean {
    didSet {
      configUI()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configUI() {
    let icon = CategoryIconFactory.makeIcon(type: categoryIcon)
    self.setImage(icon.unCheckedImage, for: .normal)
    self.setImage(icon.checkedImage, for: .selected)
  }
}
