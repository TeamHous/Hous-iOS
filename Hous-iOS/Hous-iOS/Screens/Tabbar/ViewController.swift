//
//  ViewController.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/07.
//

import UIKit

final class ViewController: UIViewController {

  private let label: UILabel = {
    let label = UILabel()
    label.text = ""
    label.font = .systemFont(ofSize: 12, weight: .bold)
    label.textColor = .blue
    return label
  }()

  private let item: HousTabbarItem

  init(item: HousTabbarItem) {
    self.item = item
    super.init(nibName: nil, bundle: nil)

    setupViews()
    configure(item: item)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  private func setupViews() {
    view.addSubview(label)

    label.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  private func configure(item: HousTabbarItem) {
    label.text = item.name
  }
}
