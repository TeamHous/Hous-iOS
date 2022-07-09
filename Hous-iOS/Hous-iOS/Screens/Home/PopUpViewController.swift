//
//  PopUpViewController.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

class PopUpViewController: UIViewController {
    
    private lazy var blurView = UIVisualEffectView().then {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        $0.effect = blurEffect
        $0.frame = view.bounds
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private let popUpView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "이벤트"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.tintColor = .black
    }
    
    private let eventImageView = UIImageView().then {
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor(hex: "FFD66D")
    }
    
    private let eventTextField = UITextField().then {
        $0.backgroundColor = UIColor(hex: "FFD66D")
    }
    
    private let cancelButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "취소"
        config.baseForegroundColor = .red
        config.baseBackgroundColor = .white
        $0.configuration = config
        
        $0.addTarget(self, action: #selector(cancelButtonDidTapped), for: .touchUpInside)
        
        $0.layer.borderColor = UIColor.red.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.backgroundColor = UIColor(hex: "FFD66D")
    }
    
    private lazy var buttonStackView = UIStackView(arrangedSubviews: [cancelButton, saveButton]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let touch = touches.first, touch.view == self.blurView {
            dismiss(animated: true)
        }
    }

    @objc private func cancelButtonDidTapped() {
        self.dismiss(animated: true)
    }
        
    private func render() {
        self.view.addSubview(blurView)
        self.view.addSubview(popUpView)
        popUpView.addSubViews([titleLabel, eventImageView, buttonStackView])
        
        popUpView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * (272/375))
            make.height.equalTo(UIScreen.main.bounds.height * (439/812))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.leading.equalToSuperview().offset(24)
        }
        
        eventImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(60)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(20)
        }
        
    }

}

