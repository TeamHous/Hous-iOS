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

final class RulesViewController: UIViewController {

  var categories: Categories?

  let disposeBag = DisposeBag()
  var mainView = RulesHomeView()

  override func loadView() {
    self.view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
    setCollectionView()
    setAction()
    getCategories()
    binding()
  }

  private func configUI() {
    self.navigationController?.navigationBar.isHidden = true
  }
  
  private func setCollectionView() {
    mainView.categoryCollectionView.delegate = self
    mainView.categoryCollectionView.dataSource = self
  }

  private func setAction() {
    mainView.todoTableView.leftAssigneeViewAction = {
      let todayTodoAssignPopUp = TodayTodoAssignPopUpViewController()
      todayTodoAssignPopUp.modalTransitionStyle = .crossDissolve
      todayTodoAssignPopUp.modalPresentationStyle = .overFullScreen
      self.present(todayTodoAssignPopUp, animated: true)
    }
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
    return Category.sampleData.count + 1
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

    indexPath.row != categories?.count ? (self.mainView.rulesType = .category) : (self.mainView.rulesType = .editCategory)

    self.mainView.todayTodoButton.isSelected = false
  }
}
