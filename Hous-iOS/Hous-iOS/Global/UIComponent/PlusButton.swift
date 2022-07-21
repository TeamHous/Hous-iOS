//
//  PlusButton.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/11.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class PlusButton: UIControl {

  private let plusImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(
      systemName: "plus",
      withConfiguration: UIImage.SymbolConfiguration(
        pointSize: 16,
        weight: .bold
      )
    )
    imageView.backgroundColor = .white
    return imageView
  }()

  init() {
    super.init(frame: .zero)
    setupViews()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }

  private func setupViews() {
    backgroundColor = .white
    layer.cornerCurve = .continuous
    layer.cornerRadius = 16
    addSubview(plusImageView)

    plusImageView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}

extension Reactive where Base: PlusButton {
  var tap: ControlEvent<Void> {
    return controlEvent(.touchUpInside)
  }
}
