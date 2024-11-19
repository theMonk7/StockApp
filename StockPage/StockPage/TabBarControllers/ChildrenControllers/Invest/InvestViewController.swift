//
//  InvestViewController.swift
//  StockPage
//
//  Created by Utkarsh Raj on 17/11/24.
//

import UIKit

class InvestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setUpUI()
    }
    
    // MARK: - Private methods
    
    private func setUpUI() {
        setUpNavigationBarItems()
    }
    private func setUpNavigationBarItems() {

        let profileButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
                style: .plain,
                target: self,
                action: #selector(buttonTapped)
        )
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 24))
        titleLabel.text = "Invest"
        titleLabel.textColor = .white
        let titleItem = UIBarButtonItem(customView: titleLabel)

        navigationItem.leftBarButtonItems = [profileButton, titleItem]
        
    }
    
    @objc private func buttonTapped() {
        print("Button tapped")
    }
}
