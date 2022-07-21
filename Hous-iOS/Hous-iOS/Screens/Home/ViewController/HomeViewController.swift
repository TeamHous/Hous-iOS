//
//  HomeViewController.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit
import SnapKit
import Then


final class HomeViewController: UIViewController {
  
  private enum HomeSection: Int {
    case events
    case rulesTodo
    case profiles
  }
  
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let eventCellSize = CGSize(width: Size.screenWidth, height: 88)
    static let profileCellSize = CGSize(width: Size.screenWidth / 3 - 22, height: Size.screenWidth / 3 - 22)
    static let titleCellSize = CGSize(width: Size.screenWidth, height: 37)
  }
  
  //MARK: Properties
  
  var navigationBarView = NavigationBarView(tabType: .home)
  
  private var homeData: HomeDTO = HomeDTO(eventList: [], keyRulesList: [], todoList: [], homieProfileList: [], roomCode: "") {
    didSet {
      homeCollectionView.reloadData()
    }
  }
  
  //MARK: UI Compononents
  
  private let homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    $0.collectionViewLayout = layout
    $0.showsVerticalScrollIndicator = false
    
  }
  
  //MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
    render()
    setCollectionView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getHomeAPI()
    showNavigation()
  }
  
  //MARK: Custom Methods
  
  private func showNavigation() {
    isNavigatinHidden(isHidden: false)
  }
  
  private func configUI() {
    self.view.backgroundColor = .white
    self.navigationController?.navigationBar.isHidden = true
  }
  
  private func setCollectionView() {
    homeCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.className)
    
    homeCollectionView.register(cell: ComingEventsCollectionViewCell.self)
    homeCollectionView.register(cell: RulesTodoCollectionViewCell.self)
    homeCollectionView.register(cell: ProfileCollectionViewCell.self)
    
    homeCollectionView.delegate = self
    homeCollectionView.dataSource = self
  }
  
  private func render() {
    view.addSubViews([navigationBarView, homeCollectionView])
    
    navigationBarView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(60)
    }
    
    homeCollectionView.snp.makeConstraints {
      $0.top.equalTo(navigationBarView.snp.bottom).offset(24).multipliedBy(0.9)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  }
  
  private func setHomieProfileCell(cell: ProfileCollectionViewCell, profileIsHidden: Bool) {
    cell.profileImage.isHidden = profileIsHidden
    cell.profileNameLabel.isHidden = profileIsHidden
    
    cell.codeImage.isHidden = !profileIsHidden
    cell.codeLabel.isHidden = !profileIsHidden
  }
  
}


//MARK: Delegate & Datasource

extension HomeViewController: UICollectionViewDelegate {
  
  // profile touched
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if indexPath.row == homeData.homieProfileList.count {
      UIPasteboard.general.string = homeData.roomCode
      if let str = UIPasteboard.general.string {
        print(str)
        // 토스트 메시지 라이브러리로 띄우기 야호
        // 클립보드에 복사됨
      }
      return
    }
    
    if indexPath.section == HomeSection.profiles.rawValue {
      
      let profileHomeVC = ProfileViewController(item: .profile)
      
      profileHomeVC.isPresentedFromHomeVC = true
      
      let homieId = homeData.homieProfileList[indexPath.item].id
      profileHomeVC.userId = homieId
      
      profileHomeVC.homieNavigationBarView.isHidden = false
      profileHomeVC.navigationBarView.isHidden = true
      
      profileHomeVC.homieNavigationBarView.popNavigationController = { [self] in
        navigationController?.popViewController(animated: true)
      }
      
      self.navigationController?.pushViewController(profileHomeVC, animated: true)
    }
    
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    if section == HomeSection.events.rawValue || section == HomeSection.profiles.rawValue {
      return CGSize(width: view.frame.size.width, height: 24)
    }
    
    return CGSize.zero
  }
}

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    switch section {
    case 0..<2:
      return 1
    case 2:
      return homeData.homieProfileList.count + 1
    default:
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    switch indexPath.section {
    case 0:
      guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: ComingEventsCollectionViewCell.className, for: indexPath) as? ComingEventsCollectionViewCell else { return UICollectionViewCell() }
      
      cell.delegate = self
      
      cell.homeData = self.homeData
      cell.eventData = self.homeData.eventList
      
      return cell
    case HomeSection.rulesTodo.rawValue:
      guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: RulesTodoCollectionViewCell.className, for: indexPath) as? RulesTodoCollectionViewCell
      else { return UICollectionViewCell() }
      
      let keyRulesCount = homeData.keyRulesList.count
      let todoListCount = homeData.todoList.count
      
      if homeData.todoList.count == 0 {
        cell.emptyTodoLabel.isHidden = false
      } else {
        cell.emptyTodoLabel.isHidden = true
      }
      
      if homeData.keyRulesList.count == 0 {
        cell.emptyRuleLabel.isHidden = false
      } else {
        cell.emptyRuleLabel.isHidden = true
      }
      
      cell.setRulesData(homeData.keyRulesList, keyRulesCount)
      cell.setTodosData(homeData.todoList, todoListCount)
      
      return cell
    case HomeSection.profiles.rawValue:
      guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.className, for: indexPath) as? ProfileCollectionViewCell
      else { return UICollectionViewCell() }
      
      if indexPath.row == homeData.homieProfileList.count {
        setHomieProfileCell(cell: cell, profileIsHidden: true)
        return cell
      } else {
        setHomieProfileCell(cell: cell, profileIsHidden: false)
      }
      
      cell.setProfileData(homeData.homieProfileList[indexPath.row])
      
      return cell
    default:
      return UICollectionViewCell()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      guard let header = homeCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.className, for: indexPath) as? HeaderCollectionReusableView else { return UICollectionReusableView() }
      
      switch indexPath.section {
      case HomeSection.events.rawValue:
        header.setSubTitleLabel(data: "Coming up-")
      case HomeSection.profiles.rawValue:
        header.setSubTitleLabel(data: "Homie Profile-")
      default:
        return UICollectionReusableView()
      }
      
      return header
    }
    return UICollectionReusableView()
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    // CollectionView dynamic height
    switch indexPath.section {
    case HomeSection.events.rawValue:
      return Size.eventCellSize
    case HomeSection.rulesTodo.rawValue:
      return CGSize(width: Size.screenWidth, height: 200)
    case HomeSection.profiles.rawValue:
      return Size.profileCellSize
    default:
      return CGSize()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
    switch section {
    case HomeSection.events.rawValue:
      return UIEdgeInsets(top: 12, left: 0, bottom: 24, right: 0)
    case HomeSection.rulesTodo.rawValue:
      return UIEdgeInsets(top: 3, left: 0, bottom: 24, right: 0)
    case HomeSection.profiles.rawValue:
      return UIEdgeInsets(top: 12, left: 24, bottom: 120, right: 24)
    default:
      return UIEdgeInsets()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
    switch section {
    case HomeSection.profiles.rawValue:
      return 12
    default:
      return 0
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    
    switch section {
    case HomeSection.profiles.rawValue:
      return 9
    default:
      return 0
    }
  }
}


extension HomeViewController: ComingEventsCollectionViewCellDelegate {
  
  func showNewEventPopup(_ image: UIImage) {
    
    isNavigatinHidden(isHidden: true)
    let popUp = PopUpViewController()
    
    popUp.delegate = self
    
    popUp.modalTransitionStyle = .crossDissolve
    popUp.modalPresentationStyle = .overFullScreen
    popUp.isDefaultPopUp = true
    
    popUp.homieProfileList = self.homeData.homieProfileList
    
    popUp.setDefaultPopUpData(image)
    popUp.selectedEventCase = .party
    
    
    present(popUp, animated: true)
  }
  
  func showPopup(_ data: EventDTO, row: Int) {
    isNavigatinHidden(isHidden: true)
    let popUp = PopUpViewController()
    
    popUp.delegate = self
    
    popUp.modalTransitionStyle = .crossDissolve
    popUp.modalPresentationStyle = .overCurrentContext
    
    popUp.eventData = data
    
    popUp.isDefaultPopUp = false
    
    popUp.setPopUpData(data)
    popUp.selectedEventCase = IconImage(rawValue: data.eventIcon.lowercased()) ?? .party
    
    present(popUp, animated: true)
  }
}

extension HomeViewController: PopUpViewControllerDelegate {
  func donePopUpVC() {
    getHomeAPI()
    showNavigation()
  }
}

extension HomeViewController {
  private func isNavigatinHidden(isHidden: Bool) {
    if let tvc = navigationController?.tabBarController as? HousTabbarViewController {
      tvc.housTabbar.isHidden = isHidden
    }
  }
}

//MARK: Network

extension HomeViewController {
  func getHomeAPI() {
    HomeMainAPIService.shared.requestGetHomeMain(roomId: APIConstants.roomID) { result in
      guard let responseResult = NetworkResultFactory.makeResult(resultType: result) as? Success<HomeDTO>,
            let response = responseResult.response
      else { return }
      
      self.homeData = response
      
      responseResult.resultMethod()
    }
  }
}
