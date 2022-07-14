//
//  UIBezierPath+Extension.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/13.
//

import UIKit

public extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let xDist = x - point.x
        let yDist = y - point.y
        return (xDist * xDist + yDist * yDist).squareRoot()
    }
}


public func radiusOfCircle(inscribedInto triangle: (pa: CGPoint, pb: CGPoint, pc: CGPoint)) -> CGFloat {
    let (pa, pb, pc) = triangle
    let a = pa.distance(to: pb)
    let b = pb.distance(to: pc)
    let c = pc.distance(to: pa)

    let halfP = (a + b + c) / 2
    return ((halfP - a) * (halfP - b) * (halfP - c) / halfP).squareRoot()
}

extension UIBezierPath {
    private static func addCorner(
        _ path: UIBezierPath,
        p1: CGPoint,
        p: CGPoint,
        p2: CGPoint,
        radius: CGFloat,
        isStart: Bool = false
    ) {
        // Override `radius` with maximum available radius
        // which is the radius of the circle inscribed into triangle defined by our points
        var radius = min(
            radiusOfCircle(inscribedInto: (p1, p, p2)),
            radius
        )

        // Find the angle defined by our points
        let angle = CGFloat(atan2(p.y - p1.y, p.x - p1.x) - atan2(p.y - p2.y, p.x - p2.x)).positiveAngle

        // Get the length of segment between angular point and the points of intersection with the circle.
        var tangentLength = radius / abs(tan(angle / 2))

        // Check the length of segment and the minimal length from
        let p_p1 = p.distance(to: p1)
        let p_p2 = p.distance(to: p2)

        // Update `tangentLenghth` according to the smaller triangle side
        tangentLength = min(tangentLength, min(p_p1, p_p2))

        // Update `radius` according to the smaller triangle side
        radius = tangentLength * abs(tan(angle / 2))

        // Find distance from angle vertex to circle origin
        let p_o = sqrt(radius.sqr + tangentLength.sqr)

        // Segment intersected by parallel lines is divided keeping proportion
        // Project angle sides onto axis and calculate circle origin from the proportion
        let c1 = CGPoint(
            x: (p.x - (p.x - p1.x) * tangentLength / p_p1),
            y: (p.y - (p.y - p1.y) * tangentLength / p_p1)
        )

        let c2 = CGPoint(
            x: (p.x - (p.x - p2.x) * tangentLength / p_p2),
            y: (p.y - (p.y - p2.y) * tangentLength / p_p2)
        )

        let dx = p.x * 2 - c1.x - c2.x
        let dy = p.y * 2 - c1.y - c2.y

        let p_c = (dx.sqr + dy.sqr).squareRoot()

        // Find Circle origin
        let o = CGPoint(
            x: p.x - dx * p_o / p_c,
            y: p.y - dy * p_o / p_c
        )

        // Find start and end angle (required for Arc drawing)
        let startAngle = (atan2((c1.y - o.y), (c1.x - o.x))).positiveAngle
        let endAngle = (atan2((c2.y - o.y), (c2.x - o.x))).positiveAngle


        if isStart {
            path.move(to: c1)
        } else {
            path.addLine(to: c1)
        }

        path.addArc(withCenter: o, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: angle < .pi)
    }

    public static func roundedCornersPath(_ pts: [CGPoint], _ r: CGFloat) -> UIBezierPath? {
        guard pts.isEmpty == false else {
            return nil
        }
        let path = UIBezierPath()
      for i in 1 ... pts.count {
            let prev = pts[i-1]
            let curr = pts[i % pts.count]
            let next = pts[(i + 1) % pts.count]
            addCorner(path, p1: prev, p: curr, p2: next, radius: r, isStart: i == 1)
        }
        path.close()
        return path
    }
}

public extension CGFloat {
    var sqr: CGFloat {
        self * self
    }

    var positiveAngle: CGFloat {
        self < 0
            ? self + 2 * .pi
            : self
    }
}
