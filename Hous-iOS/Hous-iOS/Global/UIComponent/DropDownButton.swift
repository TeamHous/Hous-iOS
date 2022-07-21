//
//  DropDownButton.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/10.
//

import FlexLayout
import PinLayout

import UIKit
import RxCocoa
import RxSwift
import SnapKit

protocol DropDownProtocol: AnyObject {
  func dropDownPressed(selectedItem: String)
}

final class DropDownButton: UIControl {

  var dropDownPassedData: ((String) -> ())?

  public var selectedItemString: String?
  public var selectedItemSubject = PublishSubject<String>()

  private let screenSize = UIScreen.main.bounds.size


  private let containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.isUserInteractionEnabled = false
    return view
  }()

  private let colorView: UIView = {
    let view = UIView()
    view.isHidden = true
    view.backgroundColor = .yellow
    return view
  }()


  let removeButton: UIButton = {
    let button = UIButton()
    button.isHidden = true

    button.setImage(R.Image.assignRemove, for: .normal)
    return button
  }()


  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .font(.spoqaHanSansNeoMedium, ofSize: 12)
    label.backgroundColor = .white
    label.textColor = R.Color.brownGreyTwo
    return label
  }()

  private let arrowImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .white
    imageView.image = R.Image.dropdownMore
    return imageView
  }()

  var dropView: DropDownView = {
    let view = DropDownView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()


  private let text: String
  private var isCategory: Bool
  private var isFirst: Bool = true

  override var isSelected: Bool {
    didSet {
      if isSelected {
        performAnimation(isShowing: isSelected)
      } else {
        performAnimation(isShowing: isSelected)
      }
    }
  }

  init(text: String, isCategory: Bool = false) {
    self.text = text
    self.isCategory = isCategory
    super.init(frame: .zero)

    titleLabel.text = text
    setupViews()

    dropView.delegate = self
  }

  required init?(coder: NSCoder) {
    fatalError("Error")
  }

  func changeText(text: String?) {
    titleLabel.text = text
  }

  func isHiddenArrow(isHidden: Bool) {
    arrowImageView.isHidden = isHidden
  }

  private func dropDownViewLayout() {

    if isFirst {
      let visibleWindow = window != nil ? window : UIWindow.visibleWindow()
      visibleWindow?.addSubview(dropView)
      visibleWindow?.bringSubviewToFront(dropView)

      guard let windowFrame = windowFrame else { return }


      let heightOffset = windowFrame.origin.y + 40
      let marginOffset = windowFrame.origin.x

      dropView.snp.makeConstraints { make in
        make.top.equalToSuperview().offset(heightOffset)
        make.width.equalTo(screenSize.width - 48)
        make.leading.equalToSuperview().offset(marginOffset)
        make.height.equalTo(0)
      }

      isFirst = false
    }
  }

  private func performAnimation(isShowing: Bool) {
    if isShowing {
      showDropDown()
    }

    if !isShowing {
      dismissDropDown()
    }
  }

  private func setupViews() {

    backgroundColor = .clear
    layer.cornerCurve = .continuous
    layer.cornerRadius = 10

    containerView.layer.masksToBounds = true
    containerView.layer.cornerCurve = .continuous
    containerView.layer.cornerRadius = 10

    addSubview(containerView)
    addSubview(removeButton)

    containerView.addSubview(colorView)
    containerView.addSubview(titleLabel)
    containerView.addSubview(arrowImageView)

    containerView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.equalToSuperview().offset(0)
      make.trailing.equalToSuperview().inset(0)
    }

    removeButton.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().offset(0)
      make.width.height.equalTo(24)
    }

    colorView.snp.makeConstraints { make in
      make.width.height.equalTo(16)
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().offset(12)
    }

    titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(14)
      make.centerY.equalToSuperview()
    }

    arrowImageView.snp.makeConstraints { make in
      make.width.height.equalTo(14)
      make.centerY.equalToSuperview()
      make.trailing.equalToSuperview().inset(14)
    }

  }

  override func layoutSubviews() {
    super.layoutSubviews()
    dropDownViewLayout()
  }

  private func showDropDown() {

    dropView.snp.updateConstraints { make in
      make.height.equalTo(dropView.tableView.contentSize.height)
    }

    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 0.6,
      initialSpringVelocity: 0.0,
      options: .curveEaseInOut,
      animations: {
        self.dropView.layoutIfNeeded()
        self.dropView.center.y += self.dropView.frame.height / 2
      },
      completion: nil
    )
  }

  private func dismissDropDown() {

    dropView.snp.updateConstraints { make in
      make.height.equalTo(0)
    }

    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 0.6,
      initialSpringVelocity: 0.0,
      options: .curveEaseInOut,
      animations: {
        self.dropView.center.y -= self.dropView.frame.height / 2
        self.dropView.layoutIfNeeded()
      },
      completion: nil)
  }

  private func layoutForSelected() {
    removeButton.isHidden = false
    colorView.isHidden = false

    containerView.snp.updateConstraints { make in
      make.leading.equalToSuperview().offset(40)
    }
    titleLabel.snp.updateConstraints { make in
      make.leading.equalToSuperview().offset(34)
    }

    UIView.animate(withDuration: 0.5) {
      self.layoutIfNeeded()
    }

  }

}

extension DropDownButton: DropDownProtocol {
  func dropDownPressed(selectedItem: String) {
    titleLabel.text = selectedItem
    dismissDropDown()
    dropDownPassedData?(selectedItem)
    selectedItemString = selectedItem
    selectedItemSubject.onNext(selectedItem)

    if !isCategory {
      layoutForSelected()
    }
  }
}


extension Reactive where Base: DropDownButton {

  var tap: ControlEvent<Void> {
    return controlEvent(.touchUpInside)
  }

}
