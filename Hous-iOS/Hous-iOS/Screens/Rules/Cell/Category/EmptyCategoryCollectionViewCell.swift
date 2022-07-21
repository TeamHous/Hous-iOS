//
//  EmptyCategoryCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/22.
//

import UIKit

class EmptyCategoryCollectionViewCell: UICollectionViewCell {

  var emptyGuideLabel = UILabel().then {
    $0.textColor = .softBlue
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    $0.text = "카테고리가 비어있어요!\n하단 버튼을 눌러 규칙을 추가해보세요!"
    $0.numberOfLines = 2
    $0.lineBreakMode = .byWordWrapping
    $0.lineBreakStrategy = .hangulWordPriority
    $0.textAlignment = .center
    $0.makeRounded(cornerRadius: 16)
    $0.backgroundColor = .white
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func render() {

    self.addSubView(emptyGuideLabel)
    emptyGuideLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
