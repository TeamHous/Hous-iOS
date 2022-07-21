//
//  ProfileTestResultRecommendCell.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/17.
//
import UIKit

final class ProfileTestResultRecommendCollectionViewCell : UICollectionViewCell {
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let stackViewHeight = 180
  }
  
  private let profileTestResultRecommendStackView = UIStackView().then {
    $0.distribution = .fillProportionally
    $0.alignment = .fill
    $0.axis = .horizontal
    $0.spacing = 11
  }
  
  private var badRecommendView = ProfileRecommendBoxView(personalityType: .hexagon, cellType: .bad)
  
  private var goodRecommmendView = ProfileRecommendBoxView(personalityType: .triangle, cellType: .good)
  
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
    profileTestResultRecommendStackView.addArrangedSubviews(badRecommendView, goodRecommmendView)
    self.addSubView(profileTestResultRecommendStackView)
    
    profileTestResultRecommendStackView.snp.makeConstraints {make in
      make.leading.trailing.equalToSuperview().inset(24)
      make.top.equalToSuperview()
      make.height.equalTo(Size.stackViewHeight)
    }
  }
  
  func setData(_ dataPack: ProfileTestResultDataPack) {
    self.badRecommendView.backgroundColor = dataPack.badPersonalityType.backgroundColor
    self.badRecommendView.titleLabel.textColor = dataPack.badPersonalityType.textColor
    self.badRecommendView.personalityLabel.text = dataPack.badPersonalityLabel
    self.badRecommendView.personalityImageView.urlToImage(urlString: dataPack.badPersonalityImageURL)
    self.goodRecommmendView.backgroundColor = dataPack.goodPersonalityType.backgroundColor
    self.goodRecommmendView.titleLabel.textColor = dataPack.goodPersonalityType.textColor
    self.goodRecommmendView.personalityLabel.text = dataPack.goodPersonalityLabel
    self.goodRecommmendView.personalityImageView.urlToImage(urlString: dataPack.goodPersonalityImageURL)
  }
}
