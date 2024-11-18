//
//  PortfolioTableCell.swift
//  StockPage
//
//  Created by Utkarsh Raj on 17/11/24.
//

import UIKit

class PortfolioTableCell: UITableViewCell {
    
    @IBOutlet weak var plLabel: UILabel!
    @IBOutlet weak var netQuantityLabel: UILabel!
    @IBOutlet weak var ltpLabel: UILabel!
    @IBOutlet weak var stockNameLabel: UILabel!
    static let identifier = "PortfolioTableCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
