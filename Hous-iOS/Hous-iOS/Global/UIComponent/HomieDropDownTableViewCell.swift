//
//  HomieDropDownTableViewCell.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/22.
//

import SnapKit
import UIKit


struct HomieDropDownTableViewCellModel {
  let name: String
  let color: UIColor

}


final class HomieDropDownTableViewCell: UITableViewCell {

  let nameLabel: UILabel = {
    let label = UILabel()
    label.textColor = R.Color.brownGreyTwo
    label.font = .font(.spoqaHanSansNeoMedium, ofSize: 14)
    return label
  }()

  let colorView: UIView = {
    let view = UIView()
    view.backgroundColor = .yellow
    view.layer.cornerRadius = 8
    view.layer.cornerCurve = .continuous
    return view
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setupViews()
  }
  override func layoutSubviews() {
    super.layoutSubviews()

    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configureCell(item: HomieDropDownTableViewCellModel) {
    nameLabel.text = item.name
    colorView.backgroundColor = item.color
  }

  private func setupViews() {
    contentView.addSubview(colorView)
    contentView.addSubview(nameLabel)

    colorView.snp.makeConstraints { make in
      make.width.height.equalTo(16)
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().inset(12)
    }
    nameLabel.snp.makeConstraints { make in
      make.leading.equalTo(colorView.snp.trailing).offset(6)
      make.centerY.equalToSuperview()
    }

  }
}
