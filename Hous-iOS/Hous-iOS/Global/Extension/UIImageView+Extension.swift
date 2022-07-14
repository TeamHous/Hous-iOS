//
//  UIImageView+Extension.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/15.
//

import UIKit

extension UIImageView {
  
  func urlToImage(urlString: String) {
      guard let url = URL(string: urlString) else { return }
      DispatchQueue.global().async { [weak self] in
          if let data = try? Data(contentsOf: url) {
              if let image = UIImage(data: data) {
                  DispatchQueue.main.async {
                      self?.image = image
                  }
              }
          }
      }
  }
  
}
