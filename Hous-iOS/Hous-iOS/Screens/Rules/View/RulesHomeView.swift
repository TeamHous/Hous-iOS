//
//  RulesHomeView.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit

class RulesHomeView: UIView {
  
  enum Size {
    static let horizontalButtonViewHeight = 95
    static let categoryCollectionItemSize = CGSize(width: 60, height: horizontalButtonViewHeight)
    static let categoryCollectionEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
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
      layout.scrollDirection = .horizontal
      $0.collectionViewLayout = layout
      $0.showsHorizontalScrollIndicator = false
      $0.backgroundColor = .white
      $0.register(cell: CategoryCollectionViewCell.self)
    }

  lazy var categoryTableView = RulesCategoryTableView()
  lazy var todoTableView = RulesTodoTableView()
  lazy var categoryEditView = RulesCategoryEditView()
  var rulesDisplayView = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    updateRulesView(rulesDisplayView, type: .editCategory)
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
      make.leading.equalTo(todayTodoButton.snp.trailing).offset(22)
      make.top.bottom.trailing.equalToSuperview()
    }
    
    rulesDisplayView.snp.makeConstraints { make in
      make.top.equalTo(horizontalButtonView.snp.bottom)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }

  func updateRulesView(_ view: UIView, type: RulesType) {
    view.subviews.forEach { $0.removeFromSuperview() }
    switch rulesType {
    case .category:
      view.addSubview(categoryTableView)
      categoryTableView.snp.makeConstraints { make in
          make.edges.equalToSuperview()
      }
    case .todo:
      view.addSubview(todoTableView)
      todoTableView.snp.makeConstraints { make in
          make.edges.equalToSuperview()
      }
    case .editCategory:
      view.addSubview(categoryEditView)
      categoryEditView.snp.makeConstraints { make in
          make.edges.equalToSuperview()
      }
      categoryEditView.setInitialView()
    }
  }
}
