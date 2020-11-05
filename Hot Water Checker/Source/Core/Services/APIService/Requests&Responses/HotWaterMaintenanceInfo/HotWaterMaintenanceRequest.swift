import Foundation

class HotWaterMaintenanceRequest: RequestModel {
    // MARK: - Properties
    private var classifiersId: String
    
    init(classifiersId: Int) {
        self.classifiersId = String(describing: classifiersId)
    }
    
    override var path: String {
        return APIServicePaths.hotWaterMaintenanceInfo
    }
    
    override var parameters: [String : Any?] {
        return [
            "classifiersId": classifiersId
        ]
    }
}
