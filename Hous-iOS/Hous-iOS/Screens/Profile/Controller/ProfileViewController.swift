
//
//  ProfileViewController.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/07.
//
import UIKit

struct ProfileNetworkDataPack {
  let userName, userJob, statusMessage: String
  let hashTag: [String]
  let personalityType: PersonalityType
  let typeId: String
  let typeScore: [Double]
  let notificationState: Bool?
  let isEmptyView: Bool
}

final class ProfileViewController : UIViewController {
  
  var isPresentedFromHomeVC = false {
    didSet {
      if isPresentedFromHomeVC {
        self.navigationBarView.isHidden = true
        
      }
    }
  }
  
  var userId = ""
  
  private var homieProfileData: ProfileDTO?
  
  private var profileNetworkResponse : ProfileDTO?
  
  private var profileNetworkDataPack = ProfileNetworkDataPack(userName: "", userJob: "", statusMessage: "", hashTag: [], personalityType: .empty, typeId: "", typeScore: [], notificationState: false, isEmptyView: true)
  
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let infoCellSize = CGSize(width: Size.screenWidth, height: 114)
    static let graphCellSize = CGSize(width: Size.screenWidth, height: 354)
    static let badgeCellSize = CGSize(width: Size.screenWidth, height: 300)
    static let graphEmptyCellSize = CGSize(width: Size.screenWidth, height: 180)
  }
  
  var navigationBarView = NavigationBarView(tabType: .profile)
  var homieNavigationBarView = ProfileSettingNavigationBarView().then {
    $0.titleLabel.text = "룸메이트 프로필"
    $0.titleLabel.font = .font(.spoqaHanSansNeoBold, ofSize: 18)
    $0.isHidden = true
  }
  
  private let profileMainCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  
  private let item: HousTabbarItem
  
  init(item: HousTabbarItem) {
    self.item = item
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getData()
    setup()
    configUI()
    render()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    profileMainCollectionView.scrollToTop()
    setNavigationController()
    profileMainCollectionView.reloadData()
  }
  
  private func getData() {
    if isPresentedFromHomeVC {
      getHomeDetail(userId: self.userId) { response in
        self.profileNetworkResponse = response
        self.convertResponseToDataPack(self.profileNetworkResponse)
        self.profileMainCollectionView.reloadData()
      }
    } else {
      getNetworkInfo { response in
        self.profileNetworkResponse = response
        self.convertResponseToDataPack(self.profileNetworkResponse)
        self.profileMainCollectionView.reloadData()
      }
    }
  }
  
  private func setNavigationController() {
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    if let tvc = navigationController?.tabBarController as? HousTabbarViewController {
      tvc.housTabbar.isHidden = false
    }
  }
  
  private func setup(){
    setDelegate()
    registerCell()
    navigationBarView.moveToSettingViewController = {  [self] in
      let profileSettingViewController = ProfileSettingViewController()
      navigationController?.pushViewController(profileSettingViewController, animated: true)
    }
    navigationBarView.moveToEditingViewController = {  [self] in
      let profileEditingViewController = ProfileEditingViewController()
      navigationController?.pushViewController(profileEditingViewController, animated: true)
    }
  }
  
  private func configUI() {
    profileMainCollectionView.backgroundColor = .white
    view.backgroundColor = .white
  }
  
  private func render() {
    view.addSubViews([navigationBarView, homieNavigationBarView, profileMainCollectionView])
    
    navigationBarView.snp.makeConstraints { make in
      make.height.equalTo(60)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
    }
    
    homieNavigationBarView.snp.makeConstraints { make in
      make.height.equalTo(60)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
    }
    
    profileMainCollectionView.snp.makeConstraints{ make in
      make.top.equalTo(navigationBarView.snp.bottom).offset(10)
      make.bottom.equalToSuperview()
      make.trailing.leading.equalToSuperview()
    }
    
  }
  
  private func setDelegate() {
    self.profileMainCollectionView.delegate = self
    self.profileMainCollectionView.dataSource = self
  }
  
  private func registerCell() {
    profileMainCollectionView.register(cell: ProfileInfoCollectionViewCell.self)
    profileMainCollectionView.register(cell: ProfileGraphCollectionViewCell.self)
    profileMainCollectionView.register(cell: ProfileBadgeCollectionViewCell.self)
    profileMainCollectionView.register(cell: ProfileGraphEmptyCollectionViewCell.self)
  }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isPresentedFromHomeVC { return 2 }
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.row {
    case 0:
      guard let cell = profileMainCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileInfoCollectionViewCell.className, for: indexPath) as? ProfileInfoCollectionViewCell else {return UICollectionViewCell()}
      cell.setData(profileNetworkDataPack)
      return cell
      
    case 1:
      if profileNetworkDataPack.isEmptyView {
        guard let cell = profileMainCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileGraphEmptyCollectionViewCell.className, for: indexPath) as? ProfileGraphEmptyCollectionViewCell else {return UICollectionViewCell()}
        cell.delegate = self
        if isPresentedFromHomeVC {
          cell.testButton.isEnabled = false
        }
        return cell
      }
      guard let cell = profileMainCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileGraphCollectionViewCell.className, for: indexPath) as? ProfileGraphCollectionViewCell else {return UICollectionViewCell()}
      cell.setData(profileNetworkDataPack)
      cell.moveToTestResultView = { [self] in
        let profileResultView = ProfileTestResultViewController()
        profileResultView.userId = self.userId
        profileResultView.isPresentedFromHomeVC = self.isPresentedFromHomeVC
        profileResultView.modalTransitionStyle = .crossDissolve
        profileResultView.modalPresentationStyle = .fullScreen
        
        present(profileResultView, animated: true)
      }
      return cell
      
    case 2:
      guard let cell = profileMainCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileBadgeCollectionViewCell.className, for: indexPath) as? ProfileBadgeCollectionViewCell else {return UICollectionViewCell()}
      return cell
      
    default:
      return UICollectionViewCell()
      
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch indexPath.row {
    case 0:
      return Size.infoCellSize
    case 1:
      if profileNetworkDataPack.isEmptyView{
        return Size.graphEmptyCellSize
      }
      return Size.graphCellSize
    case 2:
      return Size.badgeCellSize
    default:
      return CGSize(width: 0, height: 0)
    }
  }
}

extension ProfileViewController {
  
  // 서버로부터 가져오는 데이터 형식은 Response 형식으로 관리합니다.
  // 뷰에 직접적으로 적용할 수 있는 데이터 형식은 DataPack 형식으로 관리합니다.
  // Response 형식의 데이터를 DataPack 형식으로 전환하는 로직은
  // convertResponseToDataPack 함수에만 구현합니다.
  // DataPack 형식의 데이터를 View에 적용하는 기능은
  // setData 함수에만 구현합니다.
  
  private func convertResponseToDataPack(_ profileNetworkResponse : ProfileDTO?) {
    guard let profileNetworkResponse = profileNetworkResponse else { return }
    
    let userName = profileNetworkResponse.userName
    let userJob = profileNetworkResponse.job
    let statusMessage = profileNetworkResponse.introduction
    let hashTag = profileNetworkResponse.hashTag
    
    let personalityType: PersonalityType
    let typeId = profileNetworkResponse.typeId
    
    switch profileNetworkResponse.typeColor {
    case "RED" : personalityType = .triangle
    case "BLUE" : personalityType = .rectangle
    case "YELLOW" : personalityType = .round
    case "GREEN" : personalityType = .hexagon
    case "PURPLE" : personalityType = .pentagon
    default : personalityType = .empty
    }
    
    let typeScoreInt = profileNetworkResponse.typeScore
    
    var typeScore: [Double] = []
    typeScoreInt.forEach {
      typeScore.append(Double(10 * $0 - 10))
    }
    let notificationState = profileNetworkResponse.notificationState
    let isEmptyView = personalityType == .empty ? true : false
    
    self.profileNetworkDataPack = ProfileNetworkDataPack(userName: userName, userJob: userJob, statusMessage: statusMessage, hashTag: hashTag, personalityType: personalityType, typeId: typeId, typeScore: typeScore, notificationState: notificationState ?? false, isEmptyView: isEmptyView)
  }
  
  private func getNetworkInfo(completion: @escaping (ProfileDTO) -> Void) {
    ProfileMainAPIService.shared.requestGetProfileMain { result in
      if let responseResult = NetworkResultFactory.makeResult(resultType: result) as? Success<ProfileDTO> {
        guard let response = responseResult.response else {return}
        completion(response)
      } else {
        let responseResult = NetworkResultFactory.makeResult(resultType: result)
        responseResult.resultMethod()
      }
    }
  }
}

extension ProfileViewController: ProfileGraphEmptyCollectionViewCellDelegate {
  func moveToTypeTestInfo() {
    let typeTestInfoVC = ProfileTestInfoViewController()
    
    typeTestInfoVC.modalPresentationStyle = .fullScreen
    typeTestInfoVC.modalTransitionStyle = .crossDissolve
    
    present(typeTestInfoVC, animated: true)
  }
}

// MARK: Network

extension ProfileViewController {
  func getHomeDetail(userId: String, completion : @escaping (ProfileDTO) -> Void) {
    ProfileMainAPIService.shared.requestGetHomieDetail(userId: userId) { result in
      
      if let responseResult = NetworkResultFactory.makeResult(resultType: result)
          as? Success<ProfileDTO> {
        guard let response = responseResult.response else { return }
        
        self.homieProfileData = response
        completion(response)
        
      } else {
        let responseResult = NetworkResultFactory.makeResult(resultType: result)
        responseResult.resultMethod()
      }
    }
  }
}
