//
//  SuccessViewControllerSpec.swift
//  EasySimulatorTests
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots
@testable import EasySimulator

class SuccessViewControllerSpec: QuickSpec {
    override func spec() {
        describe("SuccessViewController") {
            var sut: SuccessViewController!

            beforeEach {
                let modelMock = SimulationModel.mock
                sut = SuccessViewController(model: modelMock)
            }

            context("Snapshots") {
                it("should have the correct layout for iPhone SE") {
                    WindowHelper.showInTestWindow(viewController: sut, for: .iPhoneSE)
                    expect(sut) == snapshot("SuccessViewController_SE")
                }

                it("should have the correct layout for iPhone XS Max") {
                    WindowHelper.showInTestWindow(viewController: sut, for: .iPhoneXSMax)
                    expect(sut) == snapshot("SuccessViewController_XSMax")
                }
            }
        }
    }
}
