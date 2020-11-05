import Foundation
import UIKit

final class StartSceneViewController: UIViewController {
    
    var viewModel: StartSceneViewModel!
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewAppeared()
    }
    
    //MARK: - Initial setup
    
    private func setup() {
        setupView()
        bindViewModel()
    }
    
    //MARK: - Setup UI
    
    private func setupView() {
        view.backgroundColor = .black
        
        activityIndicator = .init(style: .whiteLarge)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
    }
    
    //MARK: - ViewModel binding
    
    private func bindViewModel() {
        viewModel.onLoadingStarted = { [weak self] in
            guard let self = self else { return }
            self.showLoader()
        }
        
        viewModel.onLoadingFinished = { [weak self] in
            guard let self = self else { return }
            self.dismissLoader()
        }
    }
}

//MARK: - Private Methods
extension StartSceneViewController {
    
    private func showLoader() {
        activityIndicator.startAnimating()
    }
    
    private func dismissLoader() {
        activityIndicator.stopAnimating()
    }
}
