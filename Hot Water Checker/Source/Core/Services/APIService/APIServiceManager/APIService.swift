import Foundation

class APIService {
    
    private let apiServiceManager = APIServiceManager.shared
    
    //MARK: - Getting info about hot water maintenance periods based on location
    func hotWaterMaintenanceRequest(classifierId: Int,
                                    completion: @escaping(Swift.Result<HotWaterMaintenanceResponse, ResponseErrorModel>) -> Void) {
        apiServiceManager.sendRequest(request: HotWaterMaintenanceRequest(classifiersId: classifierId)) { (result) in
            completion(result)
        }
    }
}
