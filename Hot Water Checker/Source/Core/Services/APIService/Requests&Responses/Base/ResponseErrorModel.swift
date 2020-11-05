import Foundation


class ResponseErrorModel: Error {
    
    // MARK: - Properties
    var errorTitle: String
    var errorText: String
    var errorAction: String
    
    init(_ errorKey: ResponseErrorKey) {
        
        switch errorKey {
        case .noNetworkConnection:
            self.errorTitle = NSLocalizedString("ResponseErrorModel.ResponseErrorKey.noNetworkConnection.title",
                                                comment: "")
            self.errorText = NSLocalizedString("ResponseErrorModel.ResponseErrorKey.noNetworkConnection.text",
                                                  comment: "")
            self.errorAction = NSLocalizedString("ResponseErrorModel.ResponseErrorKey.noNetworkConnection.action",
                                                      comment: "")
        case .unexpectedError:
            self.errorTitle = NSLocalizedString("ResponseErrorModel.ResponseErrorKey.unexpectedError.title",
                                                comment: "")
            self.errorText = NSLocalizedString("ResponseErrorModel.ResponseErrorKey.unexpectedError.text",
                                                  comment: "")
            self.errorAction = NSLocalizedString("ResponseErrorModel.ResponseErrorKey.unexpectedError.action",
                                                      comment: "")
        case .parsingError:
            self.errorTitle = NSLocalizedString("ResponseErrorModel.ResponseErrorKey.parsingError.title",
                                                comment: "")
            self.errorText = NSLocalizedString("ResponseErrorModel.ResponseErrorKey.parsingError.text",
                                                  comment: "")
            self.errorAction = NSLocalizedString("ResponseErrorModel.ResponseErrorKey.parsingError.action",
                                                      comment: "")
        }
    }
}
