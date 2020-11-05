import UIKit


final class HotWaterMaintenanceCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var containerView: UIView!
    private var cityLabel: UILabel!
    private var streetLabel: UILabel!
    private var houseNumberCombinedLabel: UILabel!
    private var maintenanceDatesLabel: UILabel!
    
    static let reuseIdentifier: String = "hotWaterMaintenanceCell"
    
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View setup
    
    private func setup() {
        backgroundColor = .black
        
        setupViews()
        snapViews()
    }
    
    private func setupViews() {
        containerView = .init()
        containerView.backgroundColor = R.Color.contentBackground
        containerView.layer.cornerRadius = 16
        addSubview(containerView)
        
        cityLabel = .init()
        cityLabel.numberOfLines = 0
        cityLabel.font = R.Font.bold(16)
        cityLabel.textColor = .black
        cityLabel.textAlignment = .center
        containerView.addSubview(cityLabel)
        
        
        streetLabel = .init()
        streetLabel.numberOfLines = 0
        streetLabel.font = R.Font.medium(14)
        streetLabel.textColor = .black
        streetLabel.textAlignment = .center
        containerView.addSubview(streetLabel)
        
        houseNumberCombinedLabel = .init()
        houseNumberCombinedLabel.numberOfLines = 0
        houseNumberCombinedLabel.font = R.Font.regular(14)
        houseNumberCombinedLabel.textColor = .black
        houseNumberCombinedLabel.textAlignment = .center
        containerView.addSubview(houseNumberCombinedLabel)
        
        maintenanceDatesLabel = .init()
        maintenanceDatesLabel.numberOfLines = 0
        maintenanceDatesLabel.font = R.Font.bold(14)
        maintenanceDatesLabel.textColor = .black
        maintenanceDatesLabel.textAlignment = .center
        containerView.addSubview(maintenanceDatesLabel)
    }
    
    private func snapViews() {
        
        containerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(4)
        }
        
        cityLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(32)
        }
        
        streetLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cityLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(32)
        }
        
        houseNumberCombinedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(streetLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(32)
        }
        
        maintenanceDatesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(houseNumberCombinedLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().inset(16)
        }
        
    }
    
    //MARK: - Methods
    
    func configureCell(withData maintenanceDetails: HotWaterMaintenanceDetail) {
        cityLabel.text = maintenanceDetails.city
        streetLabel.text = maintenanceDetails.street
        houseNumberCombinedLabel.text = maintenanceDetails.getCombinedAddress()
        maintenanceDatesLabel.text = maintenanceDetails.getMaintenanceDates()
    }
}
