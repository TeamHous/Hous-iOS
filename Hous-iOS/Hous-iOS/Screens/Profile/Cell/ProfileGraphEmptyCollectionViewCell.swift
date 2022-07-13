//
//  ProfileGraphEmptyCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/13.
//



import UIKit
import SwiftUI



class ProfileGraphEmptyCollectionViewCell: UICollectionViewCell {
    
  static var identifier = "ProfileGraphEmptyCollectionViewCell"
    

  let titleLabel = UILabel().then{
    $0.text = "나의 성향"
    $0.textColor = .black
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 18)
  }
  
  let testButton = UIButton().then{
    $0.backgroundColor = .salmon
    $0.setTitle("테스트 하러가기", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.layer.cornerRadius = 10
    $0.layer.masksToBounds = true
    $0.titleLabel?.font = .font(.spoqaHanSansNeoBold, ofSize: 18)
  }

  
  
  let profileGraphEmptyBoxView = UIView().then{
    $0.backgroundColor = .veryLightPinkTwo
    $0.layer.cornerRadius = 10
    $0.layer.masksToBounds = true
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
      [profileGraphEmptyBoxView, titleLabel, testButton].forEach {self.addSubview($0)}
      titleLabel.snp.makeConstraints {make in
        make.leading.equalToSuperview().offset(24)
        make.top.equalToSuperview().offset(10)
      }
      
      
      profileGraphEmptyBoxView.snp.makeConstraints {make in
        make.leading.trailing.equalToSuperview().inset(24)
        make.top.equalTo(titleLabel.snp.bottom).offset(19)
        make.height.equalTo(112)
      }
      
      testButton.snp.makeConstraints {make in
        make.leading.trailing.equalToSuperview().inset(86)
        make.top.equalTo(titleLabel.snp.bottom).offset(44)
        make.bottom.equalTo(titleLabel.snp.bottom).offset(100)
      }
      
    }
}
      
      


struct VCPreView9:PreviewProvider {
    static var previews: some View {
        ProfileViewController().toPreview()
    }
}
