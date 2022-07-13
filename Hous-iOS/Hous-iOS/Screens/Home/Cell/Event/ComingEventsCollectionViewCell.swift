//
//  ComingEventsCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit

protocol ComingEventsCollectionViewCellDelegate: AnyObject {
  func showPopup(_ icon: UIImage)
}


class ComingEventsCollectionViewCell: UICollectionViewCell {
  
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let addEventCellSize = CGSize(width: 72, height: 88)
    static let eventCellSize = CGSize(width: 88, height: 88)
  }
  
  weak var delegate: ComingEventsCollectionViewCellDelegate?
  
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
      make.leading.equalToSuperview()
      make.top.bottom.equalToSuperview()
      make.trailing.equalToSuperview()
    }
  }
  
  private func setEventCollectionView() {
    incomingEventsCollectionView.register(cell: EventsCollectionViewCell.self)
    
    incomingEventsCollectionView.delegate = self
    incomingEventsCollectionView.dataSource = self
  }
  
  private func setAddEventButton(cell: EventsCollectionViewCell) {
    cell.backgroundColor = .offWhite
    cell.d_dayLabel.isHidden = true
    cell.background3DIconImageView.isHidden = true
    cell.addIcon.isHidden = false
  }
  
  private func setEventButton(cell: EventsCollectionViewCell) {
    cell.backgroundColor = .paleGold
    cell.addIcon.isHidden = true
    cell.d_dayLabel.isHidden = false
    cell.background3DIconImageView.isHidden = false
    cell.background3DIconImageView.alpha = 0.6
  }
}


extension ComingEventsCollectionViewCell: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      delegate?.showPopup(R.Image.partyYellow)
      return
    }
    guard let eventIcon = EventDataModel.sampleData[indexPath.row - 1].eventImage else { return }
    delegate?.showPopup(eventIcon)
  }
  
}

extension ComingEventsCollectionViewCell: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return EventDataModel.sampleData.count + 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = incomingEventsCollectionView.dequeueReusableCell(withReuseIdentifier: EventsCollectionViewCell.className, for: indexPath) as? EventsCollectionViewCell else { return UICollectionViewCell() }
    
    if indexPath.row == 0 {
      setAddEventButton(cell: cell)
      
      return cell
    } else {
      setEventButton(cell: cell)
    }
    
    cell.setEventCellData(EventDataModel.sampleData[indexPath.row - 1])
    cell.setEventImageData(EventDataModel.sampleData[indexPath.row - 1])
    
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
    return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
  
}
