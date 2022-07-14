//
//  ProfileSettingViewController.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/14.
//


import UIKit
import SwiftUI

class ProfileSettingViewController : UIViewController {
  
  private enum Size{
    static let screenWidth = UIScreen.main.bounds.width
    static let settingCellSize = CGSize(width: Size.screenWidth, height: 62)
  }
  
  private let profileNavigationView = ProfileNavigationView()
  
  private let profileSettingCollectionView: UICollectionView = {
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
    setUp()
    configUI()
    render()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  private func setUp(){
    setDelegate()
    registerCell()
  }
  
  private func configUI(){
    profileSettingCollectionView.backgroundColor = .white
  }
  
  private func render(){
    view.addSubViews([profileNavigationView, profileSettingCollectionView])

    profileNavigationView.snp.makeConstraints { make in
      make.height.equalTo(60)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
    }

    profileSettingCollectionView.snp.makeConstraints{ make in
      make.top.equalTo(profileNavigationView.snp.bottom)
      make.bottom.equalToSuperview()
      make.trailing.leading.equalToSuperview()
    }
  }
  
  private func setDelegate(){
    self.profileSettingCollectionView.delegate = self
    self.profileSettingCollectionView.dataSource = self
  }
  
  private func registerCell(){
    profileSettingCollectionView.register(cell: ProfileSettingCollectionViewCell.self)
  }
}

extension ProfileSettingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = profileSettingCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileSettingCollectionViewCell.className, for: indexPath) as? ProfileSettingCollectionViewCell else {return UICollectionViewCell()}
    
    if indexPath.row == 0 {
      cell.setButton(isNotiButton: true)
    }
    else {
      cell.setButton(isNotiButton: false)
    }
    
    let cellLabels = ["알림", "시스템 설정", "피드백 보내기"]
    cell.setLabel(cellLabels[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return Size.settingCellSize
  }
}
