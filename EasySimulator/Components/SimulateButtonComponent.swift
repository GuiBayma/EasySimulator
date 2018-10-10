//
//  SimulateButtonComponent.swift
//  Easy Simulator
//

import UIKit

class SimulateButtonComponent: UIButton {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)
        configureView()
    }
}

// MARK: - Configuration

extension SimulateButtonComponent {
    fileprivate func configureView() {
        tintColor = .white
        backgroundColor = UIColor.blue.withAlphaComponent(0.6)
        accessibilityLabel = "SimulateButton"
    }
}
