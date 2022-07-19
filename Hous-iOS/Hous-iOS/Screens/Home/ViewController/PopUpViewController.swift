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
  
  var selectedEventCase: IconImage = .party {
    didSet {
      iconStackView.subviews.forEach {
        guard let iconView = $0 as? EventIconView else { return }
        if selectedEventCase == iconView.eventCase {
          self.setTouchedIcon(iconView)
        }
      }
    }
  }
  
  var participants: [String] = []
  
  private var eventId: String = ""
  
  var isDefaultPopUp: Bool = false
  
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let eventIconSize = CGSize(width: 44, height: 68)
  }
  
  private let maxEventLength = 10
  
  var eventData: EventDTO?
  
  private let partyIconImageView = EventIconView().then {
    $0.eventCase = .party
    $0.tag = 0
    $0.iconImageView.image = R.Image.partyYellowSmall
  }
  
  private let cakeIconImageView = EventIconView().then {
    $0.eventCase = .cake
    $0.tag = 1
    $0.iconImageView.image = R.Image.cakeYellowSmall
  }
  
  private let beerIconImageView = EventIconView().then {
    $0.eventCase = .beer
    $0.tag = 2
    $0.iconImageView.image = R.Image.beerYellowSmall
  }
  
  private let coffeeIconImageView = EventIconView().then {
    $0.eventCase = .coffee
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
  
  private var eventImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
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
  
  private let eventDateView = EventDateView()
  
  private let participantLabel = UILabel().then {
    $0.text = "참여자"
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
  }
  
  private let participantsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    $0.collectionViewLayout = layout
    $0.showsHorizontalScrollIndicator = false
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
    $0.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
  }
  
  private lazy var saveButton = UIButton().then {
    var config = UIButton.Configuration.plain()
    var container = AttributeContainer()
    container.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    
    config.attributedTitle = AttributedString("저장", attributes: container)
    $0.configuration = config
    $0.backgroundColor = .paleGold
    $0.tintColor = .white
    $0.layer.cornerRadius = 10
    $0.addTarget(self, action: #selector(saveEvent), for: .touchUpInside)
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
    setCollectionView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    eventData?.participants.forEach { p in
      if p.isChecked { self.participants.append(p.id) }
    }
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
    popUpView.addSubViews([titleLabel, eventImageView, popUpCloseButton, buttonStackView, textFieldBackgroundView, iconStackView, eventDateView, participantLabel, participantsCollectionView])
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
      make.top.equalTo(participantsCollectionView.snp.bottom).offset(16)
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
    
    eventDateView.snp.makeConstraints { make in
      make.top.equalTo(iconStackView.snp.bottom).offset(16)
      make.leading.trailing.equalTo(popUpView).inset(24)
    }
    
    participantLabel.snp.makeConstraints { make in
      make.top.equalTo(eventDateView.snp.bottom).offset(16)
      make.leading.equalTo(popUpView).offset(24)
    }
    
    participantsCollectionView.snp.makeConstraints { make in
      make.top.equalTo(participantLabel.snp.bottom).offset(8)
      make.leading.trailing.equalTo(popUpView)
    }
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
  
  private func setCollectionView() {
    participantsCollectionView.register(cell: ParticipantsCollectionViewCell.self)

    participantsCollectionView.delegate = self
    participantsCollectionView.dataSource = self
  }
  
  func setPopUpData(_ data: EventDTO) {
    let iconFactory = IconFactory.makeIcon(type: IconImage(rawValue: data.eventIcon.lowercased()) ?? .party)
    
    eventImageView.image = iconFactory.smallIconImage
    eventTextField.text = data.eventName
    
    let date = data.date
    
    eventDateView.setDateLabel(date: date)
  }
  
  func setDefaultPopUpData(_ icon: UIImage) {
    eventImageView.image = icon
  }
}


//MARK: Objective-C methods
extension PopUpViewController {
  @objc private func cancelButtonDidTapped() {
    if isDefaultPopUp {
      self.dismiss(animated: true)
      return
    }
    
    let eventId = eventData?.id ?? ""
    deleteEvent(eventId: eventId)
    self.dismiss(animated: true)
  }
  
  @objc private func dismissPopUp() {
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
        setTouchedIcon(eventIconView)
        selectedEventCase = eventIconView.eventCase
      } else {
        eventIconView.iconImageView.backgroundColor = .offWhite
        eventIconView.iconForegroundImageView.isHidden = true
      }
    }
  }
  
  @objc private func saveEvent() {
    guard let eventName = eventTextField.text else { return }
    let eventIcon = selectedEventCase.rawValue.uppercased()
    var date = eventDateView.eventDate
    let participants = self.participants
    
    if isDefaultPopUp {
      postNewEvent(eventName: eventName, eventIcon: eventIcon, date: date, participants: participants)
    } else {
      let eventId = eventData?.id ?? ""
      date = eventDateView.getCurrentDateText()
      updateEventDetail(eventName: eventName, eventIcon: eventIcon, eventId: eventId, date: date, participants: participants)
    }
    
    self.dismiss(animated: true)
  }
  
  func setTouchedIcon(_ iconView: EventIconView) {
    iconView.iconImageView.backgroundColor = .paleGold
    iconView.iconImageView.alpha = 0.4
    iconView.iconForegroundImageView.isHidden = false
    eventImageView.image = iconView.iconImageView.image
  }
}

//MARK: Delegate & Datasource
extension PopUpViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard let cell = collectionView.cellForItem(at: indexPath) as? ParticipantsCollectionViewCell
    else { return }
    
    cell.participantButton.isSelected.toggle()
    if cell.participantButton.isSelected {
      guard let participantId = eventData?.participants[indexPath.row].id else { return }
      if participants.contains(participantId) { return }
      self.participants.append(participantId)
      
    } else {
      guard let participantId = eventData?.participants[indexPath.row].id else { return }
      if let index = participants.firstIndex(of: participantId) {
        participants.remove(at: index)
      }
    }
    
  }
}

extension PopUpViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return eventData?.participants.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == participantsCollectionView {
      guard let cell = participantsCollectionView.dequeueReusableCell(withReuseIdentifier: ParticipantsCollectionViewCell.className, for: indexPath) as? ParticipantsCollectionViewCell,
            let eventData = eventData
      else { return UICollectionViewCell() }
      
      cell.contentView.isUserInteractionEnabled = true
      
      let isSelected = eventData.participants[indexPath.row].isChecked
      
      if isDefaultPopUp {
        cell.setParticipantData(eventData.participants[indexPath.row], isSelected: nil)
        return cell
      }
      
      cell.setParticipantData(eventData.participants[indexPath.row], isSelected: isSelected)
      return cell
    }

    return UICollectionViewCell()
  }
}

extension PopUpViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    return Size.eventIconSize
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
}

extension PopUpViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    guard let text = eventTextField.text else { return false }
    
    if text.count > maxEventLength && range.length == 0{
      return false
    }
    
    return true
  }
}

extension PopUpViewController {
  func postNewEvent(eventName: String, eventIcon: String, date: String, participants: [String]) {
    HomeMainAPIService.shared.requestPostNewEvent(roomId: APIConstants.roomID, eventName: eventName, eventIcon: eventIcon, date: date, participants: participants) { result in
      
      if let responseResult = NetworkResultFactory.makeResult(resultType: result)
          as? Success<CreateEventDTO> {
        guard let _ = responseResult.response else { return }
        
      } else {
        let responseResult = NetworkResultFactory.makeResult(resultType: result)
        responseResult.resultMethod()
      }
    }
  }
  
  func updateEventDetail(eventName: String, eventIcon: String, eventId: String, date: String, participants: [String]) {
    HomeMainAPIService.shared.requestUpdateEventDetail(roomId: APIConstants.roomID, eventId: eventId, eventName: eventName, eventIcon: eventIcon, participants: participants, date: date) { result in
      
      if let responseResult = NetworkResultFactory.makeResult(resultType: result)
          as? Success<CreateEventDTO> {
        guard let _ = responseResult.response else { return }
        
      } else {
        let responseResult = NetworkResultFactory.makeResult(resultType: result)
        responseResult.resultMethod()
      }
    }
  }
  
  func deleteEvent(eventId: String) {
    HomeMainAPIService.shared.requestDeleteEvent(roomId: APIConstants.roomID, eventId: eventId) { result in
      
      if let responseResult = NetworkResultFactory.makeResult(resultType: result)
          as? Success<String> {
        guard let _ = responseResult.response else { return }
        
      } else {
        let responseResult = NetworkResultFactory.makeResult(resultType: result)
        responseResult.resultMethod()
      }
    }
  }
}
