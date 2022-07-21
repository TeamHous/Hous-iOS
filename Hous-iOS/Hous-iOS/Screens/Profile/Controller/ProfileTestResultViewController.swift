//
//  ProfileTestResultViewController.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/17.
//

import UIKit

struct ProfileTestResultDataPack {
  
  let userNameLabel: String
  let personalityType : PersonalityType
  let personalityTypeLabel: String
  let personalityImageURL: String
  let personalityTitleLabel: String
  let personalityDescriptionLabel: String
  let recommandTitleLabel: String
  let recommandRuleLabel: [String]
  let goodPersonalityType: PersonalityType
  let goodPersonalityLabel: String
  let goodPersonalityImageURL: String
  let badPersonalityType: PersonalityType
  let badPersonalityLabel: String
  let badPersonalityImageURL: String
  
}

final class ProfileTestResultViewController : UIViewController {
  
  var isFromTypeTest = false
  
  var isPresentedFromHomeVC = false 
  
  
  var userId = ""
  
  private var profileNetworkResponse: ProfileTestResultDTO?
  
  private var profileNetworkDataPack = ProfileTestResultDataPack(userNameLabel: "", personalityType: .empty, personalityTypeLabel: "", personalityImageURL: "", personalityTitleLabel: "", personalityDescriptionLabel: "", recommandTitleLabel: "", recommandRuleLabel: [],goodPersonalityType: .empty, goodPersonalityLabel: "", goodPersonalityImageURL: "", badPersonalityType: .empty,  badPersonalityLabel: "", badPersonalityImageURL: "")
  
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let imageCellSize = CGSize(width: Size.screenWidth, height: 364)
    static let textCellSize = CGSize(width: Size.screenWidth, height: 328)
    static let recommendCellSize = CGSize(width: Size.screenWidth, height: 100)
  }
  
  private let navigationBarView = ProfileTestResultNavigationBarView()
  
  private let profileTestResultCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    getData()
    configUI()
    render()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setTabBarVisibility()
  }
  
  private func getData() {
    if isPresentedFromHomeVC {
      getRoomMateNetworkInfo(userId: self.userId) { response in
        self.profileNetworkResponse = response
        self.convertResponseToDataPack(self.profileNetworkResponse)
        self.profileTestResultCollectionView.reloadData()
      }
    } else {
      getNetworkInfo { response in
        self.profileNetworkResponse = response
        self.convertResponseToDataPack(self.profileNetworkResponse)
        self.profileTestResultCollectionView.reloadData()
      }
    }
  }
  
  private func setTabBarVisibility() {
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    if let tvc = navigationController?.tabBarController as? HousTabbarViewController {
      tvc.housTabbar.isHidden = true
    }
  }
  
  private func setup(){
    setDelegate()
    registerCell()
    navigationBarView.moveToProfileMainView = {  [self] in
      if isFromTypeTest {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
      } else {
        dismiss(animated: true)
      }
    }
  }
  
  private func configUI() {
    profileTestResultCollectionView.backgroundColor = .white
    view.backgroundColor = .white
  }
  
  private func render() {
    view.addSubViews([navigationBarView, profileTestResultCollectionView])
    
    navigationBarView.snp.makeConstraints { make in
      make.height.equalTo(60)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
    }
    
    profileTestResultCollectionView.snp.makeConstraints{ make in
      make.top.equalTo(navigationBarView.snp.bottom)
      make.bottom.equalToSuperview()
      make.trailing.leading.equalToSuperview()
    }
  }
  
  private func setDelegate() {
    self.profileTestResultCollectionView.delegate = self
    self.profileTestResultCollectionView.dataSource = self
  }
  
  private func registerCell() {
    profileTestResultCollectionView.register(cell: ProfileTestResultImageCollectionViewCell.self)
    profileTestResultCollectionView.register(cell: ProfileTestResultTextCollectionViewCell.self)
    profileTestResultCollectionView.register(cell: ProfileTestResultRecommendCollectionViewCell.self)
  }
}

extension ProfileTestResultViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.row {
    case 0:
      guard let cell = profileTestResultCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileTestResultImageCollectionViewCell.className, for: indexPath) as? ProfileTestResultImageCollectionViewCell else {return UICollectionViewCell()}
      cell.setData(profileNetworkDataPack)
      return cell
      
    case 1:
      guard let cell = profileTestResultCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileTestResultTextCollectionViewCell.className, for: indexPath) as? ProfileTestResultTextCollectionViewCell else {return UICollectionViewCell()}
      cell.setData(profileNetworkDataPack)
      return cell
      
    case 2:
      guard let cell = profileTestResultCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileTestResultRecommendCollectionViewCell.className, for: indexPath) as? ProfileTestResultRecommendCollectionViewCell else {return UICollectionViewCell()}
      cell.setData(self.profileNetworkDataPack)
      return cell
      
    default:
      return UICollectionViewCell()
      
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch indexPath.row {
    case 0:
      return Size.imageCellSize
    case 1:
      return Size.textCellSize
    case 2:
      return Size.recommendCellSize
    default:
      return CGSize(width: 0, height: 0)
    }
  }
}


extension ProfileTestResultViewController {
  
  private func convertResponseToDataPack(_ profileNetworkResponse : ProfileTestResultDTO?) {
    
    let userNameLabel = profileNetworkResponse!.userName + "님은"
    let personalityType : PersonalityType
    
    switch profileNetworkResponse!.typeColor {
    case "RED" : personalityType = .triangle
    case "BLUE" : personalityType = .rectangle
    case "YELLOW" : personalityType = .round
    case "GREEN" : personalityType = .hexagon
    case "PURPLE" : personalityType = .pentagon
    default : personalityType = .empty
    }
    
    
    let personalityTypeLabel = personalityType.personalityTitleText
    
    let personalityImageURL = profileNetworkResponse!.typeImg
    
    let personalityTitleLabel = profileNetworkResponse!.typeOneComment
    let personalityDescriptionLabel = profileNetworkResponse!.typeDesc
    let recommandTitleLabel = profileNetworkResponse!.typeRulesTitle
    
    var recommandRuleLabel: [String] = []
    profileNetworkResponse!.typeRules.forEach {
      recommandRuleLabel.append($0)
    }
    
    var goodPersonalityType: PersonalityType
    switch profileNetworkResponse!.good.typeName {
    case "늘 행복한 동글이": goodPersonalityType = .round
    case "슈퍼 팔로워 셋돌이": goodPersonalityType = .triangle
    case "룸메 맞춤형 네각이": goodPersonalityType = .rectangle
    case "하이레벨 오각이": goodPersonalityType = .pentagon
    case "룰 세터 육각이": goodPersonalityType = .hexagon
    default: goodPersonalityType = .empty
    }
    
    let goodPersonalityLabel = profileNetworkResponse!.good.typeName
    
    let goodPersonalityImageURL = profileNetworkResponse!.good.typeImg
    
    let badPersonalityType: PersonalityType
    switch profileNetworkResponse!.bad.typeName {
    case "늘 행복한 동글이": badPersonalityType = .round
    case "슈퍼 팔로워 셋돌이": badPersonalityType = .triangle
    case "룸메 맞춤형 네각이": badPersonalityType = .rectangle
    case "하이레벨 오각이": badPersonalityType = .pentagon
    case "룰 세터 육각이": badPersonalityType = .hexagon
    default: badPersonalityType = .empty
    }
    
    
    let badPersonalityLabel = profileNetworkResponse!.bad.typeName
    
    let badPersonalityImageURL = profileNetworkResponse!.bad.typeImg
    
    
    self.profileNetworkDataPack = ProfileTestResultDataPack(userNameLabel: userNameLabel, personalityType: personalityType, personalityTypeLabel: personalityTypeLabel, personalityImageURL: personalityImageURL, personalityTitleLabel: personalityTitleLabel, personalityDescriptionLabel: personalityDescriptionLabel, recommandTitleLabel: recommandTitleLabel, recommandRuleLabel: recommandRuleLabel, goodPersonalityType: goodPersonalityType,  goodPersonalityLabel: goodPersonalityLabel, goodPersonalityImageURL: goodPersonalityImageURL ,badPersonalityType: badPersonalityType, badPersonalityLabel: badPersonalityLabel, badPersonalityImageURL: badPersonalityImageURL)
    
  }
  
  private func getNetworkInfo(completion: @escaping (ProfileTestResultDTO) -> Void) {
    ProfileTestResultAPIService.shared.requestGetTestResult{ result in
      if let responseResult = NetworkResultFactory.makeResult(resultType: result) as? Success<ProfileTestResultDTO> {
        guard let response = responseResult.response else {return}
        completion(response)
      } else {
        let responseResult = NetworkResultFactory.makeResult(resultType: result)
        responseResult.resultMethod()
      }
    }
  }
  
  private func getRoomMateNetworkInfo(userId: String, completion: @escaping (ProfileTestResultDTO) -> Void) {
    ProfileTestResultAPIService.shared.requestGetRoomMateTestResult(userId: userId) { result in
      if let responseResult = NetworkResultFactory.makeResult(resultType: result) as? Success<ProfileTestResultDTO> {
        guard let response = responseResult.response else {return}
        completion(response)
      } else {
        let responseResult = NetworkResultFactory.makeResult(resultType: result)
        responseResult.resultMethod()
      }
    }
  }
}

