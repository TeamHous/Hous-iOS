//
//  RulesHomeView.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit

enum RulesType {
  case category, todo
}

class RulesHomeView: UIView {
  
  enum Size {
    static let horizontalButtonViewHeight = 110
    static let categoryCollectionItemSize = CGSize(width: 43, height: horizontalButtonViewHeight)
    static let categoryCollectionEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
    static let categoryCollectionItemSpacing = CGFloat(24)
  }

  var rulesType: RulesType = .todo {
    didSet {
      updateRulesView(rulesDisplayView, type: rulesType)
    }
  }
  
  var navigationBarView = NavigationBarView(tabType: .rules)
  
  private var horizontalButtonView = UIView()
  var todayTodoButton = UIButton().then {
    $0.setImage(R.Image.todoSelected, for: .selected)
    $0.setImage(R.Image.todoUnselected, for: .normal)
    $0.isSelected = true
  }
  var categoryCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout()).then {
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = Size.categoryCollectionItemSize
      layout.sectionInset = Size.categoryCollectionEdgeInsets
      layout.minimumLineSpacing = Size.categoryCollectionItemSpacing
      layout.scrollDirection = .horizontal
      $0.collectionViewLayout = layout
      $0.showsHorizontalScrollIndicator = false
      $0.backgroundColor = .white
      $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }

  lazy var categoryView = RulesCategoryTableView()
  lazy var todoView = RulesTodoTableView()
  var rulesDisplayView = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func render() {
    
    self.addSubViews([navigationBarView, horizontalButtonView, rulesDisplayView])
    horizontalButtonView.addSubViews([todayTodoButton, categoryCollectionView])
    
    navigationBarView.snp.makeConstraints { make in
      make.top.equalTo(safeAreaLayoutGuide)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(60)
    }
    
    horizontalButtonView.snp.makeConstraints { make in
      make.top.equalTo(navigationBarView.snp.bottom)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(Size.horizontalButtonViewHeight)
    }
    todayTodoButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.centerY.equalToSuperview()
      make.size.equalTo(40)
    }
    categoryCollectionView.snp.makeConstraints { make in
      make.leading.equalTo(todayTodoButton.snp.trailing).offset(24)
      make.top.bottom.trailing.equalToSuperview()
    }
    
    rulesDisplayView.snp.makeConstraints { make in
      make.top.equalTo(horizontalButtonView.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
}

extension RulesHomeView {
  func updateRulesView(_ view: UIView, type: RulesType) {
    switch rulesType {
    case .category:
      todoView.removeFromSuperview()
      view.addSubview(categoryView)
      categoryView.snp.makeConstraints { make in
          make.edges.equalToSuperview()
      }
    case .todo:
      categoryView.removeFromSuperview()
      view.addSubview(todoView)
      todoView.snp.makeConstraints { make in
          make.edges.equalToSuperview()
      }
    }
  }
}
