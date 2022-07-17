//
//  ProfileGraphCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/11.
//


import UIKit

final class ProfileGraphCollectionViewCell: UICollectionViewCell {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let detailInfoButton = CGSize(width: 74, height: 20)
  }
  
  private let titleLabel = UILabel().then {
    $0.text = "나의 성향"
    $0.textColor = .black
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 18)
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
  
  let profileGraphBoxView = ProfileGraphBoxView()
  
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
    self.addSubViews([titleLabel, detailInfoButton, profileGraphBoxView])
    titleLabel.snp.makeConstraints {make in
      make.leading.equalToSuperview().offset(24)
      make.top.equalToSuperview().offset(10)
    }
    
    detailInfoButton.snp.makeConstraints {make in
      make.trailing.equalToSuperview().offset(-24)
      make.bottom.equalTo(titleLabel.snp.bottom)
      make.width.height.equalTo(Size.detailInfoButton)
    }
    
    profileGraphBoxView.snp.makeConstraints {make in
      make.leading.trailing.equalToSuperview().inset(24)
      make.top.equalTo(titleLabel.snp.bottom).offset(19)
      make.height.equalTo(290)
    }
  }
}
