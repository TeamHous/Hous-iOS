//
//  TodayTodoCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit

protocol TodayTodoCollectionViewCellDelegate: AnyObject {
  func leftAssigneeViewTouched()
  // func cellTouched()
}

class TodayTodoCollectionViewCell: UICollectionViewCell {

  weak var delegate: TodayTodoCollectionViewCellDelegate?

  enum Size {
    static let leftRoundViewSize: CGFloat = 40
  }
  
  private var labelStackView = UIStackView().then {
    $0.alignment = .fill
    $0.distribution = .fillProportionally
    $0.axis = .vertical
    $0.spacing = 8
  }
  var todoTitleLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 16)
    $0.text = "화장실 청소"
  }
  var managerLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 13)
    $0.textColor = R.Color.lightPeriwinkle
    $0.text = "담당자 선택하기"
  }

  lazy var addAssignView = TodayTodoAddAssingnView()
  lazy var manyAssignedView = TodayTodoManyAssignedView()
  lazy var oneAssignedView = TodayTodoOneAssignedView()
  var leftAssigneeView = UIView()

  var doneCheckBoxImageView = UIImageView().then {
    $0.image = R.Image.rulesChecked
  }
  var notiDotView = UIView().then {
    $0.backgroundColor = R.Color.softBlue
    $0.makeRounded(cornerRadius: 4)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    configUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func render() {
    
    self.addSubViews([labelStackView, leftAssigneeView, doneCheckBoxImageView, notiDotView])
    labelStackView.addArrangedSubview(todoTitleLabel)
    labelStackView.addArrangedSubview(managerLabel)
    
    labelStackView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(20)
      make.leading.equalTo(leftAssigneeView.snp.trailing).offset(20)
      make.trailing.greaterThanOrEqualTo(doneCheckBoxImageView.snp.leading).inset(20)
    }
    
    leftAssigneeView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(20)
      make.size.equalTo(40)
      make.centerY.equalTo(labelStackView.snp.centerY)
    }
    doneCheckBoxImageView.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(20)
      make.size.equalTo(24)
      make.centerY.equalTo(labelStackView.snp.centerY)
    }

    notiDotView.snp.makeConstraints { make in
      make.top.trailing.equalToSuperview().inset(12)
      make.size.equalTo(8)
    }
  }
  
  private func configUI() {
    self.layer.cornerRadius = 15
    self.backgroundColor = R.Color.paleGrey
  }
}

extension TodayTodoCollectionViewCell {

    func setLeftRoundView(type: TodayTodoType) {
      switch type {
      case .notAssigned:
        leftAssigneeView.addSubview(addAssignView)
        addAssignView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
      case .manyAssinged:
        leftAssigneeView.addSubview(manyAssignedView)
        manyAssignedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
      case .oneAssinged:
        leftAssigneeView.addSubview(oneAssignedView)
        oneAssignedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
      }
    }
}

extension TodayTodoCollectionViewCell {

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesBegan(touches, with: event)

    guard let touch = touches.reversed().first else { return }
    if touch.view == self.addAssignView ||
        touch.view == self.manyAssignedView ||
        touch.view == self.oneAssignedView {
      delegate?.leftAssigneeViewTouched()
    } else {
      // 나머지 부분 터치 시 기능 구현 예정
    }
  }
}
