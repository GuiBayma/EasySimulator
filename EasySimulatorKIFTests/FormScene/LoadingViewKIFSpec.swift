//
//  LoadingViewKIFSpec.swift
//  EasySimulatorKIFTests
//

import KIF
import XCTest
@testable import EasySimulator

class LoadingViewKIFSpec: KIFTestCase {
    var viewController: UIViewController!

    override func setUp() {
        super.setUp()
        self.viewController = UIViewController()
        self.viewController.view.backgroundColor = .white
        self.viewController.view.accessibilityLabel = "EmptyView"
        WindowHelper.showInTestWindow(viewController: viewController, for: .iPhoneXSMax)
        tester().waitForView(withAccessibilityLabel: "EmptyView")
    }

    override func tearDown() {
        super.tearDown()
        tester().waitForAnimationsToFinish()
    }

    func testCallingLoadingViewFromController() {
        let loadingView = viewController.startLoading(text: "Test text")

        tester().waitForView(withAccessibilityLabel: "LoadingView")
        viewController.stopLoading(loadingView)

        tester().waitForView(withAccessibilityLabel: "LoadingView")
    }
}
