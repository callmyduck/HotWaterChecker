import UIKit

class HotWaterMaintenanceTableView: UITableView {
    
    //MARK: - Initialization
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        rowHeight = UITableView.automaticDimension
        backgroundColor = R.Color.background
        allowsSelection = false
        separatorStyle = .none
        estimatedRowHeight = 200
        translatesAutoresizingMaskIntoConstraints = false
        
        register(HotWaterMaintenanceCell.self, forCellReuseIdentifier: HotWaterMaintenanceCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
