//
//  GraphBoxView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/12.
//

import UIKit
import SwiftUI

class ProfileGraphBoxView : UIView {
  
  let width = UIScreen.main.bounds.width
  
  var personalityLabel = UILabel().then{
    $0.text = "둥그란 동글이"
    $0.textColor = .lilac
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 22)
  }
  
  var profileGraphView = ProfileGraphView()

  
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
    [personalityLabel, profileGraphView].forEach {self.addSubview($0)}
    
    personalityLabel.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(32)
    }
    
    profileGraphView.snp.makeConstraints {make in
      make.top.equalTo(personalityLabel.snp.bottom).offset(29)
      make.bottom.equalToSuperview().offset(-29)
      make.leading.trailing.equalToSuperview().inset(79)
    }
  }
}

struct VCPreView7:PreviewProvider {
    static var previews: some View {
        ProfileViewController().toPreview()
    }
}
