//
//  SplashViewController.swift
//  Hous-iOS
//
//  Created by 김호세 on 2022/07/07.
//

import UIKit
import Lottie

final class SplashViewController: UIViewController {
  
  private enum Size {
    static let splashWidth = UIScreen.main.bounds.width * (285/375)
    static let splashHeight = Size.splashWidth * (274/285)
    
  }
  
  private let animationView = AnimationView(name: "splashlottie").then {
    $0.contentMode = .scaleAspectFill
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    playAnimationView()
  }
  
  private func render() {
    view.addSubView(animationView)

    animationView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.equalTo(Size.splashWidth)
      make.height.equalTo(Size.splashHeight)
    }
    
    animationView.play { finish in
      self.animationView.removeFromSuperview()
    }
  }
  
  private func playAnimationView() {
    animationView.play()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      let tabbarViewController = HousTabbarViewController()
      
      tabbarViewController.modalPresentationStyle = .fullScreen
      
      self.present(tabbarViewController, animated: true) {
        self.view.window?.rootViewController = tabbarViewController
        self.view.window?.makeKeyAndVisible()
      }
    }
  }
  
}
