//
//  SuccessViewControllerKIFSpec.swift
//  EasySimulatorKIFTests
//

import KIF
import XCTest
@testable import EasySimulator

class SuccessViewControllerKIFSpec: KIFTestCase {
    var appCoordinator: AppCoordinator!

    override func setUp() {
        super.setUp()
        let window = WindowHelper.XSMaxTestWindow
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        viewController.view.accessibilityLabel = "EmptyView"
        let navigation = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigation
        window.makeKeyAndVisible()

        self.appCoordinator = AppCoordinator(window: window, navigation: navigation)
        let mockModel = SimulationModel.mock
        self.appCoordinator.simulationDidFinish(with: mockModel)
        tester().waitForView(withAccessibilityLabel: "SuccessView")
    }

    override func tearDown() {
        super.tearDown()
        tester().waitForAnimationsToFinish()
    }

    func testSimulateAgain() {
        tester().tapView(withAccessibilityLabel: "SimulateButton")

        tester().waitForView(withAccessibilityLabel: "EmptyView")
    }
}
