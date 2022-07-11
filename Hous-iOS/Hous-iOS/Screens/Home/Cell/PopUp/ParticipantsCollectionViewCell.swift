//
//  EventIconsCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/11.
//

import UIKit

class ParticipantsCollectionViewCell: UICollectionViewCell {
  
  private let participantImageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configUI()
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configUI() {
    self.backgroundColor = .offWhite
    self.layer.cornerRadius = self.bounds.width / 2
  }
  
  private func render() {
    self.addSubview(participantImageView)
    
    participantImageView.snp.makeConstraints { make in
      make.top.bottom.leading.trailing.equalToSuperview()
    }
  }
  
  func setIconData(_ icon: UIImage) {
    participantImageView.image = icon
  }
}
