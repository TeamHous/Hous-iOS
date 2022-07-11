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
    configUI()
    setCollectionView()
  }

  private func configUI() {
    self.navigationController?.navigationBar.isHidden = true
  }
  
  private func setCollectionView() {
    mainView.categoryCollectionView.delegate = self
    mainView.categoryCollectionView.dataSource = self
  }
}

extension RulesViewController: UICollectionViewDelegate, UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 8
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath)
    return cell

  }
}
