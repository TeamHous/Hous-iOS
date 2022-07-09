//
//  RulesTableView.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

class RulesTableView: UIView {
  
  enum Size {
    static let todoCollectionItemSize = CGSize(width: 327, height: 80) // 기기마다 좀 다르게 ...
    static let todoCollectionEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    static let todoCollectionItemSpacing = CGFloat(8)
  }
  
  private var todayTodoLabel = UILabel().then {
    // 폰트, 크기 어쩌구
    $0.text = "오늘의 to-do"
  }
  var myTodoButton = UIButton().then {
    $0.setTitle("나의 to-do ", for: .normal)
    $0.setImage(R.Image.myTodoUnselected, for: .normal)
    $0.setImage(R.Image.myTodoSelected, for: .selected)
    $0.setTitleColor(.paleLavender, for: .normal)
    $0.setTitleColor(.lilac, for: .selected)
    $0.semanticContentAttribute = .forceRightToLeft
    $0.isSelected = false
  }
  var todoCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout()).then {
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = Size.todoCollectionItemSize
      layout.sectionInset = Size.todoCollectionEdgeInsets
      layout.minimumInteritemSpacing = Size.todoCollectionItemSpacing
      layout.scrollDirection = .vertical
      $0.collectionViewLayout = layout
      $0.showsVerticalScrollIndicator = false
      $0.backgroundColor = .white
      $0.register(TodayTodoCollectionViewCell.self, forCellWithReuseIdentifier: TodayTodoCollectionViewCell.identifier)
      $0.register(MyTodoCollectionViewCell.self, forCellWithReuseIdentifier: MyTodoCollectionViewCell.identifier)
    }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func render() {
    self.addSubViews([todayTodoLabel, myTodoButton, todoCollectionView])
    
    todayTodoLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.top.equalToSuperview().offset(8)
    }
    myTodoButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(20)
      make.centerY.equalTo(todayTodoLabel.snp.centerY)
    }
    todoCollectionView.snp.makeConstraints { make in
      make.top.equalTo(todayTodoLabel.snp.bottom).offset(8)
      make.leading.trailing.bottom.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
}
