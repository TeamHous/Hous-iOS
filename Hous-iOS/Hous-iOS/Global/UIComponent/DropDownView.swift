//
//  DropDownView.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/12.
//

import RxSwift
import UIKit

final class DropDownView: UIView {

  var dropDownOptions: [String] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  var tableView = UITableView()
  weak var delegate: DropDownProtocol?

  override init(frame: CGRect) {
    super.init(frame: frame)

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
    let cell = UITableViewCell()
    cell.backgroundColor = .white
    cell.textLabel?.text = dropDownOptions[indexPath.row]
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.dropDownPressed(selectedItem: dropDownOptions[indexPath.row])
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

