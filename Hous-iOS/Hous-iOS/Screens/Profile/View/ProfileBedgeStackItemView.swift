//
//  ProfileBedgeStackItemView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/12.
//

import UIKit
<<<<<<< HEAD
import SwiftUI

class profileBedgeStackItemView : UIView {
=======

class profileBedgeCollectionItemView : UIView {
>>>>>>> e372fde ([#19] FEAT : Profile Main View Bedge Cell item layout 완료)

  private let circle = CircleView()
  
  var bedgeImage = UIImageView().then{
    $0.image = R.Image.badgeLocked
  }
  
  var bedgeName = UILabel().then{
    $0.text = "규칙 한걸음"
    $0.textColor = .black
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 12)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
<<<<<<< HEAD
    configUI()
=======
    configure()
>>>>>>> e372fde ([#19] FEAT : Profile Main View Bedge Cell item layout 완료)
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
<<<<<<< HEAD
  private func configUI(){
=======
  private func configure(){
>>>>>>> e372fde ([#19] FEAT : Profile Main View Bedge Cell item layout 완료)
    self.backgroundColor = .veryLightPinkTwo
  }
  
  private func render(){
    [circle, bedgeImage, bedgeName].forEach {self.addSubview($0)}
    
    circle.snp.makeConstraints {make in
      make.top.equalToSuperview()
      make.width.height.equalTo(70)
    }
    
    bedgeImage.snp.makeConstraints {make in
      make.top.bottom.leading.trailing.equalTo(circle).inset(22)
    }
    
    bedgeName.snp.makeConstraints {make in
      make.top.equalTo(circle.snp.bottom).offset(12)
<<<<<<< HEAD
      make.centerX.equalTo(circle.snp.centerX)
=======
      make.centerY.equalToSuperview()
>>>>>>> e372fde ([#19] FEAT : Profile Main View Bedge Cell item layout 완료)
    }
    
  }
}
<<<<<<< HEAD

struct VCPreView6:PreviewProvider {
    static var previews: some View {
        ProfileViewController().toPreview()
    }
}
=======
>>>>>>> e372fde ([#19] FEAT : Profile Main View Bedge Cell item layout 완료)
