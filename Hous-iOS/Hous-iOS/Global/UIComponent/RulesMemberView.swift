//
//  RulesMemberView.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/16.
//

import UIKit

import SnapKit
import SwiftUI
import RxSwift


protocol RuleMemberViewDelegate: AnyObject {
  func didTapDropDownButton(sender: UIButton)
}

final class RulesMemberView: UIView {

  public var isTappedSubject = BehaviorSubject<Bool>(value: false)

  public lazy var dropDownButton: DropDownButton = {
    let button = DropDownButton(text: "담당자 없음")
    return button
  }()

  private let dayStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.alignment = .center
    stackView.spacing = 8

    return stackView
  }()

  fileprivate let btn1 = CircularDayButton(day: .monday)
  fileprivate let btn2 = CircularDayButton(day: .tuesday)
  fileprivate let btn3 = CircularDayButton(day: .wendsday)
  fileprivate let btn4 = CircularDayButton(day: .thursday)
  fileprivate let btn5 = CircularDayButton(day: .friday)
  fileprivate let btn6 = CircularDayButton(day: .saturday)
  fileprivate let btn7 = CircularDayButton(day: .sunday)

   lazy var btns = [
    btn1,
    btn2,
    btn3,
    btn4,
    btn5,
    btn6,
    btn7
  ]

  weak var delegate: RuleMemberViewDelegate?

  init() {
    super.init(frame: .zero)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
  }

  private func setupViews() {

    addSubview(dropDownButton)
    addSubview(dayStackView)

    dropDownButton.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(38)
    }

    dayStackView.snp.makeConstraints { make in
      make.top.equalTo(dropDownButton.snp.bottom).offset(6)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(42)
    }


    for (index, dayButton) in btns.enumerated() {

      dayButton.tag = index
      dayButton.isSelected = false
      dayButton.addTarget(self, action: #selector(didTapDayButton(_: )), for: .touchUpInside)

      dayStackView.addArrangedSubview(dayButton)
      dayButton.snp.makeConstraints { make in
        make.width.height.equalTo(40)
      }
    }
  }

  private func judgeTapped() {
    switch (
      btn1.isSelected,
      btn2.isSelected,
      btn3.isSelected,
      btn4.isSelected,
      btn5.isSelected,
      btn6.isSelected,
      btn7.isSelected
    ) {

    case (false, false, false, false, false, false, false):

      isTappedSubject.onNext(false)

    default:
      isTappedSubject.onNext(true)
    }
  }

  @objc
  private func didTapDayButton(_ sender: UIButton) {
    switch sender.tag {
    case 0:
      btn1.isSelected = !(btn1.isSelected)

    case 1:
      btn2.isSelected = !(btn2.isSelected)

    case 2:
      btn3.isSelected = !(btn3.isSelected)

    case 3:
      btn4.isSelected = !(btn4.isSelected)

    case 4:
      btn5.isSelected = !(btn5.isSelected)

    case 5:
      btn6.isSelected = !(btn6.isSelected)

    case 6:
      btn7.isSelected = !(btn7.isSelected)

    default:
      break
    }
    judgeTapped()
  }


  public func setNoResponsible() {
    dropDownButton.changeText(text: "담당자 없음")
    dropDownButton.isHiddenArrow(isHidden: true)
    dropDownButton.isEnabled = false

    dayStackView.subviews.forEach { dayButton in
      if let dayButton = dayButton as? CircularDayButton {
        dayButton.isSelected = false
        dayButton.isEnabled = false
      }
    }
  }

  public func setDefaultResponsible() {
    dropDownButton.changeText(text: "담당자 없음")
    dropDownButton.isHiddenArrow(isHidden: false)
    dropDownButton.isEnabled = true

    dayStackView.subviews.forEach { dayButton in
      if let dayButton = dayButton as? CircularDayButton {
        dayButton.isEnabled = true
      }
    }
  }

//  public func setResponsible(members: [String], isFirst: Bool = false) {
//
//    if isFirst {
//      dropDownButton.changeText(text: "담당자 없음")
//    }
//    if !isFirst {
//      dropDownButton.changeText(text: members.first)
//      dropDownButton.selectedItemSubject.onNext(members.first!)
//      dropDownButton.selectedItemString = members.first
//    }
//
//    dropDownButton.dropView.dropDownOptions = members
//    dropDownButton.isHiddenArrow(isHidden: false)
//    dropDownButton.isEnabled = true
//
//    dayStackView.subviews.forEach { dayButton in
//      if let dayButton = dayButton as? CircularDayButton {
//        dayButton.isEnabled = true
//      }
//    }
//  }

  public func calculateRemainingMember(members: [HomieDTO]) {

    let drpdownOptions = members.map { item -> (String, UIColor) in
      let factory = AssigneeFactory.makeAssignee(type: AssigneeColor(rawValue: item.typeColor.lowercased()) ?? .none)


      return (item.userName, factory.color)
    }

    dropDownButton.dropView.dropDownOptions = drpdownOptions
    dropDownButton.dropView.tableView.reloadData()
  }
}
