//
//  FormViewControllerSpec.swift
//  EasySimulatorTests
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots
@testable import EasySimulator

class FormViewControllerSpec: QuickSpec {
    override func spec() {
        describe("FormViewController") {
            var sut: FormViewController!

            beforeEach {
                sut = FormViewController(service: FormAPI())
            }

            context("Snapshots") {
                it("should have the correct layout for iPhone SE") {
                    WindowHelper.showInTestWindow(viewController: sut, for: .iPhoneSE)
                    expect(sut) == snapshot("FormViewController_SE")
                }

                it("should have the correct layout for iPhone XS Max") {
                    WindowHelper.showInTestWindow(viewController: sut, for: .iPhoneXSMax)
                    expect(sut) == snapshot("FormViewController_XSMax")
                }
            }
        }
    }
}
