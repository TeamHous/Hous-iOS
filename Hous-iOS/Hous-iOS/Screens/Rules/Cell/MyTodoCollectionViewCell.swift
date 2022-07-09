//
//  MyTodoCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/09.
//

import UIKit

class MyTodoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyTodoCollectionViewCell"
    
    var todoTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.text = "거실 청소기 돌리기"
    }
    var categoryImageView = UIImageView().then {
        $0.image = ImageLiteral.cleanCategory
    }
    var checkBoxButton = UIButton().then {
        $0.setImage(ImageLiteral.myTodoNoneCheckedBox, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        
        self.addSubViews([todoTitleLabel, categoryImageView, checkBoxButton])
        
        todoTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(categoryImageView.snp.trailing).offset(20)
            make.trailing.greaterThanOrEqualTo(checkBoxButton.snp.leading).inset(20)
        }
        
        categoryImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(40)
            make.centerY.equalTo(todoTitleLabel.snp.centerY)
        }
        checkBoxButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(24)
            make.centerY.equalTo(todoTitleLabel.snp.centerY)
        }
    }
    
    private func configure() {
        self.layer.cornerRadius = 15
        self.backgroundColor = .hous_purple_bg
    }
}
