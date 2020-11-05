import Foundation
import UIKit

final class StartSceneViewModel {
    
    //MARK: - Properties
    unowned let viewController: UIViewController
    let apiService: APIService
    let router: StartSceneRouter
    let filesManager: LocalFilesManager
    
    private let alertManager = AlertService.shared
    
    var onLoadingStarted: (() -> ())?
    var onLoadingFinished: (() -> ())?
    
    //MARK: - Initialization
    init(_ viewController: UIViewController,
         apiService: APIService,
         router: StartSceneRouter,
         filesManager: LocalFilesManager) {
        
        self.viewController = viewController
        self.apiService = apiService
        self.router = router
        self.filesManager = filesManager
    }
    
    //MARK: - Methods
    
    func onViewAppeared() {
        loadMaintenanceData()
    }
    
    //MARK: - Private Methods
    
    ///Loads required maintenance data from server
    private func loadMaintenanceData() {
        onLoadingStarted?()
        
        switch Reachability.status() {
        case .connected:
            apiService.hotWaterMaintenanceRequest(classifierId: 4) { [weak self] (result) in
                guard let self = self else { return }
                
                let archiveName: String = "hotWaterMaintenanceInfo"
                switch result {
                case .success(let response):
                    let maintenanceData = response.responseData
                    guard let maintenanceClassifier = maintenanceData.classifiers.first else {
                        return
                    }
                    let maintenanceArchive = maintenanceClassifier.file
                    
                    self.onSuccessfullyLoadedMaintenanceData(withArchive: maintenanceArchive,
                                                             archiveName: archiveName)
                    
                //Something went wrong when requesting data from server
                case .failure(_):
                    DispatchQueue.main.async {
                        self.throwAlert(forErrorKey: .parsingError)
                    }
                }
            }
        case .disconnected:
            throwAlert(forErrorKey: .noNetworkConnection)
        }
    }
    
    ///Called when maintenance data successfully recieved
    private func onSuccessfullyLoadedMaintenanceData(withArchive maintenanceArchive: String,
                                                     archiveName: String) {
        
        self.filesManager.saveArchiveIfNeeded(fromBase64EncodedString: maintenanceArchive,
                                              withName: archiveName) { (result) in
            switch result {
            //Successfully saved archive (or it already exists).
            //On this step archive is already decoded, saved and unzipped to JSON file.
            case .success:
                let maintenanceDataURL: URL = self.filesManager.createPreviouslyUnzippedFileURL(ofType: HotWaterMaintenanceDetail.self)
                
                guard let archiveData = self.filesManager.readLocalFile(withURL: maintenanceDataURL,
                                                                        ofType: HotWaterMaintenanceDetails.self) else {
                    //Something went wrong when
                    //trying to read unzipped archive from filesystem.
                    DispatchQueue.main.async {
                        self.throwAlert(forErrorKey: .unexpectedError)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    self.openHotWaterMaintenanceController(withData: archiveData)
                }
                
            //Something went wrong when saving an archive
            case .failure(_):
                DispatchQueue.main.async {
                    self.throwAlert(forErrorKey: .unexpectedError)
                }
            }
        }
    }
    
    //MARK: - Alert calls
    
    ///Method called when we need to throw an alert, action is always the same — retry to load maintenance data
    private func throwAlert(forErrorKey errorKey: ResponseErrorKey) {
        onLoadingFinished?()
        alertManager.createAlert(withErrorKey: errorKey,
                                 onViewController: viewController) { [weak self] in
            guard let self = self else { return }
            self.loadMaintenanceData()
        }
    }
    
    //MARK: - Routing
    
    private func openHotWaterMaintenanceController(withData data: HotWaterMaintenanceDetails) {
        onLoadingFinished?()
        router.openHotWaterMaintenanceController(withData: data)
    }
}
