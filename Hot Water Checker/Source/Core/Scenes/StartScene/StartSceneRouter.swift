import Foundation
import UIKit

final class StartSceneRouter {
    
    unowned let viewController: UIViewController

    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    //MARK: - Public
    
    func openHotWaterMaintenanceController(withData data: HotWaterMaintenanceDetails) {
        let hotWaterMaintenanceController = HotWaterMaintenanceFactory.createModule(withData: data)
        hotWaterMaintenanceController.modalPresentationStyle = .fullScreen
        viewController.present(hotWaterMaintenanceController, animated: false)
    }
}

