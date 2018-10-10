//
//  FormView.swift
//  Easy Simulator
//

import UIKit

class FormView: UIView {
    fileprivate lazy var amountTextfieldComponent: FormTextfieldComponent = {
        let component = FormTextfieldComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.setTitle("Quanto você gostaria de aplicar?")
        component.setPlaceholder("R$")
        component.setTextfieldKeyboard(type: .decimalPad)
        component.setTextfieldTag(0)
        component.setTextfieldAccessibilityLabel("AmountTextfield")
        return component
    }()

    fileprivate lazy var maturityTextfieldComponent: FormTextfieldComponent = {
        let component = FormTextfieldComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.setTitle("Qual a data de vencimento do investimento?")
        component.setPlaceholder("dia/mês/ano")
        component.setTextfieldKeyboard(type: .decimalPad)
        component.setTextfieldTag(1)
        component.setTextfieldAccessibilityLabel("MaturityDateTextfield")
        return component
    }()

    fileprivate lazy var rateTextfieldComponent: FormTextfieldComponent = {
        let component = FormTextfieldComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.setTitle("Qual o percentual do CDI do investimento?")
        component.setPlaceholder("100%")
        component.setTextfieldKeyboard(type: .decimalPad)
        component.setTextfieldTag(2)
        component.setTextfieldAccessibilityLabel("RateTextfield")
        return component
    }()

    var buttonAction: (() -> Void)?

    @objc
    fileprivate func buttonPressed() {
        buttonAction?()
    }

    fileprivate lazy var button: SimulateButtonComponent = {
        let button = SimulateButtonComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Simular", for: .normal)
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

extension FormView {
    fileprivate func setupViewHierarchy() {
        addSubview(amountTextfieldComponent)
        addSubview(maturityTextfieldComponent)
        addSubview(rateTextfieldComponent)
        addSubview(button)
    }

    fileprivate func setupConstraints() {
        amountTextfieldComponent
            .leadingAnchor(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15)
            .topAnchor(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60)
            .trailingAnchor(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15)
            .heightAnchor(equalTo: 85)

        maturityTextfieldComponent
            .leadingAnchor(equalTo: amountTextfieldComponent.leadingAnchor)
            .topAnchor(equalTo: amountTextfieldComponent.bottomAnchor, constant: 40)
            .trailingAnchor(equalTo: amountTextfieldComponent.trailingAnchor)
            .heightAnchor(equalTo: amountTextfieldComponent.heightAnchor)

        rateTextfieldComponent
            .leadingAnchor(equalTo: maturityTextfieldComponent.leadingAnchor)
            .topAnchor(equalTo: maturityTextfieldComponent.bottomAnchor, constant: 40)
            .trailingAnchor(equalTo: maturityTextfieldComponent.trailingAnchor)
            .heightAnchor(equalTo: maturityTextfieldComponent.heightAnchor)

        button
            .leadingAnchor(equalTo: rateTextfieldComponent.leadingAnchor, constant: 10)
            .trailingAnchor(equalTo: rateTextfieldComponent.trailingAnchor, constant: -10)
            .bottomAnchor(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -15)
            .heightAnchor(equalTo: 50)
    }

    fileprivate func configureViews() {
        backgroundColor = .white
        accessibilityLabel = "FormView"
    }
}

// MARK: - Textfields

extension FormView {
    func setTextfieldsDelegate(_ delegate: UITextFieldDelegate) {
        amountTextfieldComponent.setTextfieldDelegate(delegate)
        maturityTextfieldComponent.setTextfieldDelegate(delegate)
        rateTextfieldComponent.setTextfieldDelegate(delegate)
    }

    func offsetForRateKeyboard(_ tag: Int) -> CGFloat {
        if tag != amountTextfieldComponent.textfieldTag {
            return 80
        }
        return 0
    }

    func setDateText(_ text: String) {
        maturityTextfieldComponent.setTextfieldText(text)
    }
}

// MARK: - Getters

extension FormView {
    func getAmount() -> Decimal? {
        let textValue = amountTextfieldComponent.textfieldText ?? ""
        if let decimal = Decimal(string: textValue) {
            return decimal
        }
        return nil
    }

    func getMaturityDate() -> String? {
        return maturityTextfieldComponent.textfieldText?.formatDateString(from: "dd/MM/yyyy",
                                                                          to: "yyyy-MM-dd")
    }

    func getRate() -> Decimal? {
        let textValue = rateTextfieldComponent.textfieldText ?? ""
        if let decimal = Decimal(string: textValue) {
            return decimal
        }
        return nil
    }
}
