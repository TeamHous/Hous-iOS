//
//  CategoryCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

class CategoryCollectionViewCell: UICollectionViewCell {
  
  var categoryImageView = UIImageView().then {
    $0.image = R.Image.clean
  }

  var categoryTitleLabel = UILabel().then {
    $0.textColor = R.Color.brownGreyTwo
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
    $0.textAlignment = .center
    $0.text = "청소"
    $0.isHidden = true
  }

  override var isSelected: Bool {
    didSet {
      self.isSelected ? (categoryTitleLabel.isHidden = false) : (categoryTitleLabel.isHidden = true)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func render() {
    
    self.contentView.addSubViews([categoryImageView, categoryTitleLabel])
    
    categoryImageView.snp.makeConstraints { make in
      make.size.equalTo(43)
      make.center.equalToSuperview()
    }

    categoryTitleLabel.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(categoryImageView.snp.bottom).offset(2)
    }
  }
}

extension CategoryCollectionViewCell {

  func setCategory(_ item: Category) {
    guard let categoryIconType = CategoryIconImage(rawValue: item.categoryIcon.lowercased()) else { return }
    let categoryIcon = CategoryIconFactory.makeIcon(type: categoryIconType)
    self.categoryImageView.image = categoryIcon.unCheckedImage
    self.categoryTitleLabel.text = item.categoryName
  }
}
