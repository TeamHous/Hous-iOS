//
//  FormTextField.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/16.
//

// TextField 의 Inset 값을 나온 UI 형태로 바꾸어 주는 Component

import UIKit

class FormTextField: UITextField {
  var insetX: CGFloat = 20
  var insetY: CGFloat = 18
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: insetX, dy: insetY)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return textRect(forBounds: bounds)
  }
}
