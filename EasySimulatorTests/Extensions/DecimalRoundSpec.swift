//
//  Decimal+RoundSpec.swift
//  EasySimulatorTests
//

import Foundation
import Quick
import Nimble
@testable import EasySimulator

class DecimalRoundSpec: QuickSpec {
    override func spec() {
        describe("Decimal extension") {
            context("Rounding decimal numbers") {
                it("should return the correct format for the number 0.009") {
                    var decimal: Decimal = 0.009

                    decimal.round()

                    expect(decimal) == 0.01
                }

                it("should return the correct format for the number 123.4567") {
                    var decimal: Decimal = 123.4567

                    decimal.round()

                    expect(decimal) == 123.46
                }
            }
        }
    }
}
