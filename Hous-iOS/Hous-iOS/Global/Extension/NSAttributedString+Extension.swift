//
//  NSAttributedString+Extension.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/22.
//
import UIKit

extension NSAttributedString {
  func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(attributedString: self)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    paragraphStyle.lineBreakMode = .byTruncatingTail
    paragraphStyle.lineSpacing = spacing
    attributedString.addAttribute(.paragraphStyle,
                                  value: paragraphStyle,
                                  range: NSRange(location: 0, length: string.count))
    return NSAttributedString(attributedString: attributedString)
  }
}
