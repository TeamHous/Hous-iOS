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
  
  let disposeBag = DisposeBag()
  
  var mainView = RulesHomeView()

  override func loadView() {
    self.view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setCollectionView()
  }
  
  private func setCollectionView() {
    mainView.categoryCollectionView.delegate = self
    mainView.categoryCollectionView.dataSource = self

    switch mainView.rulesType {
    case .category:
//      if let rulesCategoryTableView = mainView.rulesDisplayView as? RulesCategoryTableView {
//        rulesCategoryTableView.categoryCollectionView.delegate = self
//        rulesCategoryTableView.categoryCollectionView.dataSource = self }
      print("우선은 스킵")
    case .todayTodo, .myTodo:
      if let rulesTodoTableView = mainView.rulesDisplayView as? RulesTodoTableView {
        rulesTodoTableView.todoCollectionView.delegate = self
        rulesTodoTableView.todoCollectionView.dataSource = self
      }
    }

  }
}

extension RulesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 8
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    switch collectionView {
    case mainView.categoryCollectionView:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath)
      return cell
    default:
      switch mainView.rulesType {
      case .category:
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath)
//        return cell
        print("우선은 스킵")
      case .todayTodo:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayTodoCollectionViewCell.identifier, for: indexPath)
        return cell
      case .myTodo:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyTodoCollectionViewCell.identifier, for: indexPath)
        return cell
      }
    }
  }

}
