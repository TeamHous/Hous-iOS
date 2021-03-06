//
//  HousTabbar.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/07.
//

import UIKit

import RxCocoa
import RxGesture
import RxSwift

import SnapKit

final class HousTabbar: UIStackView {

  var itemTapped: Observable<Int> { itemTappedSubject.asObservable() }

  private lazy var itemViews: [HousTabbarItemView] = [homeItemView, rulesItemView, profileItemView]

  private let homeItemView: HousTabbarItemView = {
    let view =  HousTabbarItemView(item: .home, index: 0)
    view.clipsToBounds = true
    return view
  }()

  private let rulesItemView: HousTabbarItemView = {
    let view = HousTabbarItemView(item: .rules, index: 1)
    view.clipsToBounds = true
    return view
  }()
  private let profileItemView: HousTabbarItemView = {
    let view = HousTabbarItemView(item: .profile, index: 2)
    view.clipsToBounds = true
    return view
  }()

  private let itemTappedSubject = PublishSubject<Int>()
  private let disposeBag = DisposeBag()

  init() {
    super.init(frame: .zero)
    setupViews()
    bind()

    selectItem(index: 0)
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {

    axis = .horizontal
    backgroundColor = R.Color.paleGold
    distribution = .fillEqually
    alignment = .center

    layer.cornerRadius = 30

    addArrangedSubview(homeItemView)
    addArrangedSubview(rulesItemView)
    addArrangedSubview(profileItemView)

    itemViews.forEach { view in
      view.snp.makeConstraints { make in
        make.height.equalTo(52)
      }
    }

  }

  public func selectItem(index: Int) {
    itemViews.forEach { $0.isSelected = $0.index == index }
    itemTappedSubject.onNext(index)
  }

  private func bind() {
    homeItemView.rx.tapGesture()
      .when(.recognized)
      .withUnretained(self)
      .bind(onNext: { owner, _ in
        owner.homeItemView.animateClick {
          owner.selectItem(index: 0)
          owner.backgroundColor = R.Color.paleGold
        }
      })
      .disposed(by: disposeBag)

    rulesItemView.rx.tapGesture()
      .when(.recognized)
      .withUnretained(self)
      .bind(onNext: { owner, _ in
        owner.rulesItemView.animateClick {
          owner.selectItem(index: 1)
          owner.backgroundColor = R.Color.softBlue
        }
      })
      .disposed(by: disposeBag)

    profileItemView.rx.tapGesture()
      .when(.recognized)
      .withUnretained(self)
      .bind(onNext: { owner, _ in
        owner.profileItemView.animateClick {
          owner.selectItem(index: 2)
          owner.backgroundColor = R.Color.salmon
        }
      })
      .disposed(by: disposeBag)
  }
}


