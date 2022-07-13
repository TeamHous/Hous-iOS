//
//  ProfileBedgeCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/11.
//


import UIKit

class ProfileBadgeCollectionViewCell: UICollectionViewCell {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let detailInfoButton = CGSize(width: 74, height: 20)
  }
  
  private let profileBedgeView = ProfileBedgeView()
  
  private let titleLabel = UILabel().then {
    $0.text = "나의 배지"
    $0.textColor = .black
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 20)
    $0.backgroundColor = .white
  }
  
  private let detailInfoButton = UIButton().then {
    $0.setTitle("자세히 보기 ", for: .normal)
    $0.setImage(R.Image.viewMoreButton, for: .normal)
    $0.setTitleColor(.veryLightPinkFour, for: .normal)
    $0.backgroundColor = .white
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
  
  private func configUI(){
    self.backgroundColor = .white
  }
  
  private func render(){
    self.addSubViews([titleLabel, detailInfoButton, profileBedgeView])
    
    titleLabel.snp.makeConstraints{make in
      make.top.equalTo(safeAreaLayoutGuide).offset((14 / 812) * Size.screenHeight)
      make.leading.equalToSuperview().offset(24)
    }
    
    detailInfoButton.snp.makeConstraints {make in
      make.bottom.equalTo(titleLabel.snp.bottom)
      make.trailing.equalToSuperview().offset(-24)
      make.width.height.equalTo(Size.detailInfoButton)
    }
    
    profileBedgeView.snp.makeConstraints {make in
      make.leading.trailing.equalToSuperview().inset(24)
      make.top.equalTo(titleLabel.snp.bottom).offset(16)
    }
  }
}
