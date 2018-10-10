//
//  SuccessTableViewCell.swift
//  Easy Simulator
//

import UIKit

class SuccessTableViewCell: UITableViewCell {
    static let identifier = "SuccessTableViewCellIdentifier"

    fileprivate lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .gray
        return label
    }()

    fileprivate lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .gray
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }
}

// MARK: - Configuration

extension SuccessTableViewCell {
    fileprivate func setupViewHierarchy() {
        addSubview(keyLabel)
        addSubview(valueLabel)
    }

    fileprivate func setupConstraints() {
        keyLabel
            .centerYAnchor(equalTo: self.centerYAnchor)
            .leadingAnchor(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15)

        valueLabel
            .centerYAnchor(equalTo: self.centerYAnchor)
            .trailingAnchor(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15)
    }

    fileprivate func configureViews() {
        backgroundColor = .white
    }
}

// MARK: - Setters

extension SuccessTableViewCell {
    func setKeyText(_ text: String) {
        keyLabel.text = text
    }

    func setValueText(_ text: String) {
        valueLabel.text = text
    }
}
