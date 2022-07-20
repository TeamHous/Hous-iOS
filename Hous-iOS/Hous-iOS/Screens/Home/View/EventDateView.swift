//
//  EventDateView.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/12.
//

import UIKit

class EventDateView: UIView {
  
  var eventDate = ""
  
  private lazy var datePicker = UIDatePicker().then {
    var components = DateComponents()
    components.day = 0
    let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
    components.day = 365
    let maxDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
    
    $0.minimumDate = minDate
    $0.maximumDate = maxDate
    
    $0.preferredDatePickerStyle = .wheels
    $0.datePickerMode = .date
    $0.locale = Locale(identifier: "ko-KR")
    $0.timeZone = .autoupdatingCurrent
    $0.addTarget(self, action: #selector(handleDatePickerData), for: .valueChanged)
  }
  
  private let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dismissDatePicker))
  private let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
  private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(dismissDatePicker))
  
  private lazy var toolBar = UIToolbar().then {
    $0.setItems([cancelButton, flexibleButton, doneButton], animated: false)
    $0.sizeToFit()
  }
  
  private let yearBackgroundView = UIView().then {
    $0.backgroundColor = .offWhite
    $0.layer.cornerRadius = 10
  }
  
  private lazy var yearDatePickerTextField = UITextField().then {
    $0.text = Date.now.year.description
    setDateTextField($0)
  }
  
  private let yearLabel = UILabel().then {
    $0.text = "년"
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    $0.textColor = .brownGreyTwo
  }
  
  private let monthBackgroundView = UIView().then {
    $0.layer.cornerRadius = 10
    $0.backgroundColor = .offWhite
  }
  
  private lazy var monthDatePickerTextField = UITextField().then {
    $0.text = Date.now.month.description
    setDateTextField($0)
  }
  
  private let monthLabel = UILabel().then {
    $0.text = "월"
    $0.textAlignment = .center
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    $0.textColor = .brownGreyTwo
  }
  
  private let dayBackgroundView = UIView().then {
    $0.layer.cornerRadius = 10
    $0.backgroundColor = .offWhite
  }
  
  private lazy var dayDatePickerTextField = UITextField().then {
    $0.text = Date.now.day.description
    setDateTextField($0)
  }
  
  private let dayLabel = UILabel().then {
    $0.text = "일"
    $0.font = .font(.spoqaHanSansNeoMedium, ofSize: 16)
    $0.textColor = .brownGreyTwo
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func render() {
    self.addSubViews([yearBackgroundView, yearLabel, monthBackgroundView, monthLabel, dayBackgroundView, dayLabel])
    yearBackgroundView.addSubview(yearDatePickerTextField)
    monthBackgroundView.addSubview(monthDatePickerTextField)
    dayBackgroundView.addSubview(dayDatePickerTextField)
    
    
    yearBackgroundView.snp.makeConstraints { make in
      make.top.leading.bottom.equalToSuperview()
    }
    
    yearDatePickerTextField.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(10)
    }
    
    yearLabel.snp.makeConstraints { make in
      make.centerY.equalTo(yearBackgroundView)
      make.leading.equalTo(yearBackgroundView.snp.trailing).offset(5)
    }
    
    monthBackgroundView.snp.makeConstraints { make in
      make.centerY.equalTo(yearBackgroundView)
      make.leading.equalTo(yearLabel.snp.trailing).offset(8)
    }
    
    monthDatePickerTextField.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(10)
    }
    
    monthLabel.snp.makeConstraints { make in
      make.centerY.equalTo(monthBackgroundView)
      make.leading.equalTo(monthBackgroundView.snp.trailing).offset(5)
    }
    
    dayBackgroundView.snp.makeConstraints { make in
      make.centerY.equalTo(monthBackgroundView)
      make.leading.equalTo(monthLabel.snp.trailing).offset(8)
    }
    
    dayDatePickerTextField.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(10)
    }
    
    dayLabel.snp.makeConstraints { make in
      make.centerY.equalTo(dayBackgroundView)
      make.leading.equalTo(dayBackgroundView.snp.trailing).offset(5)
      make.trailing.equalToSuperview()
    }
    
  }
  
  private func setDateTextField(_ textField: UITextField) {
    textField.font = .font(.montserratMedium, ofSize: 15)
    textField.inputAccessoryView = toolBar
    textField.tintColor = .clear
    textField.inputView = datePicker
    textField.textAlignment = .center
  }
  
  func setDateLabel(date: String) {
    guard let date = date.toDate() else { return }
    
    let year = date.year
    let month = date.month
    let day = date.day
        
    yearDatePickerTextField.text = year.description
    monthDatePickerTextField.text = month.description
    dayDatePickerTextField.text = day.description
  }
  
  func getCurrentDateText() -> String {
    guard let year = yearDatePickerTextField.text?.description,
          let month = monthDatePickerTextField.text?.description,
          let day =  dayDatePickerTextField.text?.description
    else { return "" }
    
    guard let currentDate = "\(year)-\(month)-\(day)".toDate()?.formatted("yyyy-MM-dd") else { return "" }
    
    return currentDate
  }
}

//MARK: Objective-C methods

extension EventDateView {
  @objc private func handleDatePickerData() {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "yyyy-MM-dd"
    eventDate = dateformatter.string(from: datePicker.date)
    
    setDateLabel(date: eventDate)
  }
  
  @objc private func dismissDatePicker() {
    yearDatePickerTextField.endEditing(true)
    monthDatePickerTextField.endEditing(true)
    dayDatePickerTextField.endEditing(true)
  }
}
