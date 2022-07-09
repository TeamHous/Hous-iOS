//
//  EventsCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {
    
    let addIcon = UIImageView().then {
        $0.image = UIImage(systemName: "plus")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor(hex: "FFD66D")
        $0.isHidden = true
    }
    
    let d_dayLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
    }
    
    let backgroudImageView = UIImageView().then {
        $0.image = UIImage(systemName: "clock")
        $0.tintColor = .white.withAlphaComponent(0.3)
        $0.contentMode = .scaleAspectFit
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
        contentView.addSubview(backgroudImageView)
        backgroudImageView.addSubview(d_dayLabel)
        backgroudImageView.addSubview(addIcon)
        
        backgroudImageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        d_dayLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        addIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func configUI() {
        layer.cornerRadius = self.bounds.width / 4
    }
    
    func setEventCellData(_ data: EventDataModel) {
        d_dayLabel.text = data.ddayString
    }
    
    
    
}
