//
//  GraphView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/12.
//
import UIKit

class ProfileGraphView : UIView {
  
  private enum Size{
      static let screenWidth = UIScreen.main.bounds.width
      static let screenHeight = UIScreen.main.bounds.height
    }
  
  var profileGraphView = GraphView()
  var profileGraphBackgroundView = GraphBackgroundView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configUI()
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configUI(){
    self.backgroundColor = .paleGreyTwo
    self.layer.cornerRadius = 10
    self.layer.masksToBounds = true
  }
  
  private func render(){
    self.addSubViews([profileGraphBackgroundView,profileGraphView])
    
    profileGraphView.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview()
    }
    
    profileGraphBackgroundView.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview()
    }
  }
}
  