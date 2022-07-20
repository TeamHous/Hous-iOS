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

  var leftAssigneeViewAction : ((String) -> Void)?
  var checkButtonUpdateAction: ((_ ruleId: String, _ isCheck: Bool) -> Void)?

  var todayTodoRulesData: [TodayTodoRulesDTO] = [] {
    didSet { self.todoType = .todayTodo }
  }
  var myTodoRulesData: [RulesMyTodoDTO] = [] {
    didSet { self.todoType = .myTodo }
  }

  var todoType: TodoType = .todayTodo {
    didSet { self.todoCollectionView.reloadData() }
  }
  
  enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let itemWidth = screenWidth * 0.9
    static let todoCollectionItemSize = CGSize(width: itemWidth, height: 80)
    static let todoCollectionEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    static let todoCollectionItemSpacing = CGFloat(6)
  }

  var myTodoEmptyLabel = UILabel().then {
    $0.textColor = R.Color.lightPeriwinkle
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    $0.text = "아직 내 담당의 to-do가 없어요!"
    $0.numberOfLines = 0
    $0.isHidden = true
  }
  
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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    setCollectionView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func render() {
    self.addSubViews([myTodoEmptyLabel, todayTodoLabel, myTodoButton, todoCollectionView])

    myTodoEmptyLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview().multipliedBy(0.8)
      make.centerX.equalToSuperview()
    }
    
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

  private func setCollectionView() {
    todoCollectionView.delegate = self
    todoCollectionView.dataSource = self
  }
}

extension RulesTodoTableView: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch todoType {
    case .todayTodo:
      return todayTodoRulesData.count
    case .myTodo:
      return myTodoRulesData.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    switch todoType {
    case .todayTodo:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayTodoCollectionViewCell.className, for: indexPath) as? TodayTodoCollectionViewCell else { return UICollectionViewCell() }

      cell.delegate = self
      cell.setTodayTodoCell(self.todayTodoRulesData[indexPath.row])

      return cell

    case .myTodo:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyTodoCollectionViewCell.className, for: indexPath) as? MyTodoCollectionViewCell else { return UICollectionViewCell() }
      cell.delegate = self
      let ruleId = cell.setMyTodoCell(self.myTodoRulesData[indexPath.row])
      cell.checkButtonAction = {
        cell.checkBoxButton.isSelected ?
        (cell.checkBoxButton.isSelected = false) : (cell.checkBoxButton.isSelected = true)
        cell.delegate?.updateCheckStatus(ruleId: ruleId, isCheck: cell.checkBoxButton.isSelected)
      }
      return cell
    }
  }
}

extension RulesTodoTableView: TodayTodoCollectionViewCellDelegate,
                              MyTodoCheckUpdateDelegate {
  func leftAssigneeViewTouched(ruleId: String) {
    leftAssigneeViewAction?(ruleId)
  }

  func updateCheckStatus(ruleId: String, isCheck: Bool) {
    checkButtonUpdateAction?(ruleId, isCheck)
  }
}
