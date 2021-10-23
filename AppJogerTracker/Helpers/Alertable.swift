
import UIKit

protocol Alertable { }

extension Alertable where Self: UIViewController {
    
    func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
        alertController.addAction(okAction)
        
        DispatchQueue.main.async {
            if self.view.window?.rootViewController?.presentedViewController is JogDetailViewController{
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            }
            self.view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
