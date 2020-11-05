import Foundation
import UIKit

final class HotWaterMaintenanceViewModel {
    
    //MARK: - Properties
    unowned let viewController: UIViewController
    let apiService: APIService
    var hotWaterMaintenanceDetails: HotWaterMaintenanceDetails
    
    //MARK: - Initialization
    init(_ viewController: UIViewController,
         apiService: APIService,
         hotWaterMaintenanceDetails: HotWaterMaintenanceDetails) {
        
        self.viewController = viewController
        self.apiService = apiService
        self.hotWaterMaintenanceDetails = hotWaterMaintenanceDetails
    }
}
