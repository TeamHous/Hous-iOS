//
//  GraphBoxView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/12.
//

import UIKit
import SwiftUI

class PersonalityAttribute : UILabel {
  
  override init(frame: CGRect){
    super.init(frame: frame)
    self.textColor = .brownGrey
    self.font = .font(.spoqaHanSansNeoMedium, ofSize: 12)
  }
    
  required init?(coder: NSCoder){
    fatalError("init(coder:) has not been implemented")
  }
}

class ProfileGraphBoxView : UIView {
  
  let width = UIScreen.main.bounds.width
  
  var personalityLabel = UILabel().then{
    $0.text = "둥그란 동글이"
    $0.textColor = .lilac
    $0.font = .font(.spoqaHanSansNeoBold, ofSize: 22)
  }
  
  var profileGraphView = ProfileGraphView()
  
  var personalityAttributes : [UILabel] = []

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    appendPersonalityAttributesItems()
    configure()
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure(){
    self.backgroundColor = .paleGreyTwo
    self.layer.cornerRadius = 10
    self.layer.masksToBounds = true
  }
  
  private func render(){
    [personalityLabel, profileGraphView].forEach {self.addSubview($0)}
    
    personalityLabel.snp.makeConstraints {make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(32)
    }
    
    profileGraphView.snp.makeConstraints {make in
      make.top.equalTo(personalityLabel.snp.bottom).offset(29)
      make.bottom.equalToSuperview().offset(-29)
      make.leading.trailing.equalToSuperview().inset(79)
    }
    
    let labelPositionData : [Double] = [100, 105, 105, 105, 105]
    let labelPosition = makePoint(centerPoint: Point(x: (width-48)/2, y: 176), dataList: labelPositionData)
    print(personalityLabel.frame.origin)
    
    for (index, item) in personalityAttributes.enumerated(){
      self.addSubView(item)
      item.snp.makeConstraints {make in
        make.centerX.equalTo(labelPosition[index].x)
        make.centerY.equalTo(labelPosition[index].y)
      }
    }
  }
  
private func appendPersonalityAttributesItems(){
  let personalityAttributesString = ["빛", "정리\n정돈", "외향", "냄새", "소음"]
  for i in 0...4{
    let personalityAttributesItem = PersonalityAttribute()
    personalityAttributesItem.text = personalityAttributesString[i]
    if i == 1{
      personalityAttributesItem.numberOfLines = 2
    }
    personalityAttributes.append(personalityAttributesItem)
  }
}

private func makePoint(centerPoint : Point, dataList : [Double]) -> [Point]{
  let pi = Double.pi
  var points : [Point] = []
  for i in 0...4{
    var point = Point(x: 0, y: 0)
    let angle : Double = Double(i) * (2/5) * pi
    point.x = centerPoint.x - dataList[i] * cos((pi / 2) + angle)
    point.y = centerPoint.y - dataList[i] * sin((pi / 2) + angle)
    points.append(point)
    
  }
  var averageDataPoint: Point = Point(x: 0, y: 0)
  for point in points{
    averageDataPoint.x += (point.x - centerPoint.x)
    averageDataPoint.y += (point.y - centerPoint.y)
  }
  averageDataPoint.x += centerPoint.x
  averageDataPoint.y += centerPoint.y
  points.append(averageDataPoint)
  return points
  }
}


struct VCPreView7:PreviewProvider {
    static var previews: some View {
        ProfileViewController().toPreview()
    }
}
