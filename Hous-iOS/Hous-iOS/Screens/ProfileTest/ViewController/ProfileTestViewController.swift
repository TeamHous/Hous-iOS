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
  
  var testCellData: [TestCellItem]
  
  private var indexPathRow: Int?
  
  private lazy var backwardButton = UIButton().then {
    $0.setImage(R.Image.testBackwardButton, for: .normal)
    $0.addTarget(self, action: #selector(scrollBackward), for: .touchUpInside)
  }
  
  private let testCountLabel = UILabel().then {
    $0.font = .font(.montserratBold, ofSize: 16)
    $0.textColor = R.Color.brownGreyTwo
  }
  
  private lazy var forwardButton = UIButton().then {
    $0.setImage(R.Image.testForwardButton, for: .normal)
    $0.addTarget(self, action: #selector(scrollForward), for: .touchUpInside)
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
  
  init(testCellItem: [TestCellItem]) {
    self.testCellData = testCellItem
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
  
  private func setBackforwardButton() {
    guard let index = indexPathRow else { return }
    if index == 0 {
      self.backwardButton.alpha = 0
      self.backwardButton.isEnabled = false
      
    } else if index + 1 == testCellData.count {
      self.forwardButton.alpha = 0
      self.forwardButton.isEnabled = false
      
    } else {
      self.backwardButton.alpha = 1
      self.backwardButton.isEnabled = true
      
      self.forwardButton.alpha = 1
      self.forwardButton.isEnabled = true
    }
  }
}

extension ProfileTestViewController: UICollectionViewDelegate {

}

extension ProfileTestViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return testCellData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = testCollectionView.dequeueReusableCell(withReuseIdentifier: TestCollectionViewCell.className, for: indexPath) as? TestCollectionViewCell
    else { return UICollectionViewCell() }
    
    self.indexPathRow = indexPath.row
    
    cell.buttonAction = { (sender, string) in
      if indexPath.row + 1 == self.testCellData.count {
        
        let testAnswers = self.testCellData[indexPath.row].testAnswers.keys
        testAnswers.forEach {
          self.testCellData[indexPath.row].testAnswers[$0] = false
        }
        self.testCellData[indexPath.row].testAnswers[string] = sender.isSelected
        return
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
        
        collectionView.scrollToItem(at: IndexPath(row: indexPath.row + 1, section: 0), at: .right, animated: true)
        
        let testAnswers = testCellData[indexPath.row].testAnswers.keys
        testAnswers.forEach {
          testCellData[indexPath.row].testAnswers[$0] = false
        }
        testCellData[indexPath.row].testAnswers[string] = sender.isSelected
      }
    }
    
    setBackforwardButton()
    
    testCountLabel.text = "\(testCellData[indexPath.row].testIdx) / \(testCellData.count)"
    
    cell.setTestData(testCellData[indexPath.row])
    
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
  
  @objc private func scrollBackward() {
    guard var index = indexPathRow else { return }
    print("뒤로가기 눌렀을 때 \(index - 1)")
    if index <= 0 { return }
    
    testCollectionView.scrollToItem(at: IndexPath(row: index - 1, section: 0), at: .left, animated: true)
    
    index -= 1
    indexPathRow = index
    
    setBackforwardButton()
    testCountLabel.text = "\((index + 1).description) / \(testCellData.count)"
  }
  
  @objc private func scrollForward() {
    guard var index = indexPathRow else { return }
    print("앞으로가기 눌렀을 때 \(index + 1)")
    if index + 1 == testCellData.count { return }
    
    testCollectionView.scrollToItem(at: IndexPath(row: index + 1, section: 0), at: .right, animated: true)
    
    index += 1
    indexPathRow = index
    
    setBackforwardButton()
    testCountLabel.text = "\((index + 1).description) / \(testCellData.count)"
  }
}

struct TestCellItem {
  
  let testTitle: String
  let testIdx: Int
  let testImg: String
  var testAnswers: [String: Bool]
  
  init(dto: TestInfoList) {
    self.testTitle = dto.testTitle
    self.testIdx = dto.testIdx
    self.testImg = dto.testImg
    
    var t: [String: Bool] = [:]
    dto.testAnswers.forEach { answer in
      t[answer] = false
    }
    self.testAnswers = t
  }
}
