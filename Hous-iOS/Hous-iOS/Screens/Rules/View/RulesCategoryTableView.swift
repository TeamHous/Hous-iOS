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

  var keyRulesData: [KeyRulesDTO] = [] {
    didSet { categoryCollectionView.reloadData() }
  }
  var rulesData: [RulesDTO] = [] {
    didSet { categoryCollectionView.reloadData() }
  }

  //MARK: - Enum

  enum CategorySection: Int {
    case keyRules, rules, add
  }

  enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let itemWidth = screenWidth * 0.9
    static let rulesItemSize = CGSize(width: itemWidth, height: 46)
    static let addItemSize = CGSize(width: itemWidth, height: 32)
    static let categoryCollectionEdgeInsets = UIEdgeInsets(top: 28, left: 0, bottom: 12, right: 0)
    static let emptyViewSize = CGSize(width: itemWidth, height: 100)
  }

  //MARK: - 변수

  var categoryCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout()).then {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      $0.backgroundColor = .clear
      $0.collectionViewLayout = layout
      $0.showsVerticalScrollIndicator = false
      $0.register(cell: RulesCollectionViewCell.self)
      $0.register(cell: AddRulesCollectionViewCell.self)
      $0.register(cell: KeyRulesCollectionViewCell.self)
      $0.register(cell: EmptyCategoryCollectionViewCell.self)
    }

  //MARK: - 생명주기

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    configUI()
    setCollectionView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Setting

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

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case CategorySection.keyRules.rawValue:
      if keyRulesData.isEmpty && rulesData.isEmpty {
        return 1
      }
      return keyRulesData.count
    case CategorySection.rules.rawValue:
      return rulesData.count
    case CategorySection.add.rawValue:
      return 1
    default:
      return 0
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    switch indexPath.section {
    case 0:
      if keyRulesData.isEmpty && rulesData.isEmpty {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCategoryCollectionViewCell.className, for: indexPath) as? EmptyCategoryCollectionViewCell else { return UICollectionViewCell() }
        return cell
      }
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyRulesCollectionViewCell.className, for: indexPath) as? KeyRulesCollectionViewCell else { return UICollectionViewCell() }
      _ = cell.setKeyRulesCell(keyRulesData[indexPath.row])
      return cell
    case 1:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RulesCollectionViewCell.className, for: indexPath) as? RulesCollectionViewCell else { return UICollectionViewCell() }

      _ = cell.setRulesCell(rulesData[indexPath.row])
      return cell
    case 2:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddRulesCollectionViewCell.className, for: indexPath)
      return cell
    default :
      return UICollectionViewCell()
    }
  }
}

extension RulesCategoryTableView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    switch indexPath.section {
    case CategorySection.keyRules.rawValue, CategorySection.rules.rawValue:
      if keyRulesData.isEmpty && rulesData.isEmpty {
        return Size.emptyViewSize
      }
      return Size.rulesItemSize
    case CategorySection.add.rawValue:
      return Size.addItemSize
    default:
      return CGSize()
    }
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    var inset = Size.categoryCollectionEdgeInsets

    switch section {
    case CategorySection.keyRules.rawValue:
      return inset
    case CategorySection.rules.rawValue:
      inset.top = 0
      return inset
    case CategorySection.add.rawValue:
      inset.top = 4
      inset.bottom = 120
      return inset
    default:
      return UIEdgeInsets.zero
    }
  }
}


