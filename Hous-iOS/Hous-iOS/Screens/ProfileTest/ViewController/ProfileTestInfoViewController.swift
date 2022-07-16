//
//  ProfileTestViewController.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/14.
//

import UIKit

class ProfileTestInfoViewController: UIViewController {
  
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
  }
  
  private var profileTestData: [TestInfoList] = []
  
  private let testStartImageView = UIImageView().then {
    $0.image = R.Image.testStartCheck
  }
  
  private let testStartLabel = UILabel().then {
    $0.text = "생활패턴 체크 시작"
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 20)
    $0.textColor = R.Color.housBlack
  }
  
  private let testDescriptionLabel = UILabel().then {
    $0.text = "지금부터 15개의 질문에 답변해주세요:) \n 솔직한 답변은 서로를 배려할 수 있는 \n 좋은 기회가 될거에요!"
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 14)
    $0.textColor = R.Color.brownGreyTwo
    $0.numberOfLines = 3
    $0.lineBreakMode = .byWordWrapping
    $0.lineBreakStrategy = .hangulWordPriority
    $0.textAlignment = .center
  }
  
  private lazy var startButton = UIButton().then {
    var container = AttributeContainer()
    container.font = .font(.spoqaHanSansNeoBold, ofSize: 18)
    
    var config = UIButton.Configuration.filled()
    config.attributedTitle = AttributedString("시작하기", attributes: container)
    config.baseBackgroundColor = R.Color.veryLightPinkTwo
    config.baseForegroundColor = R.Color.salmon
    
    $0.configuration = config
    $0.layer.cornerRadius = 15
    $0.layer.masksToBounds = true
    $0.addTarget(self, action: #selector(startProfileTest), for: .touchUpInside)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    getProfileTest()
  }
  
  private func getProfileTest() {
    profileTestData = ProfileTestDTO.sampleData.first!.data
  }
  
  private func render() {
    self.view.addSubViews([testStartImageView, testStartLabel, testDescriptionLabel, startButton])
    
    testStartImageView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(168)
      make.centerX.equalToSuperview()
    }
    
    testStartLabel.snp.makeConstraints { make in
      make.top.equalTo(testStartImageView.snp.bottom)
      make.centerX.equalTo(testStartImageView)
    }
    
    testDescriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(testStartLabel.snp.bottom).offset(8)
      make.centerX.equalTo(testStartImageView)
    }
    
    startButton.snp.makeConstraints { make in
      make.height.equalTo(Size.screenHeight * (60/812))
      make.leading.trailing.equalToSuperview().inset(24)
      make.centerX.equalTo(testStartImageView)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(13)
    }
  }
}

//MARK: Objective-C Methods

extension ProfileTestInfoViewController {
  @objc private func startProfileTest() {
    
    let t = profileTestData.map {
      TestCellItem(dto: $0)
    }
    
    let profileTest = ProfileTestViewController(testCellItem: t)
    profileTest.modalTransitionStyle = .crossDissolve
    profileTest.modalPresentationStyle = .fullScreen
    
    present(profileTest, animated: true)
  }
}
