//
//  FormTextfieldComponent.swift
//  Easy Simulator
//

import UIKit

class FormTextfieldComponent: UIView {
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()

    var isTextfieldFirstResponser: Bool {
        return textfield.isFirstResponder
    }

    var textfieldTag: Int {
        return textfield.tag
    }

    var textfieldText: String? {
        return textfield.text
    }

    fileprivate lazy var textfield: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .none
        field.textAlignment = .center
        field.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        field.adjustsFontForContentSizeCategory = true
        return field
    }()

    fileprivate lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
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

// MARK: - Configuration

extension FormTextfieldComponent {
    fileprivate func setupViewHierarchy() {
        addSubview(titleLabel)
        addSubview(textfield)
        addSubview(lineView)
    }

    fileprivate func setupConstraints() {
        titleLabel
            .leadingAnchor(equalTo: self.leadingAnchor)
            .topAnchor(equalTo: self.topAnchor)
            .trailingAnchor(equalTo: self.trailingAnchor)

        textfield
            .leadingAnchor(equalTo: titleLabel.leadingAnchor)
            .topAnchor(equalTo: titleLabel.bottomAnchor, constant: 15)
            .trailingAnchor(equalTo: titleLabel.trailingAnchor)
            .bottomAnchor(equalTo: lineView.topAnchor, constant: -1)

        lineView
            .leadingAnchor(equalTo: textfield.leadingAnchor)
            .trailingAnchor(equalTo: textfield.trailingAnchor)
            .bottomAnchor(equalTo: self.bottomAnchor)
            .heightAnchor(equalTo: 0.5)
    }

    fileprivate func configureViews() {
        backgroundColor = .white
    }
}

// MARK: - Setters

extension FormTextfieldComponent {
    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    func setPlaceholder(_ placeholder: String) {
        textfield.placeholder = placeholder
    }

    func setTextfieldText(_ text: String) {
        textfield.text = text
    }

    func setTextfieldKeyboard(type: UIKeyboardType) {
        textfield.keyboardType = type
    }

    func setTextfieldDelegate(_ delegate: UITextFieldDelegate) {
        textfield.delegate = delegate
    }

    func setTextfieldTag(_ tag: Int) {
        textfield.tag = tag
    }

    func setTextfieldAccessibilityLabel(_ label: String) {
        textfield.accessibilityLabel = label
    }
}
