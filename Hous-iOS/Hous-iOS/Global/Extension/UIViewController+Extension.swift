//
//  UIViewController+Extension.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/07.
//

import UIKit

extension UIViewController {
    /**
     - Description: 화면 터치시 작성 종료
     */
    /// 화면 터치시 작성 종료하는 메서드
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    /**
     - Description: 화면 터치시 키보드 내리는 Extension
     */
    /// 화면 터치시 키보드 내리는 메서드
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }

    /**
     - Description: Alert
     */
    /// 확인 버튼 2개, 취소 버튼 1개 ActionSheet 메서드
    func makeTwoAlertWithCancel(okTitle: String, okStyle: UIAlertAction.Style = .default,
                                secondOkTitle: String, secondOkStyle: UIAlertAction.Style = .default,
                                cancelTitle: String = "취소",
                                okAction : ((UIAlertAction) -> Void)?, secondOkAction : ((UIAlertAction) -> Void)?, cancelAction : ((UIAlertAction) -> Void)? = nil,
                                completion : (() -> Void)? = nil) {

        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        let alertViewController = UIAlertController(title: nil, message: nil,
                                                    preferredStyle: .actionSheet)

        let okAction = UIAlertAction(title: okTitle, style: okStyle, handler: okAction)
        alertViewController.addAction(okAction)

        let secondOkAction = UIAlertAction(title: secondOkTitle, style: secondOkStyle, handler: secondOkAction)
        alertViewController.addAction(secondOkAction)

        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction)
        alertViewController.addAction(cancelAction)

        self.present(alertViewController, animated: true, completion: completion)
    }

    /// 확인 버튼 1개, 취소 버튼 1개 Alert 메서드
    func makeAlertWithCancel(okTitle: String, okStyle: UIAlertAction.Style = .default,
                             cancelTitle: String = "취소",
                             okAction : ((UIAlertAction) -> Void)?, cancelAction : ((UIAlertAction) -> Void)? = nil,
                             completion : (() -> Void)? = nil) {

        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        let alertViewController = UIAlertController(title: nil, message: nil,
                                                    preferredStyle: .actionSheet)

        let okAction = UIAlertAction(title: okTitle, style: okStyle, handler: okAction)
        alertViewController.addAction(okAction)

        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction)
        alertViewController.addAction(cancelAction)

        self.present(alertViewController, animated: true, completion: completion)
    }

    /// 확인 버튼 Alert 메서드
    func makeAlert(title : String, message : String? = nil,
                   okTitle: String = "확인", okAction : ((UIAlertAction) -> Void)? = nil,
                   completion : (() -> Void)? = nil) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        let alertViewController = UIAlertController(title: title, message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: completion)
    }

    /**
     - Description:
     VC나 View 내에서 해당 함수를 호출하면, 햅틱이 발생하는 메서드입니다.
     버튼을 누르거나 유저에게 특정 행동이 발생했다는 것을 알려주기 위해 다음과 같은 햅틱을 활용합니다.

     - parameters:
     - degree: 터치의 세기 정도를 정의. 보통은 medium,light를 제일 많이 활용합니다.
     */
    func makeVibrate(degree : UIImpactFeedbackGenerator.FeedbackStyle = .medium)
    {
        let generator = UIImpactFeedbackGenerator(style: degree)
        generator.impactOccurred()
    }
}

