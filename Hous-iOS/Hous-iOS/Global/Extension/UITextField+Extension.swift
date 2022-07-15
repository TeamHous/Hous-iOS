//
//  UITextField+Extension.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/07.
//

import UIKit

extension UITextField {
  
  /// UITextField의 상태를 리턴함
  var isEmpty: Bool {
    if text?.isEmpty ?? true {
      return true
    }
    return false
  }
  
  /// UITextField 왼쪽에 여백 주는 메서드
  func addLeftPadding(_ amount: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.leftView = paddingView
    self.leftViewMode = .always
  }
  
  /// UITextField 오른쪽에 여백 주는 메서드
  func addRightPadding(_ amount: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.rightView = paddingView
    self.rightViewMode = .always
  }
  
  /// 자간 설정 메서드
  func setCharacterSpacing(_ spacing: CGFloat){
    let attributedStr = NSMutableAttributedString(string: self.text ?? "")
    attributedStr.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedStr.length))
    self.attributedText = attributedStr
  }
  
  /// Placeholder Color 설정 메서드
  // -> placeholder text를 먼저 설정한 뒤 textField.setPlaceholderColor(.systemGray)
  func setPlaceholderColor(_ placeholderColor: UIColor) {
    attributedPlaceholder = NSAttributedString(
      string: placeholder ?? "",
      attributes: [
        .foregroundColor: placeholderColor,
        .font: font
      ].compactMapValues { $0 }
    )
  }
}
