//
//  ProfileBedgeCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/11.
//


import UIKit
import SwiftUI

class ProfileBedgeCollectionViewCell: UICollectionViewCell {
  static var identifier = "ProfileBedgeCollectionViewCell"
    
  let profileBedgeView = ProfileBedgeView()
  
  let titleLabel = UILabel().then{
    $0.text = "나의 배지"
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 20)
  }
  
  let detailInfoButton = UIButton().then{
    $0.setTitle("자세히 보기 ", for: .normal)
    $0.setImage(R.Image.viewMoreButton, for: .normal)
    $0.setTitleColor(.veryLightPinkFour, for: .normal)
    $0.semanticContentAttribute = .forceRightToLeft
    $0.titleLabel?.font = .font(.spoqaHanSansNeoMedium, ofSize: 13)
  }
  

  override init(frame: CGRect){
    super.init(frame: frame)
    configUI()
    render()

  }
    
  required init?(coder: NSCoder){
    fatalError("init(coder:) has not been implemented")
  }
    


  private func configureUI(){
    self.backgroundColor = .purple
    [titleLabel, detailInfoButton, profileBedgeView].forEach {self.addSubview($0)}
  }
    
  private func setConstraints(){
    

    let height = UIScreen.main.bounds.height
      
    titleLabel.snp.makeConstraints{make in
      make.top.equalTo(safeAreaLayoutGuide).offset((14 / 812) * height)
      make.leading.equalToSuperview().offset(24)
    }
    
    detailInfoButton.snp.makeConstraints {make in
      make.bottom.equalTo(titleLabel.snp.bottom)
      make.top.equalTo(safeAreaLayoutGuide).offset((14 / 812) * height)
      make.trailing.equalToSuperview().offset(-24)
      make.width.equalTo(74)
      make.height.equalTo(20)
    }
    
    profileBedgeView.snp.makeConstraints {make in
      make.leading.trailing.equalToSuperview().inset(24)
      make.top.equalTo(titleLabel.snp.bottom).offset(16)
      make.top.bottom.equalToSuperview().inset(28)
    }
  }
}

struct VCPreView4:PreviewProvider {
    static var previews: some View {
        ProfileViewController().toPreview()
    }
}

