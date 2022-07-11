//
//  PopUpViewController.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

class PopUpViewController: UIViewController {
  
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let eventIconSize = CGSize(width: 44, height: 44)
  }
  
  private let maxEventLength = 10
  
  private let partyIconImageView = EventIconView().then {
    $0.tag = 0
    $0.iconImageView.image = R.Image.partyYellowSmall
  }
  
  private let cakeIconImageView = EventIconView().then {
    $0.tag = 1
    $0.iconImageView.image = R.Image.cakeYellowSmall
  }
  
  private let beerIconImageView = EventIconView().then {
    $0.tag = 2
    $0.iconImageView.image = R.Image.beerYellowSmall
  }
  
  private let coffeeIconImageView = EventIconView().then {
    $0.tag = 3
    $0.iconImageView.image = R.Image.coffeeYellowSmall
  }
  
  private lazy var iconStackView = UIStackView(arrangedSubviews: [partyIconImageView, cakeIconImageView, beerIconImageView, coffeeIconImageView]).then {
    $0.axis = .horizontal
    $0.spacing = 16
    $0.distribution = .fillEqually
  }
  
  private lazy var blurView = UIVisualEffectView().then {
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    $0.effect = blurEffect
    $0.frame = view.bounds
    $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
  
  private let popUpView = UIView().then {
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 20
  }
  
  private let titleLabel = UILabel().then {
    $0.text = "이벤트"
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 20)
    $0.tintColor = .housBlack
  }
  
  private let eventImageView = UIImageView().then {
    $0.backgroundColor = R.Color.offWhite
    $0.image = R.Image.partyYellow
    $0.clipsToBounds = true
  }
  
  private let textFieldBackgroundView = UIView().then {
    $0.backgroundColor = .offWhite
    $0.layer.cornerRadius = 10
  }
  
  private let eventTextField = UITextField().then {
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 14)
    $0.adjustsFontSizeToFitWidth = true
  }
  
  private let participantsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    $0.collectionViewLayout = layout
    $0.showsHorizontalScrollIndicator = false
  }
  
  private lazy var datePicker = UIDatePicker().then {
    $0.preferredDatePickerStyle = .wheels
    $0.datePickerMode = .date
    $0.locale = Locale(identifier: "ko-KR")
    $0.timeZone = .autoupdatingCurrent
    $0.addTarget(self, action: #selector(handleDatePickerData), for: .valueChanged)
  }
  
  private lazy var cancelButton = UIButton().then {
    var config = UIButton.Configuration.plain()
    var container = AttributeContainer()
    container.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    
    config.attributedTitle = AttributedString("삭제", attributes: container)
    config.baseForegroundColor = R.Color.salmon
    config.baseBackgroundColor = .white
    
    $0.configuration = config
    $0.layer.borderColor = R.Color.salmon.cgColor
    $0.layer.borderWidth = 1
    $0.layer.cornerRadius = 10
    $0.addTarget(self, action: #selector(cancelButtonDidTapped), for: .touchUpInside)
  }
  
  private lazy var popUpCloseButton = UIButton().then {
    $0.setImage(R.Image.popupCloseHome, for: .normal)
    $0.addTarget(self, action: #selector(cancelButtonDidTapped), for: .touchUpInside)
  }
  
  private let saveButton = UIButton().then {
    var config = UIButton.Configuration.plain()
    var container = AttributeContainer()
    container.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    
    config.attributedTitle = AttributedString("저장", attributes: container)
    $0.configuration = config
    $0.backgroundColor = .paleGold
    $0.tintColor = .white
    $0.layer.cornerRadius = 10
  }
  
  private lazy var buttonStackView = UIStackView(arrangedSubviews: [cancelButton, saveButton]).then {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.spacing = 15
  }
  
  //MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    setTextField()
    setTapGesture()
//    setCollectionView()
  }
  
  override func viewDidLayoutSubviews() {
    configUI()
  }
  
  //MARK: Custom Methods
  private func configUI() {
    eventImageView.layer.cornerRadius = eventImageView.frame.width / 2
  }
  
  private func render() {
    self.view.addSubview(blurView)
    self.view.addSubview(popUpView)
    popUpView.addSubViews([titleLabel, eventImageView, popUpCloseButton, buttonStackView, textFieldBackgroundView, iconStackView])
    textFieldBackgroundView.addSubview(eventTextField)
    
    popUpView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.equalTo(UIScreen.main.bounds.width * (272/375))
      make.height.equalTo(UIScreen.main.bounds.height * (439/812))
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(36)
      make.leading.equalToSuperview().offset(24)
    }
    
    popUpCloseButton.snp.makeConstraints { make in
      make.top.equalTo(popUpView).offset(20)
      make.trailing.equalTo(popUpView).inset(20)
    }
    
    eventImageView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(10)
      make.leading.equalToSuperview().offset(20)
      make.width.height.equalTo(60)
    }
    
    buttonStackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(24)
      make.bottom.equalToSuperview().inset(20)
    }
    
    textFieldBackgroundView.snp.makeConstraints { make in
      make.centerY.equalTo(eventImageView)
      make.leading.equalTo(eventImageView.snp.trailing).offset(25)
      make.trailing.equalTo(popUpView).inset(24)
      make.height.equalTo(37)
    }
    
    eventTextField.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(10)
    }
    
    iconStackView.snp.makeConstraints { make in
      make.top.equalTo(eventImageView.snp.bottom).offset(16)
      make.leading.trailing.equalTo(popUpView).inset(24)
      make.height.equalTo(44)
    }
    
//    participantsCollectionView.snp.makeConstraints { make in
//      make.top.equalTo(eventImageView.snp.bottom).offset(16)
//      make.leading.trailing.equalTo(popUpView)
//      make.height.equalTo(50)
//    }
    
//    datePicker.snp.makeConstraints { make in
//      make.top.equalTo(participantsCollectionView.snp.bottom).offset(16)
//      make.leading.trailing.equalTo(popUpView).inset(24)
//    }
  }
  
  private func setTextField() {
    eventTextField.delegate = self
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(textDidChange),
      name: UITextField.textDidChangeNotification,
      object: eventTextField
    )
  }
  
  private func setTapGesture() {
    
    iconStackView.subviews.forEach {
      let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))

      $0.addGestureRecognizer(tapGestureRecognizer)
    }
  }
  
//  private func setCollectionView() {
//    participantsCollectionView.register(cell: ParticipantsCollectionViewCell.self)
//
//    participantsCollectionView.delegate = self
//    participantsCollectionView.dataSource = self
//  }
}


//MARK: Objective-C methods
extension PopUpViewController {
  @objc private func cancelButtonDidTapped() {
    self.dismiss(animated: true)
  }
  
  @objc private func textDidChange(_ notification: Notification) {
    if let eventTextField = notification.object as? UITextField {
      guard let text = eventTextField.text else { return }
      
      if text.count >= maxEventLength {
        let index = text.index(text.startIndex, offsetBy: maxEventLength)
        let newString = text[text.startIndex..<index]
        eventTextField.text = String(newString)
      }
    }
  }
  
  @objc private func didTapView(_ sender: UIGestureRecognizer) {
    guard let view = sender.view as? EventIconView else { return }
    
    iconStackView.subviews.forEach {
      guard let eventIconView = $0 as? EventIconView else { return }
      
      if eventIconView == view.viewWithTag(view.tag) {
        eventIconView.iconImageView.backgroundColor = .paleGold
        eventIconView.iconImageView.alpha = 0.4
        eventIconView.iconForegroundImageView.isHidden = false
      } else {
        eventIconView.iconImageView.backgroundColor = .offWhite
        eventIconView.iconForegroundImageView.isHidden = true
      }
    }
  }
  
  @objc private func handleDatePickerData() {
    let dateformatter = DateFormatter()
    dateformatter.dateStyle = .long
    dateformatter.timeStyle = .none
    let date = dateformatter.string(from: datePicker.date)
    let year = date[date.startIndex..<date.index(date.startIndex, offsetBy: 4)]
    let month = date[date.index(date.startIndex, offsetBy: 6) ..< date.index(date.startIndex, offsetBy: 7)]
    let day = date[date.index(date.endIndex, offsetBy: -3) ..< date.index(before: date.endIndex)]
    print(year)
    print(month)
    print(day)
  }
}

//MARK: Delegate & Datasource
//extension PopUpViewController: UICollectionViewDelegate {
//
//}

//extension PopUpViewController: UICollectionViewDataSource {
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return 4
//  }
//
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    if collectionView == participantsCollectionView {
//      guard let cell = participantsCollectionView.dequeueReusableCell(withReuseIdentifier: ParticipantsCollectionViewCell.className, for: indexPath) as? ParticipantsCollectionViewCell else { return UICollectionViewCell() }
//      cell.setIconData(iconImageList[indexPath.row])
//
//      return cell
//    }
//
//    return UICollectionViewCell()
//  }
//}

//extension PopUpViewController: UICollectionViewDelegateFlowLayout {
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    return Size.eventIconSize
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//    return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//    return 18
//  }
  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//    return 18
//  }
//}

extension PopUpViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    guard let text = eventTextField.text else { return false }
    
    if text.count > maxEventLength && range.length == 0{
      return false
    }
    
    return true
  }
}
