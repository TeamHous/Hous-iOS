//
//  GraphView.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/13.
//
import UIKit

struct Point{
  var x : Double = 0
  var y : Double = 0
}

final class GraphView : UIView {
  
  let graphShapeLayer = CAShapeLayer()
  let graphMaskLayer = CAShapeLayer()
  let backgroundShapeLayer = CAShapeLayer()
  let backgroundMaskLayer = CAShapeLayer()
  var dataList : [Double] = [0, 0, 0, 0, 0]
  var paths : [[CGPoint]] = [[CGPoint()]]
  
  convenience init(dataList: [Double]) {
    self.init(frame: .zero)
    self.dataList = dataList
    self.paths = self.setUpGraphPaths(dataList)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    backgroundColor = UIColor.clear
    drawGraphInitalPath()
  }
  
  private func drawGraphInitalPath(){
    let graphPath = UIBezierPath.roundedCornersPath(paths[0], 10)
    graphShapeLayer.path = graphPath?.cgPath
    graphShapeLayer.strokeColor = UIColor.clear.cgColor
    graphShapeLayer.fillColor = R.Color.lilac.cgColor
    layer.addSublayer(graphShapeLayer)
    
    graphMaskLayer.path = graphShapeLayer.path
    graphMaskLayer.position =  graphShapeLayer.position
    layer.mask = graphMaskLayer
    doAnimationGraph(editing: true, newPath: paths[1])
  }
  
  func doAnimationGraph(editing:Bool, newPath: [CGPoint]){
    let animation = CABasicAnimation(keyPath: "path")
    animation.duration = 1
    animation.beginTime = CACurrentMediaTime() + 1// Your new shape here
    let newPath = UIBezierPath.roundedCornersPath(newPath, 30)
    animation.toValue = newPath?.cgPath
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    // The next two line preserves the final shape of animation,
    // if you remove it the shape will return to the original shape after the animation finished
    animation.fillMode = CAMediaTimingFillMode.forwards
    animation.isRemovedOnCompletion = false
    graphShapeLayer.add(animation, forKey: nil)
    graphMaskLayer.add(animation, forKey: nil)
  }
  
  
  private func setUpGraphPaths(_ dataList : [Double] )->[[CGPoint]]{
    let centerX = Double(self.frame.width)/2
    let centerY = Double(self.frame.height)/2
    let centerPoint = Point(x: centerX, y: centerY)
    
    let pointList = makePoint(centerPoint: centerPoint, dataList: dataList)
    
    let backgroundDataList : [Double] = [90, 90, 90, 90, 90]
    let backgroundPointList = makePoint(centerPoint: centerPoint, dataList: backgroundDataList)
    
    let graphPath: [CGPoint] = [
      CGPoint(x: pointList[0].x, y: pointList[0].y),
      CGPoint(x: pointList[1].x, y: pointList[1].y),
      CGPoint(x: pointList[2].x, y: pointList[2].y),
      CGPoint(x: pointList[3].x, y: pointList[3].y),
      CGPoint(x: pointList[4].x, y: pointList[4].y)
    ]
    
    let backgroundPath: [CGPoint] = [
      CGPoint(x: backgroundPointList[0].x, y: backgroundPointList[0].y),
      CGPoint(x: backgroundPointList[1].x, y: backgroundPointList[1].y),
      CGPoint(x: backgroundPointList[2].x, y: backgroundPointList[2].y),
      CGPoint(x: backgroundPointList[3].x, y: backgroundPointList[3].y),
      CGPoint(x: backgroundPointList[4].x, y: backgroundPointList[4].y),
    ]
    
    let initialPath : [CGPoint] = [
      CGPoint(x: centerPoint.x + 0.001 * pointList[0].x, y: centerPoint.y + 0.001 * pointList[0].y),
      CGPoint(x: centerPoint.x + 0.001 * pointList[1].x, y: centerPoint.y + 0.001 * pointList[1].y),
      CGPoint(x: centerPoint.x + 0.001 * pointList[2].x, y: centerPoint.y + 0.001 * pointList[2].y),
      CGPoint(x: centerPoint.x + 0.001 * pointList[3].x, y: centerPoint.y + 0.001 * pointList[3].y),
      CGPoint(x: centerPoint.x + 0.001 * pointList[4].x, y: centerPoint.y + 0.001 * pointList[4].y)
    ]
    
    let paths = [initialPath, graphPath, backgroundPath]
    return paths
  }
  
  private func makePoint(centerPoint : Point, dataList : [Double]) -> [Point]{
    let pi = Double.pi
    var points : [Point] = []
    for i in 0...4{
      var point = Point(x: 0, y: 0)
      let angle : Double = Double(i) * (2/5) * pi
      point.x = centerPoint.x - dataList[i] * cos((pi / 2) - angle)
      point.y = centerPoint.y - dataList[i] * sin((pi / 2) - angle)
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
