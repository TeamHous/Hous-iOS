//
//  TodayTodoLeftRoundView.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/13.
//

import UIKit
import Then
import SnapKit

class TodayTodoAddAssingnButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configUI() {
    self.backgroundColor = .lightPeriwinkle
    self.setImage(R.Image.assignAdd, for: .normal)
    self.titleLabel?.isHidden = true
    self.makeRounded(cornerRadius: 20)
  }

}

class TodayTodoManyAssignedView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    configUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func render() {

  }

  private func configUI() {

  }
}

class TodayTodoOneAssignedView: UIView {

  private var assigneeImageView = UIImageView()

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
    assigneeImageView.image = assignee.image
  }
}
