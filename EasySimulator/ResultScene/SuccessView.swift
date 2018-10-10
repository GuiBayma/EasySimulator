//
//  SuccessView.swift
//  Easy Simulator
//

import UIKit

class SuccessView: UIView {
    fileprivate lazy var resultTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Resultado da simulação"
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .gray
        return label
    }()

    fileprivate lazy var grossAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    fileprivate lazy var grossAmountProfitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    fileprivate lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SuccessTableViewCell.self,
                       forCellReuseIdentifier: SuccessTableViewCell.identifier)
        table.separatorStyle = .none
        table.tableFooterView = UIView()
        return table
    }()

    var buttonAction: (() -> Void)?

    @objc
    fileprivate func buttonPressed() {
        buttonAction?()
    }

    fileprivate lazy var button: SimulateButtonComponent = {
        let button = SimulateButtonComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Simular novamente", for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }
}

// MARK: - View Configuration

extension SuccessView {
    fileprivate func setupViewHierarchy() {
        addSubview(resultTitleLabel)
        addSubview(grossAmountLabel)
        addSubview(grossAmountProfitLabel)
        addSubview(tableView)
        addSubview(button)
    }

    fileprivate func setupConstraints() {
        resultTitleLabel
            .leadingAnchor(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15)
            .topAnchor(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15)
            .trailingAnchor(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15)

        grossAmountLabel
            .leadingAnchor(equalTo: resultTitleLabel.leadingAnchor)
            .topAnchor(equalTo: resultTitleLabel.bottomAnchor, constant: 10)
            .trailingAnchor(equalTo: resultTitleLabel.trailingAnchor)

        grossAmountProfitLabel
            .leadingAnchor(equalTo: resultTitleLabel.leadingAnchor)
            .topAnchor(equalTo: grossAmountLabel.bottomAnchor, constant: 10)
            .trailingAnchor(equalTo: resultTitleLabel.trailingAnchor)

        tableView
            .leadingAnchor(equalTo: self.safeAreaLayoutGuide.leadingAnchor)
            .topAnchor(equalTo: grossAmountProfitLabel.bottomAnchor, constant: 30)
            .trailingAnchor(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
            .bottomAnchor(equalTo: button.topAnchor, constant: -30)

        button
            .leadingAnchor(equalTo: resultTitleLabel.leadingAnchor)
            .trailingAnchor(equalTo: resultTitleLabel.trailingAnchor)
            .bottomAnchor(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -15)
            .heightAnchor(equalTo: 50)
    }

    fileprivate func configureViews() {
        backgroundColor = .white
        accessibilityLabel = "SuccessView"
    }
}

// MARK: - Setters

extension SuccessView {
    func setGrossAmount(_ amount: Decimal) {
        grossAmountLabel.text = "R$ \(amount)"
    }

    func setGrossProfit(_ profit: Decimal) {
        let profitString = "Rendimento total de R$ \(profit)"
        let stringToColor = "R$ \(profit)"
        let rangeOfStringToColor = (profitString as NSString).range(of: stringToColor)

        let attributedString = NSMutableAttributedString(string: profitString)
        let color = UIColor.blue.withAlphaComponent(0.6)

        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color], range: rangeOfStringToColor)

        grossAmountProfitLabel.attributedText = attributedString
    }

    func setTableViewDataSource(_ source: UITableViewDataSource) {
        tableView.dataSource = source
    }
}
