//
//  PortfolioViewController.swift
//  StockPage
//
//  Created by Utkarsh Raj on 17/11/24.
//

import UIKit
import Combine

class PortfolioViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = PortfolioDataViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Views
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(PortfolioTableCell.nib(), forCellReuseIdentifier: PortfolioTableCell.identifier)
        return tv
    }()
    
    lazy var loader = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        
        return activityIndicator
    }()
    
    lazy var refreshControl = {
        let refresh = UIRefreshControl()
        return refresh
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpBindings()
        
        
        // Fetch Data
        viewModel.fetchData()
        
    }
    
    // MARK: - Private methods
    
    private func setUpBindings() {
        viewModel.$stockData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading && !(self?.refreshControl.isRefreshing ?? false) {
                    self?.loader.startAnimating()
                } else {
                    self?.loader.stopAnimating()
                    self?.refreshControl.endRefreshing()
                }
            }
            .store(in: &cancellables)
    
    }
    
    private func setUpUI() {
        setUpNavigationBarItems()
        
        // Set up programmatic view
        style()
        layout()
        
        
        
    }
    
    private func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.color = .tabTintColor
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .tabTintColor
        
    }
    
    private func layout() {
        self.view.addSubview(tableView)
        self.view.addSubview(loader)
        tableView.addSubview(refreshControl)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setUpNavigationBarItems() {
        // Left Bar Items
        let profileButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
                style: .plain,
                target: self,
                action: #selector(buttonTapped)
        )
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 24))
        titleLabel.text = "Portfolio"
        titleLabel.textColor = .white
        let titleItem = UIBarButtonItem(customView: titleLabel)

        navigationItem.leftBarButtonItems = [profileButton, titleItem]
        
        // Right Bar Items
        let arrowButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.arrow.down"),
                style: .plain,
                target: self,
                action: #selector(buttonTapped)
        )
        
        let dividerView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 20))
        dividerView.backgroundColor = .lightGray
        let dividerItem = UIBarButtonItem(customView: dividerView)
            
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(buttonTapped)
        )
            
        navigationItem.rightBarButtonItems = [searchButton, dividerItem, arrowButton]
    }
    
    @objc private func buttonTapped() {
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.fetchData()
    }

}

extension PortfolioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PortfolioTableCell.identifier, for: indexPath) as? PortfolioTableCell else {
            return UITableViewCell()
        }
        cell.ltpLabel.text = "₹ \(viewModel.stockData[indexPath.row].ltp)"
        cell.netQuantityLabel.text = "₹ \(viewModel.stockData[indexPath.row].quantity)"
        cell.plLabel.text = "₹ \(viewModel.stockData[indexPath.row].ltp)"
        cell.stockNameLabel.text = viewModel.stockData[indexPath.row].symbol
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
