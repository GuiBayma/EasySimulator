//
//  FormViewControllerKIFSpec.swift
//  EasySimulatorKIFTests
//

import KIF
import XCTest
@testable import EasySimulator

class FormViewControllerKIFSpec: KIFTestCase {
    var appCoordinator: AppCoordinator!

    override func setUp() {
        super.setUp()
        let window = WindowHelper.XSMaxTestWindow
        let mockManager = APIMock(shouldReturnError: false)
        let formAPI = FormAPI(manager: mockManager)

        self.appCoordinator = AppCoordinator(window: window)
        self.appCoordinator.start(with: formAPI)
        tester().waitForView(withAccessibilityLabel: "FormView")
    }

    override func tearDown() {
        super.tearDown()
        tester().waitForAnimationsToFinish()
    }

    func testSimulatingValuesInFormController() {
        tester().enterText("2000", intoViewWithAccessibilityLabel: "AmountTextfield")
        tester().enterText("25/12/2018", intoViewWithAccessibilityLabel: "MaturityDateTextfield")
        tester().enterText("100", intoViewWithAccessibilityLabel: "RateTextfield")

        tester().tapView(withAccessibilityLabel: "SimulateButton")

        tester().waitForView(withAccessibilityLabel: "SuccessView")
    }

    func testShowingAlertWhenEmptyField() {
        tester().tapView(withAccessibilityLabel: "SimulateButton")
        tester().tapView(withAccessibilityLabel: "OkAlertAction")

        tester().waitForView(withAccessibilityLabel: "FormView")
    }
}
