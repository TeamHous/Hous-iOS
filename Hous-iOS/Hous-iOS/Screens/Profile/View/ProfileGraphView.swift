//
//  GraphView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/12.
//


import UIKit
import SwiftUI

class ProfileGraphView : UIView {
  
  let width = UIScreen.main.bounds.width
  
  var profileGraphView = GraphView()
  var profileGraphBackgroundView = GraphBackgroundView()


  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure(){
    self.backgroundColor = .paleGreyTwo
    self.layer.cornerRadius = 10
    self.layer.masksToBounds = true
  }
  
  private func render(){
    
    [profileGraphBackgroundView,profileGraphView].forEach {self.addSubview($0)}
    
    
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

struct VCPreView8:PreviewProvider {
    static var previews: some View {
        ProfileViewController().toPreview()
    }
}
