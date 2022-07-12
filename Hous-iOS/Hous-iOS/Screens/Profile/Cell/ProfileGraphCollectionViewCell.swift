//
//  ProfileGraphCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/11.
//


import UIKit
import SwiftUI

class ProfileGraphbCollectionViewCell: UICollectionViewCell {
    
  static var identifier = "ProfileGraphCollectionViewCell"
    

  let titleLabel = UILabel().then{
    $0.text = "나의 성향"
    $0.textColor = .black
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 18)
  }
  
  let detailInfoButton = UIButton().then{
    $0.setTitle("자세히 보기 ", for: .normal)
    $0.setImage(R.Image.viewMoreButton, for: .normal)
    $0.setTitleColor(.veryLightPinkFour, for: .normal)
    $0.semanticContentAttribute = .forceRightToLeft
    $0.titleLabel?.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
  }
  
  let profileGraphBoxView = ProfileGraphBoxView()
  
    
    //MARK: - Override Methods
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    
    private func configureUI(){
      self.backgroundColor = .white
      [titleLabel, detailInfoButton, profileGraphBoxView].forEach {self.addSubview($0)}
    }
    
    private func setConstraints(){
      titleLabel.snp.makeConstraints {make in
        make.leading.equalToSuperview().offset(24)
        make.top.equalToSuperview().offset(10)
      }
      
      detailInfoButton.snp.makeConstraints {make in
        make.trailing.equalToSuperview().offset(-24)
        make.bottom.equalTo(titleLabel.snp.bottom)
        make.width.equalTo(74)
        make.height.equalTo(20)
      }
      
      profileGraphBoxView.snp.makeConstraints {make in
        make.leading.trailing.equalToSuperview().inset(24)
        make.top.equalTo(titleLabel.snp.bottom).offset(19)
        make.height.equalTo(290)
      }
    }
    
    
}

struct VCPreView3:PreviewProvider {
    static var previews: some View {
        ProfileViewController().toPreview()
    }
}
