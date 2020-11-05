import Foundation
import UIKit

struct HotWaterMaintenanceFactory {

    static func createModule(withData hotWaterMaintenanceDetails: HotWaterMaintenanceDetails) -> UIViewController {
        
        let viewController = HotWaterMaintenanceViewController()
        
        let apiService = APIService()
        
        let viewModel = HotWaterMaintenanceViewModel(viewController,
                                          apiService: apiService,
                                          hotWaterMaintenanceDetails: hotWaterMaintenanceDetails)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
