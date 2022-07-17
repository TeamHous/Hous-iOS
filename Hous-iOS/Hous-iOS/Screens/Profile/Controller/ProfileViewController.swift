
//
//  ProfileViewController.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/07.
//
import UIKit

final class ProfileViewController : UIViewController {
  
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let infoCellSize = CGSize(width: Size.screenWidth, height: 114)
    static let graphCellSize = CGSize(width: Size.screenWidth, height: 354)
    static let badgeCellSize = CGSize(width: Size.screenWidth, height: 300)
    static let graphEmptyCellSize = CGSize(width: Size.screenWidth, height: 180)
  }
  
  private let navigationBarView = NavigationBarView(tabType: .profile)
  
  private var isProfileEmpty = false
  
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
    setup()
    configUI()
    render()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationController()
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
    view.addSubViews([navigationBarView, profileMainCollectionView])
    
    navigationBarView.snp.makeConstraints { make in
      make.height.equalTo(60)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
    }
    
    profileMainCollectionView.snp.makeConstraints{ make in
      make.top.equalTo(navigationBarView.snp.bottom)
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
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.row{
    case 0:
      guard let cell = profileMainCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileInfoCollectionViewCell.className, for: indexPath) as? ProfileInfoCollectionViewCell else {return UICollectionViewCell()}
      if isProfileEmpty{
        cell.setProfile(color: .veryLightPink)
      }
      return cell
      
    case 1:
      if isProfileEmpty {
        guard let cell = profileMainCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileGraphEmptyCollectionViewCell.className, for: indexPath) as? ProfileGraphEmptyCollectionViewCell else {return UICollectionViewCell()}
        return cell
      }
      guard let cell = profileMainCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileGraphCollectionViewCell.className, for: indexPath) as? ProfileGraphCollectionViewCell else {return UICollectionViewCell()}
      return cell
      
    case 2:
      guard let cell = profileMainCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileBadgeCollectionViewCell.className, for: indexPath) as? ProfileBadgeCollectionViewCell else {return UICollectionViewCell()}
      return cell
      
    default:
      return UICollectionViewCell()
      
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch indexPath.row{
    case 0:
      return Size.infoCellSize
    case 1:
      if isProfileEmpty{
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
