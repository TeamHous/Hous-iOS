//
//  RulesTodoTableView.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit
import SnapKit
import Then



final class RulesTodoTableView: UIView {

  // 데이터모델 정의
  
  enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let itemWidth = screenWidth * 0.9
    static let todoCollectionItemSize = CGSize(width: itemWidth, height: 80)
    static let todoCollectionEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 120, right: 20)
    static let todoCollectionItemSpacing = CGFloat(8)
  }

  var todoType: TodoType = .todayTodo
  
  private var todayTodoLabel = UILabel().then {
    $0.textColor = R.Color.housBlack
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 20)
    $0.text = "오늘의 to-do"
  }
  
  var myTodoButton = UIButton().then {
    $0.tintColor = R.Color.housBlack
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
      $0.register(cell: TodayTodoCollectionViewCell.self)
      $0.register(cell: MyTodoCollectionViewCell.self)
    }

  var items: [String] = []
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    todoCollectionView.delegate = self
    todoCollectionView.dataSource = self
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

extension RulesTodoTableView: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return 8
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    switch todoType {
    case .todayTodo:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayTodoCollectionViewCell.className, for: indexPath) as? TodayTodoCollectionViewCell else { return UICollectionViewCell() }
      cell.setLeftRoundView(type: .notAssigned)
      // many랑 one didSet 처리해주기
      return cell
    case .myTodo:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyTodoCollectionViewCell.className, for: indexPath)
      return cell
    }
  }
}
