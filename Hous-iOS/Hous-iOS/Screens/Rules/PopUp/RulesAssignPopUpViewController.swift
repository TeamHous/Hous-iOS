//
//  TodayTodoAssignPopUpViewController.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/14.
//

import UIKit
import SnapKit
import Then

class TodayTodoAssignPopUpViewController: UIViewController {

  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let assigneeSize = CGSize(width: 56, height: 82)
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
    $0.text = "임시 담당자 설정"
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 20)
    $0.tintColor = .housBlack
  }

  private lazy var popUpCloseButton = UIButton().then {
    $0.setImage(R.Image.popupCloseHome, for: .normal)
    $0.addTarget(self, action: #selector(cancelButtonDidTapped), for: .touchUpInside)
  }

  private let assigneeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    $0.collectionViewLayout = layout
    $0.showsHorizontalScrollIndicator = false
  }

  private let saveButton = FilledCustomButton().then {
    $0.configUI(font: .font(.spoqaHanSansNeoMedium, ofSize: 16),
                text: "저장", color: .softBlue, corner: 10)
  }

  //MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    setCollectionView()
  }

  private func render() {

    self.view.addSubView(blurView)
    self.view.addSubview(popUpView)
    popUpView.addSubViews([titleLabel, popUpCloseButton, assigneeCollectionView, saveButton])

    popUpView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.equalTo(UIScreen.main.bounds.width * (272/375))
      make.height.equalTo(popUpView.snp.width).multipliedBy(0.9)
    }

    titleLabel.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(24)
    }

    popUpCloseButton.snp.makeConstraints { make in
      make.centerY.equalTo(titleLabel.snp.centerY)
      make.trailing.equalTo(popUpView).inset(24)
      make.size.equalTo(24)
    }

    assigneeCollectionView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(20)
      make.leading.trailing.equalToSuperview()
    } // 얘 height 지정 안되어 있음 !

    saveButton.snp.makeConstraints { make in
      make.top.equalTo(assigneeCollectionView.snp.bottom).offset(24)
      make.leading.trailing.bottom.equalToSuperview().inset(24)
      make.height.equalTo(40)
    }
  }

  private func setCollectionView() {
    assigneeCollectionView.register(cell: ParticipantsCollectionViewCell.self)
    assigneeCollectionView.delegate = self
    assigneeCollectionView.dataSource = self
  }
}

//MARK: Objective-C methods
extension TodayTodoAssignPopUpViewController {
  @objc private func cancelButtonDidTapped() {
    self.dismiss(animated: true)
  }
}

//MARK: Delegate & Datasource
extension TodayTodoAssignPopUpViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? ParticipantsCollectionViewCell else { return }

    cell.participantButton.isSelected.toggle()
  }
}

extension TodayTodoAssignPopUpViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return ParticipantsDataModel.sampleData.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == assigneeCollectionView {
      guard let cell = assigneeCollectionView.dequeueReusableCell(withReuseIdentifier: ParticipantsCollectionViewCell.className, for: indexPath) as? ParticipantsCollectionViewCell else { return UICollectionViewCell() }

      cell.contentView.isUserInteractionEnabled = true
      cell.setParticipantData(HomeDTO.sampleData.homieProfileList[indexPath.row], isSelected: nil)

      return cell
    }

    return UICollectionViewCell()
  }
}

extension TodayTodoAssignPopUpViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    return Size.assigneeSize
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
}
