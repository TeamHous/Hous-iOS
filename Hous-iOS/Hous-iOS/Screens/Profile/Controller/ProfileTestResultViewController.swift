//
//  ProfileTestResultViewController.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/17.
//

import UIKit

class ProfileTestResultViewController : UIViewController {
  
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
    navigationBarView.popNavigationController = {  [self] in
      let profileSettingViewController = ProfileSettingViewController()
      navigationController?.pushViewController(profileSettingViewController, animated: true)
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
    switch indexPath.row{
    case 0:
      guard let cell = profileTestResultCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileTestResultImageCollectionViewCell.className, for: indexPath) as? ProfileTestResultImageCollectionViewCell else {return UICollectionViewCell()}
      return cell
      
    case 1:
      guard let cell = profileTestResultCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileTestResultTextCollectionViewCell.className, for: indexPath) as? ProfileTestResultTextCollectionViewCell else {return UICollectionViewCell()}
      return cell
      
    case 2:
      guard let cell = profileTestResultCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileTestResultRecommendCollectionViewCell.className, for: indexPath) as? ProfileTestResultRecommendCollectionViewCell else {return UICollectionViewCell()}
      return cell
      
    default:
      return UICollectionViewCell()
      
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch indexPath.row{
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
