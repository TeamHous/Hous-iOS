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

  var categories: [Category]?

  let disposeBag = DisposeBag()
  var mainView = RulesHomeView()

  override func loadView() {
    self.view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
    setUp()
    binding()

    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
    longPress.delaysTouchesBegan = true
    mainView.categoryCollectionView.addGestureRecognizer(longPress)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  // MARK: - Method

  private func configUI() {
    self.navigationController?.navigationBar.isHidden = true
  }

  private func setUp() {
    setAction()
    setCollectionView()
    getCategories()
    mainView.categoryEditView.delegate = self
  }

  private func setAction() {
    mainView.todoTableView.leftAssigneeViewAction = {
      let todayTodoAssignPopUp = TodayTodoAssignPopUpViewController()
      todayTodoAssignPopUp.modalTransitionStyle = .crossDissolve
      todayTodoAssignPopUp.modalPresentationStyle = .overFullScreen
      self.present(todayTodoAssignPopUp, animated: true)
    }
  }

  private func setCollectionView() {
    mainView.categoryCollectionView.delegate = self
    mainView.categoryCollectionView.dataSource = self
  }

  private func getCategories() {
    categories = Category.sampleData
  }
}

extension RulesViewController {
  private func binding() {
    mainView.todayTodoButton.rx.tap
      .subscribe { _ in
        if !self.mainView.todayTodoButton.isSelected {
          self.mainView.todayTodoButton.isSelected = true
          self.mainView.rulesType = .todo
        }
        self.mainView.categoryCollectionView.reloadData()
      }
      .disposed(by: disposeBag)

    let todoView = self.mainView.todoTableView
    todoView.myTodoButton.rx.tap
      .subscribe { _ in
        if todoView.todoType == .todayTodo {
          todoView.todoType = .myTodo
          todoView.myTodoButton.isSelected = true
        } else {
          todoView.todoType = .todayTodo
          todoView.myTodoButton.isSelected = false
        }
        todoView.todoCollectionView.reloadData()
      }
      .disposed(by: disposeBag)
  }
}

extension RulesViewController: UICollectionViewDelegate, UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let categories = categories else { return 0 }
    return categories.count + 1
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.className, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }

    if indexPath.row == categories?.count {
      cell.categoryImageView.image = R.Image.categoryAdd
      cell.isSelected = false
    } else {
      cell.setCategory(categories![indexPath.row])
    }

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell

    cell.isSelected = true

    if indexPath.row != categories?.count {
      self.mainView.rulesType = .category
      isNavigatinHidden(isHidden: false)
    } else {
      self.mainView.rulesType = .editCategory
      self.mainView.categoryEditView.editType = .add
      cell.categoryTitleLabel.isHidden = true
      isNavigatinHidden(isHidden: true)
    }

    self.mainView.todayTodoButton.isSelected = false
    self.currentIndexPath = indexPath
  }
}

extension RulesViewController {
  private func isNavigatinHidden(isHidden: Bool) {
    if let tvc = navigationController?.tabBarController as? HousTabbarViewController {
      tvc.housTabbar.isHidden = isHidden
    }
  }
}

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
        //삭제
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

    guard let selectedIndexPath = self.currentIndexPath else { return }

    self.mainView.categoryCollectionView.performBatchUpdates {
      self.mainView.categoryCollectionView.performBatchUpdates {
        self.mainView.categoryCollectionView.deleteItems(at: [selectedIndexPath])
        self.categories?.remove(at: selectedIndexPath.row)
      } completion: { [self] _ in
        mainView.categoryCollectionView.reloadData()
      }
    }
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
    if let indexPath = collectionView.indexPathForItem(at: touchPoint) {

      self.currentIndexPath = indexPath
      guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {return}

      if indexPath.row != self.categories?.count {
        self.mainView.todayTodoButton.isSelected = false
        self.mainView.rulesType = .editCategory
        self.isNavigatinHidden(isHidden: true)
        cell.isSelected = true
        self.mainView.categoryEditView.editType = .update
      }
    }
  }
}
