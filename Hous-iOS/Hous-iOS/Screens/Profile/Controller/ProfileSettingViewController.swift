//
//  ProfileSettingViewController.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/14.
//


import UIKit

class ProfileSettingViewController : UIViewController {
  
  let cellLabels = ["알림", "시스템 설정", "피드백 보내기"]
  
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let settingCellSize = CGSize(width: Size.screenWidth, height: 62)
  }
  
  private let profileSettingNavigationBarView = ProfileSettingNavigationBarView()
  
  private let profileSettingCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  
  private let checkOutButton = UIButton().then {
    $0.backgroundColor = .white
    $0.setTitle("퇴사하기", for: .normal)
    $0.setTitleColor(.salmon, for: .normal)
    $0.layer.cornerRadius = 10
    $0.layer.borderColor = UIColor.salmon.cgColor
    $0.layer.borderWidth = 1.5
    $0.layer.masksToBounds = true
    $0.titleLabel?.font = .font(.spoqaHanSansNeoMedium, ofSize: 18)
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
      tvc.housTabbar.isHidden = true
    }
  }

  private func setup() {
    setDelegate()
    registerCell()
    profileSettingNavigationBarView.popNavigationController = { [self] in
      navigationController?.popViewController(animated: true)
    }
  }
  
  private func configUI() {
    profileSettingCollectionView.backgroundColor = .white
    view.backgroundColor = .white
  }
  
  private func render() {
    view.addSubViews([profileSettingNavigationBarView, profileSettingCollectionView, checkOutButton])

    profileSettingNavigationBarView.snp.makeConstraints { make in
      make.height.equalTo(60)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
    }

    profileSettingCollectionView.snp.makeConstraints{ make in
      make.top.equalTo(profileSettingNavigationBarView.snp.bottom)
      make.bottom.equalToSuperview()
      make.trailing.leading.equalToSuperview()
    }
    
    checkOutButton.snp.makeConstraints {make in
      make.leading.trailing.equalToSuperview().inset(24)
      make.bottom.equalToSuperview().inset(40)
      make.height.equalTo(54)
    }
  }
  
  private func setDelegate() {
    self.profileSettingCollectionView.delegate = self
    self.profileSettingCollectionView.dataSource = self
  }
  
  private func registerCell() {
    profileSettingCollectionView.register(cell: ProfileSettingCollectionViewCell.self)
  }
}

extension ProfileSettingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = profileSettingCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileSettingCollectionViewCell.className, for: indexPath) as? ProfileSettingCollectionViewCell else {return UICollectionViewCell()}
    
    indexPath.row == 0 ? cell.setButton(isNotiButton: true) : cell.setButton(isNotiButton: false)

    cell.setLabel(cellLabels[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return Size.settingCellSize
  }
}
