//
//  EventIconsCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/11.
//

import UIKit

class ParticipantsCollectionViewCell: UICollectionViewCell {
  
  let participantButton = UIButton()
  
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
    participantButton.layer.cornerRadius = participantButton.frame.width / 2
  }
  
  private func render() {
    self.addSubViews([participantButton, participantNameLabel])
    
    participantButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(participantButton.snp.width)
    }
    
    participantNameLabel.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.top.equalTo(participantButton.snp.bottom).offset(4)
      make.centerX.equalTo(participantButton)
    }
  }
  
  func setParticipantData(_ data: Participant, isSelected flag: Bool?) {
    let factory = AssigneeFactory.makeAssignee(type: AssigneeColor(rawValue: data.typeColor.lowercased()) ?? .none)
    
    participantButton.setBackgroundImage(factory.faceImage, for: .normal)
    participantButton.setBackgroundImage(factory.checkedFaceImage, for: .selected)
    
    if let flag = flag {
      participantButton.isSelected = flag
    } else {
      participantButton.isSelected = false
    }
    
    participantNameLabel.text = data.userName
  }
}
