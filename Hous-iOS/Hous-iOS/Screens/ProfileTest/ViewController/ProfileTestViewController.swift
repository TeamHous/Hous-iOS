//
//  ProfileTestViewController.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/14.
//

import UIKit

class ProfileTestViewController: UIViewController {
  
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
  }
  
  private let backwardButton = UIButton().then {
    $0.setImage(R.Image.testBackwardButton, for: .normal)
  }
  
  private let testCountLabel = UILabel().then {
    $0.font = .font(.montserratBold, ofSize: 16)
    $0.textColor = R.Color.brownGreyTwo
  }
  
  private let forwardButton = UIButton().then {
    $0.setImage(R.Image.testForwardButton, for: .normal)
  }
  
  private lazy var testNavigationStackView = UIStackView(arrangedSubviews: [backwardButton, testCountLabel, forwardButton]).then {
    $0.axis = .horizontal
    $0.spacing = 30
  }
  
  private lazy var quitButton = UIButton().then {
    var container = AttributeContainer()
    container.font = .font(.spoqaHanSansNeoMedium, ofSize: 14)
    
    var config = UIButton.Configuration.plain()
    config.baseForegroundColor = R.Color.salmon
    config.attributedTitle = AttributedString("그만두기", attributes: container)
    
    $0.configuration = config
    $0.addTarget(self, action: #selector(showQuitTestPopUp), for: .touchUpInside)
  }
  
  private let testCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
    var layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    $0.isPagingEnabled = true
    $0.isScrollEnabled = false
    $0.collectionViewLayout = layout
    $0.showsHorizontalScrollIndicator = false
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    setTestCollectionView()
  }
  
  
  private func render() {
    self.view.addSubViews([testNavigationStackView, quitButton, testCollectionView])
    
    testNavigationStackView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      make.centerX.equalToSuperview()
    }
    
    quitButton.snp.makeConstraints { make in
      make.centerY.equalTo(testNavigationStackView)
      make.trailing.equalToSuperview().inset(24)
    }
    
    testCollectionView.snp.makeConstraints { make in
      make.top.equalTo(testNavigationStackView.snp.bottom).offset(30)
      make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func setTestCollectionView() {
    testCollectionView.register(cell: TestCollectionViewCell.self)
    testCollectionView.delegate = self
    testCollectionView.dataSource = self
  }
}

extension ProfileTestViewController: UICollectionViewDelegate {

}

extension ProfileTestViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return ProfileTestDataModel.sampleData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = testCollectionView.dequeueReusableCell(withReuseIdentifier: TestCollectionViewCell.className, for: indexPath) as? TestCollectionViewCell else { return UICollectionViewCell() }
    
    cell.buttonAction = {
      if indexPath.row + 1 == ProfileTestDataModel.sampleData.count {
        return
      }
      
      collectionView.scrollToItem(at: IndexPath(row: indexPath.row + 1, section: 0), at: .right, animated: true)
    }
    
    testCountLabel.text = "\(indexPath.row + 1) / \(ProfileTestDataModel.sampleData.count)"
    
    cell.setTestData(ProfileTestDataModel.sampleData[indexPath.row])
    return cell
  }
}

extension ProfileTestViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: Size.screenWidth, height: testCollectionView.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

//MARK: Objective-C methods

extension ProfileTestViewController {
  @objc private func showQuitTestPopUp() {
    let popUp = QuitTestPopViewController()
    popUp.modalTransitionStyle = .crossDissolve
    popUp.modalPresentationStyle = .overFullScreen
    
    present(popUp, animated: true)
  }
}
