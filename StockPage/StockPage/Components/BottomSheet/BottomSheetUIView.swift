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
    private var isExpanded = false // To track the expanded/collapsed state

    private var expandedRows: [UIView] = []
    private var topView: UIView?
    private var bottomView: UIView?

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

        // Add collapsed row (Profit & Loss only)
        let profitAndLossRow1 = createRow(title: "Profit & Loss*", value: "₹ 697.06 (2.44%)", valueColor: .systemRed)
        topView = profitAndLossRow1
        stackView.addArrangedSubview(profitAndLossRow1)
        
        

        // Add all expanded rows
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true

        expandedRows = [
            createRow(title: "Current value*", value: "₹ 27,893.65", valueColor: .systemGreen),
            createRow(title: "Total investment*", value: "₹ 28,590.71", valueColor: .systemGreen),
            createRow(title: "Today's Profit & Loss*", value: "₹ 235.65", valueColor: .systemRed),
            separator
        ]

        // Add rows to stackView (hidden initially)
        expandedRows.forEach { row in
            row.isHidden = true
            stackView.addArrangedSubview(row)
        }
        
        let profitAndLossRow2 = createRow(title: "Profit & Loss*", value: "₹ 697.06 (2.44%)", valueColor: .systemRed)
        bottomView = profitAndLossRow2
        profitAndLossRow2.isHidden = true
        stackView.addArrangedSubview(profitAndLossRow2)

        // Add stack view to the view
        self.addSubview(stackView)

        // Constraints for the stack view
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
    private func createRow(title: String, value: String, valueColor: UIColor) -> UIView {
        // Horizontal stack for a row
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.spacing = 8
        rowStackView.alignment = .center
        rowStackView.distribution = .equalSpacing

        // Title label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        titleLabel.textColor = .darkGray

        // Value label
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        valueLabel.textColor = valueColor

        // Add labels to the row stack view
        rowStackView.addArrangedSubview(titleLabel)
        rowStackView.addArrangedSubview(valueLabel)

        return rowStackView
    }
}
