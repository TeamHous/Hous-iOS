//
//  ProfileSettingCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/14.
//

import UIKit

final class ProfileSettingCollectionViewCell: UICollectionViewCell {
  
  private var isNoti = false
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let buttonSize = CGSize(width: 20, height: 20)
  }
  
  private let cellLabel = UILabel().then {
    $0.text = "Setting"
    $0.textColor = .black
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 18)
    $0.backgroundColor = .white
  }
  
  private let notiSettingButton = UIButton().then {
    $0.setImage(R.Image.notiOff, for: .normal)
  }
  
  private let settingButton = UIButton().then {
    $0.setImage(R.Image.viewMoreSettingButton, for: .normal)
  }
  
  override init(frame: CGRect){
    super.init(frame: frame)
    configUI()
    render()
  }
  
  required init?(coder: NSCoder){
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configUI(){
    self.backgroundColor = .white
  }
  
  private func render(){
    self.addSubView(cellLabel)
    cellLabel.snp.makeConstraints {make in
      make.leading.equalToSuperview().offset(24)
      make.top.equalToSuperview().offset(19)
    }
  }
  
  func setButton(isNotiButton: Bool){
    if isNotiButton {
      self.addSubView(notiSettingButton)
      
      notiSettingButton.snp.makeConstraints {make in
        make.trailing.equalToSuperview().inset(32)
        make.top.equalToSuperview().offset(19)
        make.width.height.equalTo(Size.buttonSize)
      }
      
      notiSettingButton.addTarget(self, action: #selector(tabNotiButton), for: .touchUpInside)
    }
    
    else {
      self.addSubView(settingButton)
      settingButton.snp.makeConstraints {make in
        make.trailing.equalToSuperview().inset(32)
        make.top.equalToSuperview().offset(19)
        make.width.height.equalTo(Size.buttonSize)
      }
    }
  }
  
  func setLabel(_ text: String){
    cellLabel.text = text
  }
}

extension ProfileSettingCollectionViewCell{
  @objc func tabNotiButton(){
    if isNoti {
      notiSettingButton.setImage(R.Image.notiOff, for: .normal)
      isNoti = false
    }
    else {
      notiSettingButton.setImage(R.Image.notiOn, for: .normal)
      isNoti = true
    }
  }
}


