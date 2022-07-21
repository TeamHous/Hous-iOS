//
//  AddRulesViewController.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/20.
//

import FlexLayout
import PinLayout
import ReactorKit
import RxCocoa
import RxSwift

import SnapKit

import UIKit

final class AddRulesViewController: UIViewController {

  private struct Constant {
    static let safeAreaTopMargin: CGFloat = 34
    static let sideMargin: CGFloat = 24
    static let itemHeight: CGFloat = 38
    static let plusButtonHeight: CGFloat = 32
    static let labelUpAndDownMargin: CGFloat = 8
    static let itemUpDownMargin: CGFloat = 16
  }

  private lazy var notificationButton: UIBarButtonItem = {
    let button = UIButton()
    button.setImage(R.Image.alarmOff, for: .normal)
    button.setImage(R.Image.alarmOn, for: .selected)

    let barbutton = UIBarButtonItem(customView: button)
    return barbutton
  }()

  private let contentView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 24
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.backgroundColor = .red
    stackView.layoutMargins.left = Constant.sideMargin
    stackView.layoutMargins.right = Constant.sideMargin
    stackView.isLayoutMarginsRelativeArrangement = true
    return stackView
  }()

  private let ruleNameTextField: UITextField = {

    let textField = UITextField()
    textField.addLeftPadding(12)
    textField.addRightPadding(12)
    textField.placeholder = "규칙이름을 입력해주세요"
    textField.font = .font(.montserratMedium, ofSize: 12)
    textField.backgroundColor = .white
    textField.layer.cornerCurve = .continuous
    textField.layer.cornerRadius = 10

    return textField
  }()

  private let categoriesTextField: UITextField = {
    let textField = UITextField()
    textField.addLeftPadding(12)
    textField.addRightPadding(12)
    textField.placeholder = "카테고리명을 입력해주세요"
    textField.font = .font(.montserratMedium, ofSize: 12)
    textField.backgroundColor = .white

    return textField
  }()

  private lazy var categoryDropDownButton: DropDownButton = {
    let button = DropDownButton(text: "카테고리", isCategory: true)
    button.addTarget(self, action: #selector(didTapCategoryDropDownButton), for: .touchUpInside)

    return button
  }()

  private let keyRuleStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.spacing = 6

    return stackView
  }()


  private let keyRuleCheckButton: UIButton = {
    let button = UIButton()
    button.setImage(R.Image.rulesSelected, for: .normal)
    button.setImage(R.Image.keyRulesUnchecked, for: .disabled)
    button.setImage(R.Image.rulesChecked, for: .selected)

    return button
  }()

  private let keyRuleLabel: UILabel = {
    let label = UILabel()
    label.text = "Key Rules로 추가"
    label.textColor = R.Color.veryLightPinkFive
    label.font = .font(.montserratMedium, ofSize: 16)
    label.textAlignment = .left
    label.setContentHuggingPriority(.defaultHigh, for: .horizontal)

    return label
  }()

  private let keyRuleDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = """
담당자와 날짜 구분을 하지 않고 항상 하는 규칙이라면
카데고리 상단에 표시 됩니다
"""
    label.numberOfLines = 0
    label.textColor = R.Color.veryLightPinkFive
    label.font = .font(.montserratMedium, ofSize: 12)

    return label
  }()


  private lazy var addRuleMemberButton: PlusButton = {
    let button = PlusButton()
    return button
  }()

  private let addButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = R.Color.softBlue
    button.setTitle("추가하기", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = .font(.spoqaHanSansNeoBold, ofSize: 18)
    button.layer.cornerCurve = .continuous
    button.layer.cornerRadius = 15

    return button
  }()

  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()

    return scrollView
  }()

  private var totalRulesMemberViews: [RulesMemberView] = []
  internal var disposeBag = DisposeBag()

  private var initialMembers: [String] = []
  private var remainingMembers: [String] = []
  private var selectedMembers: [String] = []
  private var isEnabledKeyRuleButton: Bool = true
  private var isFirst: Bool = true

  private var dictionary: [Int: String] = [:] {
    didSet {
      let members = Array(dictionary.values)

      print(dictionary, "이거 Dictionary")

      let compareSet = Set(members)
      let resultArray = initialMembers.filter { !compareSet.contains($0) }

      print(initialMembers, "initial")
      print(members, "members")
      print(dictionary, "dictionary")
      print(resultArray, "remain")

      remainingMembers = resultArray
      totalRulesMemberViews.forEach { memberView in
        memberView.calculateRemainingMember(members: remainingMembers)
      }
      if dictionary.isEmpty {
        keyRuleCheckButton.isEnabled = true
      } else {
        keyRuleCheckButton.isEnabled = false
      }
    }
  }

  init() {
    super.init(nibName: nil, bundle: nil)

  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)

    fatalError("AddRulesViewController fatal Error")

  }

  // MARK: - ViewController Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    setupViews()

    let reactor = AddRulesReactor()
    self.reactor = reactor
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false
    navigationController?.navigationBar.topItem?.title = ""
    navigationItem.rightBarButtonItem = notificationButton
    navigationItem.title = "새로운 규칙 추가"
  }

  @objc
  private func didTapCategoryDropDownButton() {
    categoryDropDownButton.isSelected = !categoryDropDownButton.isSelected
  }

  private func makeLabel(text: String) -> UILabel {
    let label = UILabel()
    label.font = .font(.montserratMedium, ofSize: 16)
    label.textColor = R.Color.softBlue
    label.text = text

    return label
  }

  private func setupViews() {

    let ruleNameLabel = makeLabel(text: "규칙 이름")
    let categoryLabel = makeLabel(text: "카테고리")
    let ruleMemberLabel = makeLabel(text: "담당자 설정")

    view.backgroundColor = R.Color.paleGrey
    scrollView.backgroundColor = R.Color.paleGrey
    contentView.backgroundColor = R.Color.paleGrey

    view.addSubview(scrollView)
    scrollView.addSubview(contentView)

    scrollView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview().inset(150)
    }

    contentView.snp.makeConstraints { make in
      make.top.leading.bottom.trailing.equalToSuperview()
      make.width.equalToSuperview()
    }

    contentView.addArrangedSubview(ruleNameLabel)
    contentView.setCustomSpacing(Constant.labelUpAndDownMargin, after: ruleNameLabel)

    contentView.addArrangedSubview(ruleNameTextField)
    contentView.setCustomSpacing(Constant.itemUpDownMargin, after: ruleNameTextField)

    contentView.addArrangedSubview(categoryLabel)
    contentView.setCustomSpacing(Constant.labelUpAndDownMargin, after: categoryLabel)

    contentView.addArrangedSubview(categoryDropDownButton)
    contentView.setCustomSpacing(Constant.itemUpDownMargin, after: categoryDropDownButton)

    contentView.addArrangedSubview(keyRuleStackView)
    contentView.setCustomSpacing(4, after: keyRuleStackView)

    contentView.addArrangedSubview(keyRuleDescriptionLabel)
    contentView.setCustomSpacing(Constant.itemUpDownMargin, after: keyRuleDescriptionLabel)

    contentView.addArrangedSubview(ruleMemberLabel)

    contentView.addArrangedSubview(addRuleMemberButton)

    keyRuleStackView.addArrangedSubview(keyRuleCheckButton)
    keyRuleStackView.addArrangedSubview(keyRuleLabel)

    ruleNameTextField.snp.makeConstraints { make in
      make.height.equalTo(Constant.itemHeight)
    }
    categoryDropDownButton.snp.makeConstraints { make in
      make.height.equalTo(Constant.itemHeight)
    }
    keyRuleCheckButton.snp.makeConstraints { make in
      make.width.height.equalTo(24)
    }
    addRuleMemberButton.snp.makeConstraints { make in
      make.height.equalTo(Constant.plusButtonHeight)
    }
  }
}



extension AddRulesViewController: ReactorKit.View {

  func bind(reactor: AddRulesReactor) {
    bindAction(reactor)
    bindState(reactor)
  }

  private func bindAction(_ reactor: AddRulesReactor) {

    rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
      .map { _ in () }
      .map { Reactor.Action.viewWillAppear }
      .asObservable()
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    keyRuleCheckButton.rx.tap
      .map { Reactor.Action.didTapKeyRuleButton }
      .asObservable()
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    addRuleMemberButton.rx.tap
      .map { [weak self] _ -> [String] in
        guard let remainMembers = self?.remainingMembers else {
          return []
        }
        return remainMembers
      }
      .map { Reactor.Action.didTapPlusButton($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

  }

  private func bindState(_ reactor: AddRulesReactor) {

    reactor.state
      .map { $0.catergories }
      .distinctUntilChanged()
      .bind(to: categoryDropDownButton.dropView.rx.dropDownOptions)
      .disposed(by: disposeBag)

    reactor.state
      .map { $0.initialMembers }
      .distinctUntilChanged()
      .skip(1)
      .withUnretained(self)
      .subscribe(onNext: { owner, initialMembers in

        owner.initialMembers = initialMembers
        owner.appendRuleMemberView(members: initialMembers)
        owner.remainingMembers = initialMembers
        owner.isFirst = false

      })
      .disposed(by: disposeBag)

    reactor.state
      .map { $0.isSelectedKeyRule }
      .distinctUntilChanged()
      .withUnretained(self)
      .subscribe(onNext: { owner, isSelected in

        // TODO: Refactor - 함수로 바꾸기
        if isSelected {
          owner.totalRulesMemberViews.first?.setNoResponsible()
          owner.keyRuleLabel.textColor = R.Color.softBlue
          owner.keyRuleDescriptionLabel.textColor = R.Color.softBlue
          owner.addRuleMemberButton.isHidden = true
        }

        if !isSelected {
          owner.totalRulesMemberViews.first?.setDefaultResponsible()
          owner.keyRuleCheckButton.isSelected = false
          owner.keyRuleLabel.textColor = R.Color.veryLightPinkFive
          owner.keyRuleDescriptionLabel.textColor = R.Color.veryLightPinkFive
          owner.addRuleMemberButton.isHidden = false
        }
        owner.keyRuleCheckButton.isSelected = isSelected

      })
      .disposed(by: disposeBag)

    reactor.state
      .map { $0.remainingMembers }
      .distinctUntilChanged()
      .skip(2)
      .withUnretained(self)
      .subscribe(onNext: { owner, members in

        if members.count <= 1 {
          owner.addRuleMemberButton.isHidden = true
        } else {
          owner.addRuleMemberButton.isHidden = false
        }

        owner.appendRuleMemberView(members: members)

      })
      .disposed(by: disposeBag)
  }

}

extension AddRulesViewController {

  private func appendRuleMemberView(members: [String]) {
    let memberView = RulesMemberView()

    memberView.tag = totalRulesMemberViews.count
    totalRulesMemberViews.append(memberView)

    memberView.calculateRemainingMember(members: members)

    memberView.dropDownButton.rx.tap
      .withUnretained(self)
      .subscribe(onNext: { owner, _ in
        memberView.dropDownButton.isSelected =  (!memberView.dropDownButton.isSelected)
      })
      .disposed(by: disposeBag)

    memberView.dropDownButton.selectedItemSubject
      .withUnretained(self)
      .subscribe(onNext: { owner, selectedItem in
        owner.dictionary[memberView.tag] = selectedItem
      })
      .disposed(by: disposeBag)

    memberView.isTappedSubject
      .withUnretained(self)
      .subscribe(onNext:  { owner, isTapped in


        switch (owner.dictionary.isEmpty, isTapped) {
        case (_, true):

          owner.keyRuleCheckButton.isEnabled = false

        case (false, _):
          owner.keyRuleCheckButton.isEnabled = false

        case (true, false):
          owner.keyRuleCheckButton.isEnabled = true
        }


      })
      .disposed(by: disposeBag)


    memberView.dropDownButton.removeButton.rx.tap
      .withUnretained(self)
      .subscribe(onNext: { owner, _ in
        owner.dictionary.removeValue(forKey: memberView.tag)
        owner.totalRulesMemberViews.removeAll(where: {$0.tag == memberView.tag } )

        owner.contentView.removeArrangedSubview(memberView)
        memberView.removeFromSuperview()

      })
      .disposed(by: disposeBag)

    memberView.snp.makeConstraints { make in
      make.height.equalTo(85)
    }

    contentView.removeArrangedSubview(addRuleMemberButton)
    addRuleMemberButton.removeFromSuperview()

    contentView.addArrangedSubview(memberView)
    contentView.addArrangedSubview(addRuleMemberButton)

  }
}

extension Sequence where Element: Hashable {
  func uniqued() -> [Element] {
    var set = Set<Element>()
    return filter { set.insert($0).inserted }
  }
}
extension Array where Element: Hashable {
  func difference(from other: [Element]) -> [Element] {
    let thisSet = Set(self)
    let otherSet = Set(other)
    return Array(thisSet.symmetricDifference(otherSet))
  }
}

