//
//  ProfileViewController.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/07.
//

import UIKit
import SwiftUI

class ProfileViewController : UIViewController {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let infoCellSize = CGSize(width: Size.screenWidth, height: 114)
    static let graphCellSize = CGSize(width: Size.screenWidth, height: 354)
    static let badgeCellSize = CGSize(width: Size.screenWidth, height: 222)
    static let graphEmptyCellSize = CGSize(width: Size.screenWidth, height: 180)
  }
  
  private let navigationBarView = NavigationBarView(tabType: .profile)
  
  private var isProfileEmpty = true
  
  private let profileMainCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
    configUI()
    render()
  }
  
  private func setUp(){
    setDelegate()
    registerCell()
  }

  private func setDelegate(){

    self.profileMainCollectionView.delegate = self
    self.profileMainCollectionView.dataSource = self
  }

  private func registerCell(){
    profileMainCollectionView.register(cell: ProfileInfoCollectionViewCell.self)
    profileMainCollectionView.register(cell: ProfileGraphCollectionViewCell.self)
    profileMainCollectionView.register(cell: ProfileBadgeCollectionViewCell.self)
    profileMainCollectionView.register(cell: ProfileGraphEmptyCollectionViewCell.self)
  }
  
  private func configUI() {
    profileMainCollectionView.backgroundColor = .white
  }
  
  private func render() {
    view.addSubViews([navigationBarView, profileMainCollectionView])
    
    profileMainCollectionView.snp.makeConstraints{ make in
      let width = UIScreen.main.bounds.width
      make.top.equalTo(view.safeAreaLayoutGuide).offset(width * (60/375))
      make.bottom.equalToSuperview().offset(-76)
      make.trailing.equalToSuperview()
      make.leading.equalToSuperview()
    }
    navigationBarView.snp.makeConstraints { make in
      let width = UIScreen.main.bounds.width
      make.width.equalTo(width)
      make.height.equalTo(width * (50 / 375))
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.trailing.equalToSuperview()

    }
  }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.row {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let width = UIScreen.main.bounds.width
      switch indexPath.row {
      case 0:

        return CGSize(width: width, height: 114)
      case 1:
        if isProfileEmpty{
          return CGSize(width: width, height: 180)
        }
        return CGSize(width: width, height: 354)
      case 2:
        return CGSize(width: width, height: 222)
      default:
        return CGSize(width: 0, height: 0)
      }
    }
  }
}
