//
//  AddRulesCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/11.
//

import UIKit

class AddRulesCollectionViewCell: UICollectionViewCell {

  var plusButton = PlusButton()

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func render() {

    self.addSubView(plusButton)
    plusButton.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
