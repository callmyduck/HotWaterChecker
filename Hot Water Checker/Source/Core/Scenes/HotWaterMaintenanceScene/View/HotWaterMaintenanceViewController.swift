import Foundation
import UIKit
import SnapKit

class HotWaterMaintenanceViewController: UIViewController {
    
    var viewModel: HotWaterMaintenanceViewModel!
    var maintenanceTableView: HotWaterMaintenanceTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Initial setup
    
    private func setup() {
        setupView()
        snapViews()
    }
    
    // MARK: - UI setup
    
    private func setupView() {
        view.backgroundColor = R.Color.background
        configureTableView()
    }
    
    private func configureTableView() {
        maintenanceTableView = .init()
        maintenanceTableView.delegate = self
        maintenanceTableView.dataSource = self
        view.addSubview(maintenanceTableView)
    }
    
    private func snapViews() {
        maintenanceTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(24)
            make.left.right.bottom.equalToSuperview()
        }
    }
}


// MARK: - UITableView dataSource, delegate
extension HotWaterMaintenanceViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.hotWaterMaintenanceDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = maintenanceTableView.dequeueReusableCell(withIdentifier: HotWaterMaintenanceCell.reuseIdentifier, for: indexPath) as! HotWaterMaintenanceCell
        let hotWaterMaintenanceDetail = viewModel.hotWaterMaintenanceDetails[indexPath.row]
        
        cell.configureCell(withData: hotWaterMaintenanceDetail)
        
        return cell
    }
}
