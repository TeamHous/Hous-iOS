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
  
  static let identifier = "CategoryCollectionViewCell"
  
  var categoryImageView = UIImageView().then {
    $0.image = R.Image.clean
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func render() {
    
    self.contentView.addSubview(categoryImageView)
    
    categoryImageView.snp.makeConstraints { make in
      make.size.equalTo(43)
      make.center.equalToSuperview()
    }
  }
}
