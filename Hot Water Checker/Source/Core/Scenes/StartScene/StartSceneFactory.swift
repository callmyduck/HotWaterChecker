import Foundation
import UIKit

struct StartSceneFactory {

    static func createModule() -> UIViewController {
        
        let viewController = StartSceneViewController()
        
        let apiService = APIService()
        let filesManager = LocalFilesManager()
        let router = StartSceneRouter(viewController)
        
        let viewModel = StartSceneViewModel(viewController,
                                          apiService: apiService,
                                          router: router,
                                          filesManager: filesManager)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}

