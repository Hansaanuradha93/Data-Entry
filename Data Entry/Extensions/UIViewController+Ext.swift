import UIKit

extension UIViewController {
    
    func presentAlertOnMainTread(title: String, message: String, buttonTitle: String = Strings.ok, action: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertVC = DEAlertVC(title: title, message: message, buttonTitle: buttonTitle, action: action)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}

