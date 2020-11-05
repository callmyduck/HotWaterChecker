import Foundation
import UIKit


final class AlertService {
    
    // MARK: - Properties
    
    static let shared: AlertService = AlertService()
    
    // MARK: - Methods
    
    func createAlert(withErrorKey errorKey: ResponseErrorKey,
                     onViewController viewController: UIViewController,
                     action: @escaping () -> ()) {
        
        let errorModel = ResponseErrorModel(errorKey)
        
        let titleString = errorModel.errorTitle
        let messageString = errorModel.errorText
        let actionTitleString = errorModel.errorAction
        
        let alertController = UIAlertController(title: titleString,
                                                message: messageString,
                                                preferredStyle: .alert)
        
        let action = UIAlertAction(title: actionTitleString,
                                   style: .default) { _ in
            action()
        }
        
        alertController.addAction(action)
        
        viewController.present(alertController,
                               animated: true)
    }
}
