//
//  HousTabbarItem.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/07.
//

import UIKit

import SnapKit


final class HousTabbarItemView: UIView {

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white.withAlphaComponent(0.4)
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 11, weight: .semibold)

    return label
  }()

  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  private let containerView = UIView()


  private let item: HousTabbarItem
  let index: Int

  var isSelected = false {
    didSet {
      animateItems()
    }
  }


  init(item: HousTabbarItem, index: Int) {
    self.item = item
    self.index = index
    super.init(frame: .zero)

    nameLabel.text = item.name
    iconImageView.image = isSelected ? item.selectedIcon : item.icon

    setupViews()

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
    addSubview(containerView)

    containerView.addSubview(nameLabel)
    containerView.addSubview(iconImageView)

    containerView.snp.makeConstraints { make in
      make.top.leading.bottom.trailing.equalToSuperview()
    }

    iconImageView.snp.makeConstraints { make in
      make.width.equalTo(40)
      make.height.equalTo(40)
      make.top.equalToSuperview().inset(10)
      make.centerX.equalToSuperview()
    }

    nameLabel.snp.makeConstraints {
      $0.top.equalTo(iconImageView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
    }
  }

  private func animateItems() {
    UIView.animate(withDuration: 0.4) { [weak self] in
      guard let self = self else { return }
      self.nameLabel.textColor = self.isSelected ? .white : .white.withAlphaComponent(0.4)
    }

    UIView.transition(
      with: iconImageView,
      duration: 0.4,
      options: .transitionCrossDissolve) { [weak self] in

        guard let self = self else { return }
        self.iconImageView.image = self.isSelected ? self.item.selectedIcon : self.item.icon
      }
  }

  func animateClick(completion: @escaping () -> Void) {
    UIView.animate(withDuration: 0.15) {
      self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    } completion: { _ in
      UIView.animate(withDuration: 0.15) {
        self.transform = CGAffineTransform.identity
      } completion: { _ in completion() }
    }
  }
}
