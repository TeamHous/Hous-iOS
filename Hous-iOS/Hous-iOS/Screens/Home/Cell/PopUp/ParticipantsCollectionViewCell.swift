//
//  EventIconsCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/11.
//

import UIKit

class ParticipantsCollectionViewCell: UICollectionViewCell {
  
  private let participantImageView = UIImageView()
  
  private let participantNameLabel = UILabel().then {
    $0.textAlignment = .center
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
    $0.textColor = R.Color.veryLightPinkFive
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  override func draw(_ rect: CGRect) {
    configUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configUI() {
    participantImageView.layer.cornerRadius = participantImageView.frame.width / 2
  }
  
  private func render() {
    self.addSubViews([participantImageView, participantNameLabel])
    
    participantImageView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(participantImageView.snp.width)
    }
    
    participantNameLabel.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.top.equalTo(participantImageView.snp.bottom).offset(4)
      make.centerX.equalTo(participantImageView)
    }
  }
  
  func setParticipantData(_ data: ParticipantsDataModel) {
    participantImageView.image = data.participantImage
    participantNameLabel.text = data.participantName
  }
}
