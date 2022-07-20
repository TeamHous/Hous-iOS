//
//  RulesViewController.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/07.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

/*
 Closure  Delegate
 viewController <- View <- View <- Cell
 View <- View
 View <- View
 */
final class RulesViewController: UIViewController {

  var currentIndexPath: IndexPath?
  var closure: (() -> Void)?

  var rulesTodayTodoData: RulesTodayTodoDTO = RulesTodayTodoDTO(homeRuleCategories: [], todayTodoRules: []) {
    didSet{
      DispatchQueue.main.async {
        self.mainView.categoryCollectionView.reloadData()
      }
    }
  }

  let disposeBag = DisposeBag()
  var mainView = RulesHomeView()
  var viewModel = RulesViewModel()

  override func loadView() {
    self.view = self.mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
    setUp()
    binding()
    longPress()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getRulesTodayTodo()
  }

  // MARK: - Method

  private func configUI() {
    self.navigationController?.navigationBar.isHidden = true
  }

  private func setUp() {
    setAction()
    setCollectionView()
  }

  private func setAction() {
    mainView.todoTableView.leftAssigneeViewAction = { ruleId in
      let todayTodoAssignPopUp = TodayTodoAssignPopUpViewController()
      todayTodoAssignPopUp.ruleId = ruleId
      todayTodoAssignPopUp.modalTransitionStyle = .crossDissolve
      todayTodoAssignPopUp.modalPresentationStyle = .overFullScreen
      self.present(todayTodoAssignPopUp, animated: true)
    }

    mainView.todoTableView.checkButtonUpdateAction = { ruleId, isCheck in
      self.viewModel.updateRulesMyTodoState(roomId: APIConstants.roomID, ruleId: ruleId, isCheck: isCheck) { response in
        print(response.isCheck)
      }
    }
  }

  private func setCollectionView() {
    mainView.categoryCollectionView.delegate = self
    mainView.categoryCollectionView.dataSource = self
    mainView.categoryEditView.delegate = self
  }
}

extension RulesViewController {

  private func binding() {
    mainView.todayTodoButton.rx.tap
      .subscribe { _ in
        if !self.mainView.todayTodoButton.isSelected {
          self.mainView.todoTableView.myTodoButton.isSelected ?
          self.getRulesMyTodo() : self.getRulesTodayTodo()
          self.hideCategoryLabel()
        }
      }
      .disposed(by: disposeBag)

    let todoView = self.mainView.todoTableView
    todoView.myTodoButton.rx.tap
      .subscribe { _ in
        todoView.myTodoButton.isSelected ?
        self.getRulesTodayTodo() : self.getRulesMyTodo()
      }
      .disposed(by: disposeBag)
  }

  private func setTodayTodoTableView() {
    let todoView = self.mainView.todoTableView
    self.mainView.rulesType = .todo
    self.mainView.todayTodoButton.isSelected = true
    todoView.myTodoButton.isSelected = false
    todoView.todoType = .todayTodo
    todoView.todayTodoRulesData = self.rulesTodayTodoData.todayTodoRules
    self.isNavigatinHidden(isHidden: false)
    mainView.todoTableView.todoCollectionView.isHidden = false
    mainView.todoTableView.myTodoEmptyLabel.isHidden = true
  }

  private func setMyTodoTableView() {
    let todoView = self.mainView.todoTableView
    self.mainView.rulesType = .todo
    self.mainView.todayTodoButton.isSelected = true
    todoView.myTodoButton.isSelected = true
    todoView.todoType = .myTodo
    self.isNavigatinHidden(isHidden: false)
    if mainView.todoTableView.myTodoRulesData.isEmpty {
      mainView.todoTableView.todoCollectionView.isHidden = true
      mainView.todoTableView.myTodoEmptyLabel.isHidden = false
    }

  }

  private func hideCategoryLabel() {
    let collectionView = mainView.categoryCollectionView
    if let selectedIndexPath = self.currentIndexPath {
      guard let selectedCell = collectionView.cellForItem(at: selectedIndexPath) as? CategoryCollectionViewCell else {return}
      selectedCell.isSelected = false
    }
  }

  private func longPress() {
    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
    longPress.delaysTouchesBegan = true
    mainView.categoryCollectionView.addGestureRecognizer(longPress)
  }
}

extension RulesViewController {

  private func getRulesTodayTodo() {
    viewModel.getRulesTodayTodo(roomId: APIConstants.roomID) { response in
      self.rulesTodayTodoData = response
      self.setTodayTodoTableView()
    }
  }

  private func getRulesMyTodo() {
    viewModel.getRulesMyTodo(roomId: APIConstants.roomID) { response in
      self.mainView.todoTableView.myTodoRulesData = response
      self.setMyTodoTableView()
    }
  }

  private func getRulesByCategory(categoryId: String) {
    viewModel.getRulesByCategory(roomId: APIConstants.roomID, categoryId: categoryId) {
      response in
      let categoryView = self.mainView.categoryTableView
      categoryView.keyRulesData = response.keyRules
      categoryView.rulesData = response.rules
    }
  }
}

// MARK: - CollectionView

extension RulesViewController: UICollectionViewDelegate, UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let categoryData = rulesTodayTodoData.homeRuleCategories
    return categoryData.count + 1
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.className, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }

    if indexPath.row == rulesTodayTodoData.homeRuleCategories.count {
      cell.categoryImageView.image = R.Image.categoryAdd
      cell.isSelected = false
    } else {
      let categoryData = rulesTodayTodoData.homeRuleCategories
      cell.setCategory(categoryData[indexPath.row])
    }

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if self.currentIndexPath != nil {
      guard let selectedIndexPath = self.currentIndexPath else { return }
      guard let selectedCell = collectionView.cellForItem(at: selectedIndexPath) as? CategoryCollectionViewCell else { return }
      selectedCell.isSelected = false
    }

    self.currentIndexPath = indexPath
    guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
    cell.isSelected = true
    self.mainView.todayTodoButton.isSelected = false

    let categoryData = rulesTodayTodoData.homeRuleCategories
    if indexPath.row != categoryData.count {
      getRulesByCategory(categoryId: cell.categoryId ?? "")
      self.mainView.rulesType = .category
      isNavigatinHidden(isHidden: false)
    } else {
      self.mainView.rulesType = .editCategory
      self.mainView.categoryEditView.editType = .add
      cell.categoryTitleLabel.isHidden = true
      isNavigatinHidden(isHidden: true)
    }
  }
}

// MARK: - Action

extension RulesViewController: RulesCategoryEditViewDelegate {

  func borderButtonTouched(viewType: CategoryEditType) {
    let popUp = CommonPopUpViewController()
    popUp.modalTransitionStyle = .crossDissolve
    popUp.modalPresentationStyle = .overFullScreen
    popUp.setText(
      titleText: viewType.popupTitleText,
      descriptionText: viewType.popupDescriptionText,
      buttonText: viewType.popupButtonText)
    popUp.buttonAction = {
      if viewType == .update {
        self.removeCell()
      }
      self.isNavigatinHidden(isHidden: false)
      self.mainView.rulesType = .todo
    }
    self.present(popUp, animated: true)
  }

  func filledButtonTouched(viewType: CategoryEditType) {
    // 추가하기 서버통신
  }

  private func removeCell() {
    //    개인적인 처리보단 서버통신 한번 더 / 나중에 쓸 수도 있으니까 탄발 봐주세요 ...
    //    guard let selectedIndexPath = self.currentIndexPath else { return }
    //
    //    self.mainView.categoryCollectionView.performBatchUpdates {
    //      self.mainView.categoryCollectionView.deleteItems(at: [selectedIndexPath])
    //      self.[데이터].remove(at: selectedIndexPath.row)
    //    } completion: { [self] _ in
    //      mainView.categoryCollectionView.reloadData()
    //    }
  }
}

extension RulesViewController {
  @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {

    if sender.state != .began { return }
    let collectionView = mainView.categoryCollectionView
    if let selectedIndexPath = self.currentIndexPath {
      guard let selectedCell = collectionView.cellForItem(at: selectedIndexPath) as? CategoryCollectionViewCell else {return}
      selectedCell.isSelected = false
    }

    let touchPoint = sender.location(in: collectionView)
    guard let indexPath = collectionView.indexPathForItem(at: touchPoint) else {return}
    guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {return}
    self.currentIndexPath = indexPath

    if indexPath.row != self.rulesTodayTodoData.homeRuleCategories.count {
      self.currentIndexPath = indexPath
      self.mainView.categoryEditView.editType = .update
      self.mainView.todayTodoButton.isSelected = false
      self.mainView.rulesType = .editCategory
      self.isNavigatinHidden(isHidden: true)
      cell.isSelected = true
    }
  }
}

extension RulesViewController {
  private func isNavigatinHidden(isHidden: Bool) {
    if let tvc = navigationController?.tabBarController as? HousTabbarViewController {
      tvc.housTabbar.isHidden = isHidden
    }
  }
}
