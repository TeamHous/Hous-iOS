//
//  CircularDayView.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/11.
//

import SnapKit
import UIKit


public enum Day: String, CaseIterable {
  case monday = "월"
  case tuesday = "화"
  case wendsday = "수"
  case thursday = "목"
  case friday = "금"
  case saturday = "토"
  case sunday = "일"
}

final class CircularDayButton: UIButton {

  let day: Day


  init(day: Day) {
    self.day = day
    super.init(frame: .zero)

    clipsToBounds = true
    backgroundColor = .white

    setTitle(day.rawValue, for: .normal)
    setTitleColor(R.Color.softBlue, for: .normal)
    setTitleColor(R.Color.veryLightPinkFive, for: .disabled)

    setBackgroundColor(R.Color.lightPeriwinkle, for: .selected)
    setBackgroundColor(.white, for: .normal)
    setBackgroundColor(R.Color.veryLightPinkThree, for: .disabled)

    titleLabel?.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
    titleLabel?.textAlignment = .center
  }

  required init?(coder: NSCoder) {
    fatalError("Error")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    layer.cornerCurve = .circular
    layer.cornerRadius = bounds.width / 2

  }
}
