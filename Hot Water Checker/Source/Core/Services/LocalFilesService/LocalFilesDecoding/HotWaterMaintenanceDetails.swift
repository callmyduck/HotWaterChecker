import Foundation

typealias HotWaterMaintenanceDetails = [HotWaterMaintenanceDetail]


// MARK: - HotWaterMaintenanceDetail
struct HotWaterMaintenanceDetail: Codable, PreviouslyUnzipped {
    let city, street, houseNumber, maintenanceDates: String
    let houseLocalLetter, houseLocalNumber: String?

    enum CodingKeys: String, CodingKey {
        case city = "Населенный пункт"
        case street = "Адрес жилого здания"
        case houseNumber = "№ дома"
        case houseLocalNumber = "корпус"
        case houseLocalLetter = "литер"
        case maintenanceDates = "Период отключения ГВС"
    }
    
    //MARK: - Previously Unzipped
    
    static var previouslyUnzippedFileName = "disconnect_teploset"
    
    //MARK: - Formatters
    private var dateFromStringFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "ru")
        dateFormatter.dateFormat = "d MMMM yyyy"
        return dateFormatter
    }()
}


//MARK: - Helper methods
extension HotWaterMaintenanceDetail {
    
    ///Combining address data in one String depending on components existance.
    func getCombinedAddress() -> String {
        var combinedAddress: String = "дом " + houseNumber
        
        if let tempHouseLocalNumber = houseLocalNumber,
           houseLocalNumber != "" {
            combinedAddress += " корпус " + tempHouseLocalNumber
        }
        
        if let tempHouseLetter = houseLocalLetter,
           houseLocalNumber != ""  {
            combinedAddress += " литер " + tempHouseLetter
        }
        
        return combinedAddress
    }
    
    ///Making maintenance dates look pretty if possible. If it's not, returning maintenance dates that came from server.
    func getMaintenanceDates() -> String {
        var finalMaintenanceDates: String = maintenanceDates
        
        let dateComponents = maintenanceDates.components(separatedBy: "-")
        if let startingDate = dateComponents.first,
           let endingDate = dateComponents.last,
           let startingDateString = dateFromStringFormatter.date(from: startingDate),
           let endingDateString = dateFromStringFormatter.date(from: endingDate) {
            let finalStartingDate = dateFormatter.string(from: startingDateString)
            let finalEndingDate = dateFormatter.string(from: endingDateString)
            
            finalMaintenanceDates = finalStartingDate + " — " + finalEndingDate
            return finalMaintenanceDates
        }
        
        return finalMaintenanceDates
    }
    
}
