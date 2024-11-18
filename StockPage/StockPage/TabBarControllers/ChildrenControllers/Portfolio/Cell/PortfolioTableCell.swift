//
//  PortfolioTableCell.swift
//  StockPage
//
//  Created by Utkarsh Raj on 17/11/24.
//

import UIKit

class PortfolioTableCell: UITableViewCell {
    
    
    // MARK: - Outlets
    @IBOutlet weak var plLabel: UILabel!
    @IBOutlet weak var netQuantityLabel: UILabel!
    @IBOutlet weak var ltpLabel: UILabel!
    @IBOutlet weak var stockNameLabel: UILabel!
    
    // MARK: - Properties
    static let identifier = "PortfolioTableCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var viewModel: PortfolioCellViewModel? {
        didSet {
            setUpUI()
        }
    }
    // MARK: -  Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:  Private methods
    
    private func setUpUI() {
        ltpLabel.text = viewModel?.formattedLtp
        netQuantityLabel.text = viewModel?.formattedQuantity
        plLabel.text = viewModel?.formattedTodayPnl
        stockNameLabel.text = viewModel?.stockName
        plLabel.textColor = viewModel?.pnlTextColor
    }
    
}
