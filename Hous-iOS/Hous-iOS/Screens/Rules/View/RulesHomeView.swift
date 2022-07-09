//
//  RulesHomeView.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit

class RulesHomeView: UIView {
  
  enum rulesType {
    case category, todo
  }
  
  enum Size {
    static let categoryCollectionItemSize = CGSize(width: 40, height: 40)
    static let categoryCollectionEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
    static let categoryCollectionItemSpacing = CGFloat(24)
  }
  
  var navigationBarView = MainTabNavigationView(tabType: .rules)
  
  private var horizontalButtonView = UIView()
  var todayTodoButton = UIButton().then {
    $0.setImage(ImageLiteral.todayTodo, for: .normal)
  }
  var categoryCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout()).then {
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = Size.categoryCollectionItemSize
      layout.sectionInset = Size.categoryCollectionEdgeInsets
      layout.minimumInteritemSpacing = Size.categoryCollectionItemSpacing
      layout.scrollDirection = .horizontal
      $0.collectionViewLayout = layout
      $0.showsHorizontalScrollIndicator = false
      $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
  
  var todoDisplayView = RulesTableView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func render() {
    
    self.addSubViews([navigationBarView, horizontalButtonView, todoDisplayView])
    horizontalButtonView.addSubViews([todayTodoButton, categoryCollectionView])
    
    navigationBarView.snp.makeConstraints { make in
      make.top.equalTo(safeAreaLayoutGuide)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(60)
    }
    
    horizontalButtonView.snp.makeConstraints { make in
      make.top.equalTo(navigationBarView.snp.bottom)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(80)
    }
    todayTodoButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.centerY.equalToSuperview()
      make.size.equalTo(40)
    }
    categoryCollectionView.snp.makeConstraints { make in
      make.leading.equalTo(todayTodoButton.snp.trailing).offset(20)
      make.top.bottom.trailing.equalToSuperview()
    }
    
    todoDisplayView.snp.makeConstraints { make in
      make.top.equalTo(horizontalButtonView.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
}
