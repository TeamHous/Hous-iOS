//
//  DropDownView.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/12.
//

import RxSwift
import UIKit

final class DropDownView: UIView {

  var isCategory: Bool

  var dropDownOptions: [(String, UIColor)] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  var tableView: UITableView = {
    let tableView = UITableView()
    tableView.rowHeight = 38

    return tableView
  }()
  weak var delegate: DropDownProtocol?

  init(isCategory: Bool) {
    self.isCategory = isCategory
    super.init(frame: .zero)

    setupViews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
extension DropDownView {
  private func setupViews() {
    addSubview(tableView)

    backgroundColor = .white
    layer.masksToBounds = true
    layer.cornerCurve = .continuous
    layer.cornerRadius = 16

    tableView.backgroundColor = UIColor.white
    tableView.delegate = self
    tableView.dataSource = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorStyle = .none

    tableView.register(cell: HomieDropDownTableViewCell.self)

    NSLayoutConstraint.activate([
      tableView.leftAnchor.constraint(equalTo: leftAnchor),
      tableView.rightAnchor.constraint(equalTo: rightAnchor),
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
}

extension DropDownView: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dropDownOptions.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    if isCategory {
      let cell = UITableViewCell()
      cell.backgroundColor = .white
      cell.textLabel?.font = .font(.spoqaHanSansNeoMedium, ofSize: 14)
      cell.textLabel?.textColor = R.Color.brownGreyTwo
      cell.textLabel?.text = dropDownOptions[indexPath.row].0
      cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
      return cell
    }

    else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: HomieDropDownTableViewCell.className) as? HomieDropDownTableViewCell else {
        return UITableViewCell()
      }

      cell.configureCell(
        item: HomieDropDownTableViewCellModel(
          name: dropDownOptions[indexPath.row].0,
          color: dropDownOptions[indexPath.row].1
        )
      )

      return cell
    }
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.dropDownPressed(selectedItem: dropDownOptions[indexPath.row].0)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
