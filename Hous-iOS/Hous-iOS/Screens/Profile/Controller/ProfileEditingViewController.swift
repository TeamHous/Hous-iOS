//
//  ProfileEdittingViewController.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/15.
//

import UIKit

final class ProfileEditingViewController : UIViewController {
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
  }
  
  private let profileEditingNavigationBarView = ProfileEditingNavigationBarView()
  
  private let profileEditingScrollView = UIScrollView().then {
    $0.backgroundColor = .white
  }
  
  private let profileEditingScrollContentsView = ProfileEditingScrollContentsView().then() {
    $0.backgroundColor = .white
  }
  
  private let saveButton = UIButton().then {
    $0.backgroundColor = .salmon
    $0.isEnabled = true
    $0.setTitle("저장하기", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.layer.cornerRadius = 10
    $0.layer.masksToBounds = true
    $0.titleLabel?.font = .font(.spoqaHanSansNeoBold, ofSize: 18)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    configUI()
    render()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationController()
  }
  
  private func setNavigationController() {
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    if let tvc = navigationController?.tabBarController as? HousTabbarViewController {
      tvc.housTabbar.isHidden = true
    }
  }
  
  private func setup(){
    registerCell()
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    profileEditingNavigationBarView.popNavigationController = { [self] in
      navigationController?.popViewController(animated: true)
    }
  }
  
  private func configUI(){
    view.backgroundColor = .white
  }
  
  private func render(){
    view.addSubViews([profileEditingNavigationBarView, profileEditingScrollView, saveButton])
    profileEditingScrollView.addSubView(profileEditingScrollContentsView)
    
    profileEditingNavigationBarView.snp.makeConstraints { make in
      make.height.equalTo(60)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
    }
    
    profileEditingScrollView.snp.makeConstraints {make in
      //      make.width.equalToSuperview()
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(profileEditingNavigationBarView.snp.bottom)
      make.bottom.equalTo(saveButton.snp.top).offset(-10)
    }
    
    saveButton.snp.makeConstraints {make in
      make.leading.trailing.equalToSuperview().inset(24)
      make.bottom.equalToSuperview().inset(40)
      make.height.equalTo(54)
    }
    
    profileEditingScrollContentsView.snp.makeConstraints {make in
      make.top.bottom.equalTo(profileEditingScrollView)
      make.leading.trailing.equalTo(profileEditingScrollView).inset(24)
      make.width.equalTo(Size.screenWidth - 48)
    }
  }
  
  private func registerCell(){
  }
}

extension ProfileEditingViewController : UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.text == "나이 등 간단한 자기소개" {
      textView.text = nil
      textView.textColor = .black
    }
  }
}
