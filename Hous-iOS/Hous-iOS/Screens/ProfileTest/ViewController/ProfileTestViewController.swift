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
  
  private enum TestState {
    case none
    case option1
    case option2
    case option3
  }
  
  var testCellData: [TestCellItem]
  
  var isMovedBackward: Bool = false
  
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
  
  var isAnimationing: Bool = false
  
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
    configUI()
  }
  
  private func configUI() {
    testCountLabel.text = "1 / \(testCellData.count)"
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
  
  private func setBackforwardButton(index: Int) {
    // 첫번째
    if index == 1 {
      
      self.backwardButton.alpha = 0
      self.backwardButton.isEnabled = false
      
      self.forwardButton.alpha = 0
      self.forwardButton.isEnabled = false
      
    } else if index == testCellData.count {
      // 마지막
      self.forwardButton.alpha = 0
      self.forwardButton.isEnabled = false
      
    } else {
      // 기본 상태
      
      if isMovedBackward {
        // <   >
        self.backwardButton.alpha = 1
        self.forwardButton.alpha = 1
        
        self.backwardButton.isEnabled = true
        self.forwardButton.isEnabled = true
        return
      }
      
      self.backwardButton.alpha = 1
      self.backwardButton.isEnabled = true
      
      self.forwardButton.alpha = 0
      self.forwardButton.isEnabled = false
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
    
    cell.delegate = self
    self.indexPathRow = indexPath.row
    
    cell.setTestData(testCellData[indexPath.row])
    setBackforwardButton(index: indexPath.row + 1)
    
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
    guard isAnimationing == false else {
      isAnimationing = true
      backwardButton.isEnabled = false
      return
    }
    
    let contentSize = testCollectionView.contentSize.width
    let offsetX = testCollectionView.contentOffset.x
    
    let t = (offsetX / contentSize) * CGFloat(testCellData.count)
    let toOffset = ceil(t)
    
    if Int(toOffset) <= 0 {
      return
    }
    
    isMovedBackward = true
    
    isAnimationing = true
    
    testCollectionView.scrollToItem(at: IndexPath(row: Int(toOffset) - 1, section: 0), at: .left, animated: true)
    
    setBackforwardButton(index: Int(toOffset))
    
    testCountLabel.text = "\(testCellData[Int(toOffset) - 1].testIdx) / \(testCellData.count)"
    
    backwardButton.isEnabled = true
    
    isAnimationing = false
    
    backwardButton.isEnabled = true
  }
  
  @objc private func scrollForward() {
    guard isAnimationing == false else {
      isAnimationing = true
      forwardButton.isEnabled = false
      return
    }
    
    let contentSize = testCollectionView.contentSize.width
    let offsetX = testCollectionView.contentOffset.x
    
    let te = (offsetX / contentSize) * CGFloat(testCellData.count)
    let toOffset = ceil(te)
    
    if Int(toOffset) + 1 == testCellData.count {
      return
    }
    
    isAnimationing = true
    
    testCollectionView.scrollToItem(at: IndexPath(row: Int(toOffset) + 1, section: 0), at: .right, animated: true)
    
    testCountLabel.text = "\(testCellData[Int(toOffset) + 1].testIdx) / \(testCellData.count)"
    
    forwardButton.isEnabled = true
    
    isAnimationing = false
    
    forwardButton.isEnabled = true
  }
}

extension ProfileTestViewController: TestCollectionViewCellDelegate {
  
  func optionButtonDidTapped(_ sender: UIButton, _ tag: Int ) {
    
    guard let index = indexPathRow else { return }
    
    if index + 1 == self.testCellData.count {
      
      // deselect all buttons
      testCellData[index].testAnswers.forEach {
        $0.deselectIsSelected()
      }
      
      // select button -> true
      self.testCellData[index].testAnswers[tag].isSelected = true
      return
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
      
      testCollectionView.scrollToItem(at: IndexPath(row: index + 1, section: 0), at: .right, animated: true)
      
      testCountLabel.text = "\(testCellData[index + 1].testIdx) / \(testCellData.count)"
//      testCountLabel.text = "\(index + 2) / \(testCellData.count)"
      
      // deselect all buttons
      testCellData[index].testAnswers.forEach {
        $0.deselectIsSelected()
      }
      
      // select button -> true
      testCellData[index].testAnswers[tag].isSelected = true
      
      
      setBackforwardButton(index: testCellData[index + 1].testIdx)
      self.indexPathRow = index + 1
    }
  }
}


struct TestCellItem {
  let testTitle: String
  let testIdx: Int
  let testImg: String
  var testAnswers: [ButtonState]
  
  init(dto: TestInfoList) {
    self.testTitle = dto.testTitle
    self.testIdx = dto.testIdx
    self.testImg = dto.testImg
    
    var t: [ButtonState] = []
    for answer in dto.testAnswers {
      let button = ButtonState(optionText: answer, isSelected: false)
      t.append(button)
    }
    self.testAnswers = t
  }
}


class ButtonState {
  var optionText: String
  var isSelected: Bool
  
  init(optionText: String, isSelected: Bool) {
    self.optionText = optionText
    self.isSelected = isSelected
  }
  
  func deselectIsSelected() {
    isSelected = false
  }
}
