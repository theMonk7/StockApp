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
    private var isExpanded = false

    
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
    
    lazy var switcherView = {
        let view = UIView()

        let leftButton = UIButton()
        leftButton.setTitle(PortfolioConstants.positions, for: .normal)
        leftButton.setTitleColor(.grayLight, for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        let rightButton = UIButton()
        rightButton.setTitle(PortfolioConstants.holdings, for: .normal)
        rightButton.setTitleColor(.grayDark, for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        rightButton.translatesAutoresizingMaskIntoConstraints = false

        let divider = UIView()
        divider.backgroundColor = .grayLight
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(divider)
        
        // Set constraints
        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            leftButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            rightButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // Divider constraints
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            divider.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1) // Set height explicitly
        ])
        
        return view
    }()

    
    let sheet = BottomSheetUIView()
    
    // MARK: - METHODS

    // MARK:  Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpBindings()
        
        
        // Fetch Data
        viewModel.fetchData()
        
    }
    
    // MARK:  Private methods
    
    private func setUpBindings() {
        viewModel.$stockData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
                self.sheet.viewModel = BottomSheetUIViewModel(stockData: self.viewModel.stockData)
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
        
        self.view.backgroundColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.color = .tabTintColor
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .tabTintColor
        
        switcherView.translatesAutoresizingMaskIntoConstraints = false
        
        sheet.translatesAutoresizingMaskIntoConstraints = false
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:
                #selector(handleTap))
        gestureRecognizer.cancelsTouchesInView = false
        sheet.addGestureRecognizer(gestureRecognizer)
        sheet.layer.cornerRadius = 12
        
    }
    
    private func layout() {
        self.view.addSubview(tableView)
        self.view.addSubview(loader)
        self.view.addSubview(switcherView)
        tableView.addSubview(refreshControl)
        self.view.addSubview(sheet)
        
        
        NSLayoutConstraint.activate([
            switcherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            switcherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            switcherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            switcherView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: switcherView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -43),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            sheet.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sheet.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sheet.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -80)
        ])
    }
    
    private func setUpNavigationBarItems() {

        let profileButton = UIBarButtonItem(
            image: UIImage(systemName: PortfolioConstants.profileIconString),
                style: .plain,
                target: self,
                action: #selector(buttonTapped)
        )
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 24))
        titleLabel.text = PortfolioConstants.portfolio
        titleLabel.textColor = .white
        let titleItem = UIBarButtonItem(customView: titleLabel)

        navigationItem.leftBarButtonItems = [profileButton, titleItem]
        
        let arrowButton = UIBarButtonItem(
            image: UIImage(systemName: PortfolioConstants.sortIconString),
                style: .plain,
                target: self,
                action: #selector(sortData)
        )
        
        let dividerView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 20))
        dividerView.backgroundColor = .lightGray
        let dividerItem = UIBarButtonItem(customView: dividerView)
            
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: PortfolioConstants.searchIconString),
            style: .plain,
            target: self,
            action: #selector(buttonTapped)
        )
            
        navigationItem.rightBarButtonItems = [searchButton, dividerItem, arrowButton]
    }
    
    @objc private func buttonTapped() {
        
    }
    @objc private func sortData() {
        viewModel.sortData()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.fetchData()
    }
    
    @objc private func handleTap() {
        sheet.toggleExpanded()
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
        cell.viewModel = PortfolioCellViewModel(stockData: viewModel.stockData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
