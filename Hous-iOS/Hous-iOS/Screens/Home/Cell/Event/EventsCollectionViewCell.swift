//
//  EventsCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {
  
  let addIcon = UIImageView().then {
    $0.image = R.Image.eventAdd
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .paleGold
    $0.isHidden = true
  }
  
  let d_dayLabel = UILabel().then {
    $0.textColor = .white
    $0.font = .font(.montserratSemiBold, ofSize: 20)
  }
  
  let backgroudImageView = UIImageView().then {
    $0.tintColor = .paleGold
  }
  
  let background3DIconImageView = UIImageView().then {
    $0.isHidden = true
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
    contentView.addSubview(backgroudImageView)
    backgroudImageView.addSubViews([background3DIconImageView ,addIcon, d_dayLabel])
    
    backgroudImageView.snp.makeConstraints {
      $0.top.bottom.leading.trailing.equalToSuperview()
    }
    
    background3DIconImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    d_dayLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    
    addIcon.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
  
  private func configUI() {
    layer.cornerRadius = self.bounds.width / 4
  }
  
  func setEventCellData(_ data: EventDataModel) {
    d_dayLabel.text = data.ddayString
  }
  
  func setEventImageData(_ data: EventDataModel) {
    background3DIconImageView.image = data.eventImage
  }
}
