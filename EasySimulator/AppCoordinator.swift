//
//  AppCoordinator.swift
//  EasySimulator
//

import UIKit

protocol AppCoordinatorDelegate: class {
    func simulationDidFinish(with model: SimulationResultModel)
    func simulateAgain()
}

final class AppCoordinator {
    fileprivate let window: UIWindow
    fileprivate var navigation: UINavigationController

    init(window: UIWindow, navigation: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigation = navigation
    }

    func start(with serviceAPI: FormAPI = FormAPI()) {
        let formController = FormViewController(service: serviceAPI)
        formController.coordinatorDelegate = self
        navigation.pushViewController(formController, animated: false)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}

// MARK: - AppCoordinatorDelegate

extension AppCoordinator: AppCoordinatorDelegate {
    func simulationDidFinish(with model: SimulationResultModel) {
        let successController = SuccessViewController(model: model)
        successController.coordinatorDelegate = self
        navigation.pushViewController(successController, animated: true)
    }

    func simulateAgain() {
        navigation.popViewController(animated: true)
    }
}
