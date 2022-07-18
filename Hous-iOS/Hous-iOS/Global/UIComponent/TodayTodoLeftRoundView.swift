//
//  TodayTodoLeftRoundView.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/13.
//

import UIKit
import Then
import SnapKit

class TodayTodoAddAssingnView: UIView {

  private var addImageView = UIImageView().then {
    $0.image = R.Image.assignAdd
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func render() {
    self.addSubview(addImageView)
    addImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

class TodayTodoManyAssignedView: UIView {

  var topLeftView = UIView()
  var topRightView = UIView()
  var bottomLeftView = UIView()
  var bottomRightView = UIView()

  private var firstlineStackView = UIStackView()
  private var secondlineStackView = UIStackView()
  private var stackView = UIStackView().then {
    $0.axis = .vertical
    $0.alignment = .fill
    $0.distribution = .fillEqually
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    configUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func render() {
    self.addSubview(stackView)
    stackView.addArrangedSubviews(firstlineStackView, secondlineStackView)
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    [topLeftView, topRightView, bottomLeftView, bottomRightView].forEach { view in
      view.snp.makeConstraints { make in
        make.height.equalTo(view.snp.width as ConstraintRelatableTarget)
      }
    }
  }

  private func configUI() {
    [firstlineStackView, secondlineStackView].forEach { stackView in
      stackView.axis = .horizontal
      stackView.alignment = .fill
      stackView.distribution = .fillEqually
    }

    [topLeftView, topRightView, bottomLeftView, bottomRightView].forEach { view in
      view.makeRounded(cornerRadius: 10)
    }
  }

  // 두개일 때 [bottomLeftView, topRightView]
  // 세개일 때 [bottomLeftView, topRightView, topLeftView]
  // 네개일 때 [bottomLeftView, topRightView, topLeftView, bottomRightView]
  func setCircle(count: Int, colors: [String]) {

    var assigneeView: [UIView] = []
    var colorsCase: [UIColor] = []
    for color in colors {
      let colorCase = AssigneeColor(rawValue: color)!,
          assignee = AssigneeFactory.makeAssignee(type: colorCase)
      colorsCase.append(assignee.color)
    }
    // 숨김처리 및 보여지는 뷰 배열에 append
    if count == 2 {
      [topLeftView, bottomRightView].forEach {
        $0.isHidden = true
        assigneeView = [bottomLeftView, topRightView]
      }
    } else if count == 3 {
      bottomRightView.isHidden = true
      assigneeView = [bottomLeftView, topRightView, topLeftView]
    } else {
      assigneeView = [bottomLeftView, topRightView, topLeftView, bottomRightView]
    }

    let sequence = zip(colorsCase, assigneeView)
    for (color, view) in sequence {
      view.backgroundColor = color
    }
  }
}

class TodayTodoOneAssignedView: UIView {

  var assigneeImageView = UIImageView()

  convenience init(color: AssigneeColor) {
    self.init(frame: .zero)
    render()
    configUI(color)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func render() {
    self.addSubView(assigneeImageView)
    assigneeImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  private func configUI(_ color: AssigneeColor) {
    let assignee = AssigneeFactory.makeAssignee(type: color)
    assigneeImageView.image = assignee.faceImage
  }
}
