//
//  RulesCategoryTableView.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

final class RulesCategoryTableView: UIView {

  enum Size {
    static let categoryCollectionItemSize = CGSize(width: 327, height: 80)
    static let categoryCollectionEdgeInsets = UIEdgeInsets(top: 28, left: 24, bottom: 12, right: 24)
    static let categoryCollectionItemSpacing = CGFloat(12)
  }

  var categoryCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout()).then {
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = Size.categoryCollectionItemSize
      layout.sectionInset = Size.categoryCollectionEdgeInsets
      layout.minimumInteritemSpacing = Size.categoryCollectionItemSpacing
      layout.scrollDirection = .vertical
      $0.collectionViewLayout = layout
      $0.showsVerticalScrollIndicator = false
      $0.backgroundColor = .white
      $0.register(RulesCollectionViewCell.self, forCellWithReuseIdentifier: RulesCollectionViewCell.identifier)
      $0.register(KeyRulesCollectionViewCell.self, forCellWithReuseIdentifier: KeyRulesCollectionViewCell.identifier)
    }

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    configUI()
    setCollectionView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setCollectionView() {
    categoryCollectionView.delegate = self
    categoryCollectionView.dataSource = self
  }

  private func render() {
    self.addSubView(categoryCollectionView)

    categoryCollectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  private func configUI() {
    self.layer.cornerRadius = 30
    self.backgroundColor = R.Color.paleGrey
  }
}

extension RulesCategoryTableView: UICollectionViewDelegate, UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      print("0")
    case 1:
      print("1")
    case 2:
      print("2")
    default:
      return 0
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    <#code#>
  }


}


