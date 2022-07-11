//
//  ProfileBedgeView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/11.
//

import UIKit

class ProfileBedgeView : UIView {

  let circles = [CircleView(), CircleView(), CircleView()]
  
  private lazy var bedgeGuideStackView = UIStackView().then{
    $0.alignment = .center
    $0.distribution = .equalSpacing
    $0.axis = .horizontal
    $0.spacing = 30
        
  }
  
  
  
 
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure(){
    self.backgroundColor = .veryLightPinkTwo
    self.layer.cornerRadius = 10
    self.layer.masksToBounds = true
  }
  
  private func render(){
    [].forEach {self.addSubview($0)}
    [circles[0], circles[1], circles[2]].forEach {bedgeGuideStackView.addArrangedSubview($0)}
  }
}
