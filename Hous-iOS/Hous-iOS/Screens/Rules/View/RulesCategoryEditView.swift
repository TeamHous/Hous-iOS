//
//  RulesCategoryEditView.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/12.
//

import UIKit
import SnapKit
import Then

final class RulesCategoryEditView: UIView {

  //MARK: - 변수

  enum Size {
    static let selectedCategoryViewSize: CGFloat = 100
    static let maxCategoryLength = 5
  }

  //var originalCategoryData: [CategoryDataModel]? .add면 nil, .update면 data 유

  private var categoryTitleLabel = UILabel().then {
    $0.textColor = R.Color.housBlack
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 20)
  }

  private var categorySettingView = UIView()
  var selectedCategoryImageView = UIImageView().then {
    $0.image = R.Image.clean
  }
  private var guideLabel = UILabel().then {
    $0.textColor = R.Color.softBlue
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    $0.text = "카테고리 이름"
  }
  private var duplicatedGuideLabel = UILabel().then {
    $0.textColor = R.Color.salmon
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 12)
    $0.text = "*중복된 이름입니다."
    $0.isHidden = true
  }
  var categoryTextField = UITextField().then {
    $0.textColor = R.Color.housBlack
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 14)
    $0.addLeftPadding(8)
    $0.backgroundColor = .white
    $0.makeRounded(cornerRadius: 10)
  }

  private lazy var categoryStackView = UIStackView().then {
    $0.axis = .vertical
    $0.alignment = .fill
    $0.distribution = .fillProportionally
    $0.spacing = 16
  }
  private var categoryFirstStackView = UIStackView()
  private var categorySecondStackView = UIStackView()

  var cleanCategoryButton = UIButton().then {
    $0.isSelected = true
    $0.setImage(R.Image.clean, for: .normal)
    $0.setImage(R.Image.cleanChecked, for: .selected)
  }
  var trashCategoryButton = UIButton().then {
    $0.setImage(R.Image.trash, for: .normal)
    $0.setImage(R.Image.trashChecked, for: .selected)
  }
  var lightCategoryButton = UIButton().then {
    $0.setImage(R.Image.light, for: .normal)
    $0.setImage(R.Image.lightChecked, for: .selected)
  }
  var heartCategoryButton = UIButton().then {
    $0.setImage(R.Image.heart, for: .normal)
    $0.setImage(R.Image.heartChecked, for: .selected)
  }
  var beerCategoryButton = UIButton().then {
    $0.setImage(R.Image.beer, for: .normal)
    $0.setImage(R.Image.beerChecked, for: .selected)
  }
  var cakeCategoryButton = UIButton().then {
    $0.setImage(R.Image.cake, for: .normal)
    $0.setImage(R.Image.cakeChecked, for: .selected)
  }
  var laundryCategoryButton = UIButton().then {
    $0.setImage(R.Image.laundry, for: .normal)
    $0.setImage(R.Image.laundryChecked, for: .selected)
  }
  var coffeeCategoryButton = UIButton().then {

    $0.setImage(R.Image.coffee, for: .normal)
    $0.setImage(R.Image.coffeeChecked, for: .selected)
  }

  //MARK: - 생명주기

  convenience init(editType: CategoryEditType) {
    self.init(frame: .zero)
    render()
    configUI(editType)
    setUp()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Setting

  private func render() {
    self.addSubViews([categoryTitleLabel, categorySettingView, categoryStackView])
    categorySettingView.addSubViews([selectedCategoryImageView, guideLabel, categoryTextField, duplicatedGuideLabel])
    categoryStackView.addArrangedSubviews(categoryFirstStackView, categorySecondStackView)
    categoryFirstStackView.addArrangedSubviews(cleanCategoryButton, trashCategoryButton, lightCategoryButton, heartCategoryButton)
    categorySecondStackView.addArrangedSubviews(beerCategoryButton, cakeCategoryButton, laundryCategoryButton, coffeeCategoryButton)

    categoryTitleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(32)
      make.leading.equalToSuperview().offset(24)
    }

    categorySettingView.snp.makeConstraints { make in
      make.top.equalTo(categoryTitleLabel.snp.bottom).offset(26)
      make.leading.trailing.equalToSuperview().inset(24)
      make.height.equalTo(100)
    }
    selectedCategoryImageView.snp.makeConstraints { make in
      make.top.leading.bottom.equalToSuperview()
      make.size.equalTo(100)
    }
    guideLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.leading.equalTo(selectedCategoryImageView.snp.trailing).offset(21)
    }
    categoryTextField.snp.makeConstraints { make in
      make.top.equalTo(guideLabel.snp.bottom).offset(8)
      make.leading.equalTo(guideLabel.snp.leading)
      make.trailing.equalToSuperview()
      make.height.equalTo(37)
    }
    duplicatedGuideLabel.snp.makeConstraints { make in
      make.top.equalTo(categoryTextField.snp.bottom).offset(8)
      make.leading.equalTo(guideLabel.snp.leading)
      make.bottom.equalToSuperview()
    }

    categoryStackView.snp.makeConstraints { make in
      make.top.equalTo(categorySettingView.snp.bottom).offset(32)
      make.leading.trailing.equalToSuperview().inset(24)
      // height 안잡음
    }

    [cleanCategoryButton, trashCategoryButton, lightCategoryButton, heartCategoryButton, cakeCategoryButton, beerCategoryButton, laundryCategoryButton, coffeeCategoryButton].forEach { button in
      button.snp.makeConstraints { make in
        make.height.equalTo(button.snp.width as ConstraintRelatableTarget)
      }
    }
  }

  private func configUI(_ editType: CategoryEditType) {
    self.layer.cornerRadius = 30
    self.backgroundColor = R.Color.paleGrey

    [categoryFirstStackView, categorySecondStackView].forEach {
      $0.axis = .horizontal
      $0.alignment = .fill
      $0.distribution = .fillEqually
      $0.spacing = 12
    }

    switch editType {
    case .add:
      categoryTitleLabel.text = "새로운 카테고리 추가"
    case .update:
      categoryTitleLabel.text = "카테고리 수정"
    }
  }
}
// MARK: - 라디오 버튼 기능
extension RulesCategoryEditView {

  private func setUp() {
    categoryTextField.delegate = self

    (categoryFirstStackView.subviews +
     categorySecondStackView.subviews).forEach {
      guard let button = $0 as? UIButton else { return }
      button.addTarget(self, action:  #selector(didTapCategory(_:)), for: .touchUpInside)
    }
  }

  @objc private func didTapCategory(_ sender: UIButton) {

    (categoryFirstStackView.subviews +
     categorySecondStackView.subviews).forEach {

      guard let button = $0 as? UIButton else { return }
      button == sender ? (button.isSelected = true) : (button.isSelected = false)
    }
    selectedCategoryImageView.image = sender.imageView?.image
  }
}

extension RulesCategoryEditView: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text else { return false }
    if text.count + 1 > Size.maxCategoryLength && range.length == 0 {
      return false
    }
    return true
  }
}
