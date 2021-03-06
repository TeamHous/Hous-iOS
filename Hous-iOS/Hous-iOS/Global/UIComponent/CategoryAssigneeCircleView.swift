//
//  CategoryAssigneeCircleView.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/12.
//

import UIKit
import SnapKit
import Then


class CategoryAssigneeCircleView: UIView {

  private enum Size {
    static let circleSize: CGFloat = 16
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
    self.snp.makeConstraints { make in
      make.size.equalTo(16)
    }
  }

  private func configUI() {
    self.makeRounded(cornerRadius: Size.circleSize/2)
  }

  func setColor(_ color: String) {
    let assignee = AssigneeFactory.makeAssignee(type: AssigneeColor(rawValue: color.lowercased()) ?? .none)
    self.backgroundColor = assignee.color
  }
}
