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

  //MARK: - Enum

  enum CategorySection: Int {
    case keyRules, rules, add
  }

  enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let padding: CGFloat = 48
    static let rulesItemSize = CGSize(width: screenWidth - padding, height: 46)
    static let addItemSize = CGSize(width: screenWidth - padding, height: 32)
    static let categoryCollectionEdgeInsets = UIEdgeInsets(top: 28, left: 0, bottom: 12, right: 0)
  }

  //MARK: - 변수

  var categoryRules: [CategoryRulesDataModel]?

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
    }

  //MARK: - 생명주기

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    configUI()
    setCollectionView()
    getCategoryRules()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Setting

  private func getCategoryRules() {
    categoryRules = CategoryRulesDataModel.sampleData
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

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case CategorySection.keyRules.rawValue:
      return 3
    case CategorySection.rules.rawValue:
      return CategoryRulesDataModel.sampleData.count
    case CategorySection.add.rawValue:
      return 1
    default:
      return 0
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    switch indexPath.section {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyRulesCollectionViewCell.identifier, for: indexPath)
      return cell
    case 1:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RulesCollectionViewCell.identifier, for: indexPath) as? RulesCollectionViewCell else { return UICollectionViewCell() }
      cell.setCategoryAssigneeData(categoryRules![indexPath.row])
      return cell
    case 2:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddRulesCollectionViewCell.identifier, for: indexPath)
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
      inset.bottom = 100 // Issue : 탭바와 겹치는 이슈
      return inset
    default:
      return UIEdgeInsets.zero
    }
  }
}


