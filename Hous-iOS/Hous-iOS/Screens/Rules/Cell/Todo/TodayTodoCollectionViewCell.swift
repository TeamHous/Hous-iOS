//
//  TodayTodoCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit

protocol TodayTodoCollectionViewCellDelegate: AnyObject {
  func leftAssigneeViewTouched(ruleId: String)
}

class TodayTodoCollectionViewCell: UICollectionViewCell {

  weak var delegate: TodayTodoCollectionViewCellDelegate?
  var ruleId = "" //이거맞냐

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
    $0.font = .font(.montserratMedium, ofSize: 16)
    $0.text = "화장실 청소"
  }
  var assigneesLabel = UILabel().then {
    $0.font = .font(.montserratMedium, ofSize: 13)
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
  var tmpAssigneeDotView = UIView().then {
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

  override func prepareForReuse() {
    leftAssigneeView.subviews.forEach { $0.removeFromSuperview() }
  }
  
  private func render() {
    
    self.addSubViews([labelStackView, leftAssigneeView, doneCheckBoxImageView, tmpAssigneeDotView])
    labelStackView.addArrangedSubview(todoTitleLabel)
    labelStackView.addArrangedSubview(assigneesLabel)
    
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

    tmpAssigneeDotView.snp.makeConstraints { make in
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

  func setTodayTodoCell(_ item: TodayTodoRulesDTO) {

    self.ruleId = item.id

    self.todoTitleLabel.text = item.ruleName
    self.doneCheckBoxImageView.isHidden = !item.isAllChecked
    self.tmpAssigneeDotView.isHidden = !item.isTmpMember
    self.assigneesLabel.textColor = R.Color.softBlue

    // 0명일 때, 1명일 때, 2명 이상일 때
    let assigneeCount = item.todayMembersWithTypeColor.count
    var leftView = UIView()

    if assigneeCount == 0 {
      leftView = addAssignView
      self.assigneesLabel.text = "담당자 선택하기"
      self.assigneesLabel.textColor = R.Color.lightPeriwinkle

    } else if assigneeCount == 1 {
      leftView = oneAssignedView
      guard let oneAssignee = item.todayMembersWithTypeColor.first,
            let assigneeColor = AssigneeColor(rawValue: oneAssignee.typeColor.lowercased()) else { return }

      let assigneeImage = AssigneeFactory.makeAssignee(type: assigneeColor)
      self.oneAssignedView.assigneeImageView.image = assigneeImage.faceImage
      self.assigneesLabel.text = oneAssignee.userName

    } else {
      leftView = manyAssignedView
      let assignees = item.todayMembersWithTypeColor
      var assigneesColor: [String] = []
      var assigneesLabelText: [String] = []
      assignees.forEach {
        assigneesLabelText.append($0.userName)
        assigneesColor.append($0.typeColor)
      }
      self.manyAssignedView.setCircle(count: assigneeCount, colors: assigneesColor)

      let assigneesCount = assigneesLabelText.count
      if (assigneesLabelText.count > 2) {
        assigneesLabelText = Array(assigneesLabelText.prefix(2))
        print("잘들어요냐고")
        self.assigneesLabel.text = "\(assigneesLabelText.joined(separator: ", ")) 외 \(assigneesCount - 2)명"
      } else {
        self.assigneesLabel.text = assigneesLabelText.joined(separator: ", ")
      }
    }

    leftAssigneeView.addSubview(leftView)
    leftView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

extension TodayTodoCollectionViewCell {

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)

    guard let touch = touches.reversed().first else { return }
    let manyAssignedView = [self.manyAssignedView.topLeftView,
                            self.manyAssignedView.topRightView,
                            self.manyAssignedView.bottomLeftView,
                            self.manyAssignedView.bottomRightView]
    var manyAssignedViewSubviewsTouched = false
    manyAssignedView.forEach {
      if touch.view == $0 {
        manyAssignedViewSubviewsTouched = true
        return
      }
    }

    if touch.view == self.addAssignView ||
        touch.view == self.oneAssignedView ||
        manyAssignedViewSubviewsTouched
    {
      delegate?.leftAssigneeViewTouched(ruleId: self.ruleId)
    } else {
      // 나머지 부분 터치 시 기능 구현 예정
    }
  }
}
