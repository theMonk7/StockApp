//
//  BottomSheetUIView.swift
//  StockPage
//
//  Created by Utkarsh Raj on 19/11/24.
//

import UIKit

class BottomSheetUIView: UIView {

    // MARK: - Properties
    private let stackView = UIStackView()
    private var isExpanded = false

    private var expandedRows: [UIView] = []
    private var topView: UIView?
    private var bottomView: UIView?
    private var profitAndLossLabelTop: UILabel?
    private var profitAndLossLabelBottom: UILabel?
    private var currentValueLabel: UILabel?
    private var totalInvestmentLabel: UILabel?
    private var todaysProfitAndLossLabel: UILabel?
    
    var viewModel: BottomSheetUIViewModel? {
        didSet {
            updateData()
        }
    }

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup View
    private func setupView() {
        self.backgroundColor = .bottomSheetColor
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.9
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 1

        // Main stack view
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill

        let profitAndLossRow1 = createRow(title: "Profit & Loss*")
        topView = profitAndLossRow1.row
        profitAndLossLabelTop = profitAndLossRow1.valueLabel
        stackView.addArrangedSubview(profitAndLossRow1.row)
        
        

        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let row1 = createRow(title: "Current value*")
        currentValueLabel = row1.valueLabel
        let row2 = createRow(title: "Total investment*")
        totalInvestmentLabel = row2.valueLabel
        let row3 = createRow(title: "Today's Profit & Loss*")
        todaysProfitAndLossLabel = row3.valueLabel
        expandedRows = [
            row1.row, row2.row, row3.row, separator
        ]

        expandedRows.forEach { row in
            row.isHidden = true
            stackView.addArrangedSubview(row)
        }
        
        let profitAndLossRow2 = createRow(title: "Profit & Loss*")
        bottomView = profitAndLossRow2.row
        profitAndLossRow2.row.isHidden = true
        profitAndLossLabelBottom = profitAndLossRow2.valueLabel
        stackView.addArrangedSubview(profitAndLossRow2.row)

        self.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }

    // MARK: - Expand/Collapse Logic
    @objc func toggleExpanded() {
        isExpanded.toggle()

        UIView.animate(withDuration: 0.3, animations: {
            self.expandedRows.forEach { row in
                row.isHidden = !self.isExpanded
            }
            self.topView?.isHidden = self.isExpanded
            self.bottomView?.isHidden = !self.isExpanded
            self.layoutIfNeeded()
        })
    }

    // MARK: - Helper Method
    private func createRow(title: String) -> (row: UIView, valueLabel: UILabel) {

        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.spacing = 8
        rowStackView.alignment = .center
        rowStackView.distribution = .equalSpacing

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        titleLabel.textColor = .darkGray

        let valueLabel = UILabel()
        valueLabel.text = ""
        valueLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        valueLabel.textColor = .darkGray

        rowStackView.addArrangedSubview(titleLabel)
        rowStackView.addArrangedSubview(valueLabel)

        return (row: rowStackView, valueLabel: valueLabel)
    }
    
    private func updateData() {
        profitAndLossLabelTop?.text = viewModel?.totalPnL.indianCurrencyFormat
        profitAndLossLabelTop?.textColor = viewModel?.totalPnLTextColor
        
        currentValueLabel?.text = viewModel?.currentValue.indianCurrencyFormat
        totalInvestmentLabel?.text = viewModel?.totalInvestment.indianCurrencyFormat
        todaysProfitAndLossLabel?.text = viewModel?.todayPnL.indianCurrencyFormat
        todaysProfitAndLossLabel?.textColor = viewModel?.todayPnLTextColor
        
        profitAndLossLabelBottom?.text = viewModel?.totalPnL.indianCurrencyFormat
        profitAndLossLabelBottom?.textColor = viewModel?.totalPnLTextColor
        
    }
}
