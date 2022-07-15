//
//  HousTabbarViewController.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/09.
//

import UIKit

import RxSwift
import SnapKit

class HousTabbarViewController: UITabBarController {

  public let housTabbar: HousTabbar = {
    let tabbar = HousTabbar()
    return tabbar
  }()

  // MARK: - Properties

  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    bind()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  private func setupViews() {
    view.addSubview(housTabbar)
    housTabbar.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview().inset(0)
      $0.height.equalTo(100)
    }

    tabBar.isHidden = true
    selectedIndex = 0
    let controllers = HousTabbarItem.allCases.map { $0.viewController }
    setViewControllers(controllers, animated: true)
  }

  private func selectTabWith(index: Int) {
    self.selectedIndex = index
  }

  private func bind() {
    housTabbar.itemTapped
      .bind { [weak self] in self?.selectTabWith(index: $0) }
      .disposed(by: disposeBag)
  }
}
