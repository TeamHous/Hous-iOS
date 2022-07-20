//
//  AddRulesCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/11.
//

import UIKit

protocol PlusButtonDelegate: AnyObject {
  func didTapPlusButton()
}

final class AddRulesCollectionViewCell: UICollectionViewCell {

  private lazy var plusButton:  PlusButton = {
    let button = PlusButton()
    button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
    return button
  }()

  weak var plusButtonDelegate: PlusButtonDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc
  func didTapPlusButton() {
    plusButtonDelegate?.didTapPlusButton()
  }

  private func render() {

    self.addSubView(plusButton)
    plusButton.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
