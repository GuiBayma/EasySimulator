//
//  SuccessViewController.swift
//  Easy Simulator
//

import UIKit

class SuccessViewController: UIViewController {
    fileprivate let successView = SuccessView()
    fileprivate var simulationModel: SimulationResultModel?
    fileprivate var successTableDataSource: SuccessTableViewDataSource?
    weak var coordinatorDelegate: AppCoordinatorDelegate?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(model: SimulationResultModel) {
        self.init(nibName: nil, bundle: nil)
        self.simulationModel = model
        self.successTableDataSource = SuccessTableViewDataSource(model: model)
    }
}

// MARK: - Lifecycle

extension SuccessViewController {
    override func loadView() {
        self.view = successView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupView()
    }
}

// MARK: - Setup

extension SuccessViewController {
    func setupNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func setupView() {
        guard
            let model = simulationModel,
            let source = successTableDataSource
            else { fatalError("Could not retrieve success values") }

        successView.setGrossAmount(model.grossAmount)
        successView.setGrossProfit(model.grossAmountProfit)
        successView.setTableViewDataSource(source)
        successView.buttonAction = simulateAgain
    }
}

// MARK: - Button action

extension SuccessViewController {
    func simulateAgain() {
        coordinatorDelegate?.simulateAgain()
    }
}
