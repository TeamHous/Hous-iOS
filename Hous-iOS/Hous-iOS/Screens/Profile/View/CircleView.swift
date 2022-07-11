//
//  ProfileBedgeView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/11.
//

import UIKit

class CircleView : UIView {

  override func draw(_ rect: CGRect) {
    let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
    let color : UIColor = .veryLightPink
    color.setFill()

    path.fill()
    
  }
  
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
  }

  private func render(){
    
  }
}
