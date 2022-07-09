//
//  ComingEventsCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit

protocol ComingEventsCollectionViewCellDelegate: AnyObject {
    func showPopup(_ row: Int)
}


class ComingEventsCollectionViewCell: UICollectionViewCell {
    
    private enum Size {
        static let screenWidth = UIScreen.main.bounds.width
        static let addEventCellSize = CGSize(width: 72, height: 88)
        static let eventCellSize = CGSize(width: 88, height: 88)
    }
    
    weak var delegate: ComingEventsCollectionViewCellDelegate?
    
    private let subtitleLabel = UILabel().then {
        $0.text = "Coming up-"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textAlignment = .left
    }
    
    private var incomingEventsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        setEventCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        contentView.addSubview(incomingEventsCollectionView)
        incomingEventsCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setEventCollectionView() {
        incomingEventsCollectionView.register(cell: EventsCollectionViewCell.self)
        
        incomingEventsCollectionView.delegate = self
        incomingEventsCollectionView.dataSource = self
    }
    
}


extension ComingEventsCollectionViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showPopup(indexPath.row)
    }
    
}

extension ComingEventsCollectionViewCell: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EventDataModel.sampleData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = incomingEventsCollectionView.dequeueReusableCell(withReuseIdentifier: EventsCollectionViewCell.className, for: indexPath) as? EventsCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.row == 0 {
            cell.d_dayLabel.isHidden = true
            cell.addIcon.isHidden = false
            cell.backgroudImageView.image = nil
            cell.backgroundColor = UIColor(hex: "FFF8E6")
            return cell
        } else {
            cell.d_dayLabel.isHidden = false
            cell.addIcon.isHidden = true
            cell.backgroudImageView.image = UIImage(systemName: "clock")
            cell.backgroundColor = UIColor(hex: "FFDE8A")
        }
        
        cell.setEventCellData(EventDataModel.sampleData[indexPath.row - 1])
        return cell
    }
    
    
}


extension ComingEventsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return Size.addEventCellSize
        }
        return Size.eventCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
