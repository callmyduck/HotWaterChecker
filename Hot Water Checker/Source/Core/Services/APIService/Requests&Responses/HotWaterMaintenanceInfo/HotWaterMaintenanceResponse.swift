import Foundation

// MARK: - HotWaterMaintenanceResponse
struct HotWaterMaintenanceResponse: Codable {
    let status: String
    let responseData: ResponseData
    let expectedResponseDate: String
}

// MARK: - ResponseData
struct ResponseData: Codable {
    let classifiers: [Classifier]
}

// MARK: - Classifier
struct Classifier: Codable {
    let classifierID: Int
    let classifierName, file, version: String

    enum CodingKeys: String, CodingKey {
        case classifierID = "classifierId"
        case classifierName, file, version
    }
}

