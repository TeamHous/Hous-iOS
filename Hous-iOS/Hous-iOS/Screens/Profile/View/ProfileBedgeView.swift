//
//  ProfileBedgeView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/11.
//

import UIKit
import SwiftUI



class ProfileBedgeView : UIView {
  
  let width = UIScreen.main.bounds.width
  
  private lazy var bedgeGuideStackView = UIStackView().then{
    $0.alignment = .center
    $0.distribution = .fill
    $0.axis = .horizontal
    $0.spacing = width * (30 / 375)
  }
  

  var profileBedgeItems = [profileBedgeStackItemView(),profileBedgeStackItemView(),profileBedgeStackItemView()]
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configUI()
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configUI(){
    self.backgroundColor = .veryLightPinkTwo
    self.layer.cornerRadius = 10
    self.layer.masksToBounds = true
  }
  
  private func render(){
    [bedgeGuideStackView].forEach {self.addSubview($0)}
    profileBedgeItems.forEach {bedgeGuideStackView.addArrangedSubview($0)}
    
    bedgeGuideStackView.snp.makeConstraints {make in
      make.top.bottom.equalToSuperview().inset(28)
      make.centerX.equalToSuperview()
    }
    
    profileBedgeItems.forEach{
      $0.snp.makeConstraints {make in
        make.width.equalTo(70)
        make.height.equalTo(100)
      }
    }
  }
}

struct VCPreView5:PreviewProvider {
    static var previews: some View {
        ProfileViewController().toPreview()
    }
}

