//
//  FormAPISpec.swift
//  EasySimulatorTests
//

import Foundation
import Quick
import Nimble
@testable import EasySimulator

class FormAPISpec: QuickSpec {
    // swiftlint:disable function_body_length
    override func spec() {
        describe("FormAPI") {
            var sut: FormAPI!
            var formModel: FormModel!

            beforeEach {
                formModel = FormModel(investedAmount: 2000,
                                      index: "CDI",
                                      rate: 100,
                                      isTaxFree: false,
                                      maturityDate: "2018-12-25")
            }

            context("Success result") {
                beforeEach {
                    let mockManager = APIMock(shouldReturnError: false)
                    sut = FormAPI(manager: mockManager)
                }

                it("should return the correct object") {
                    var model: SimulationResultModel!

                    sut.getSimulationResult(model: formModel) { result in
                        switch result {
                        case .success(let response):
                            model = response
                        case .error:
                            fail("should not return error")
                        }
                    }

                    expect(model.investmentParameter.investedAmount).toEventually(equal(2000))
                    expect(model.investmentParameter.rate).toEventually(equal(100))
                    expect(model.investmentParameter.isTaxFree).toEventuallyNot(beTrue())
                    expect(model.grossAmount).toEventually(equal(2024.60))
                    expect(model.annualGrossRateProfit).toEventually(equal(1.23))
                }
            }

            context("Error result") {
                beforeEach {
                    let mockManager = APIMock(shouldReturnError: true)
                    sut = FormAPI(manager: mockManager)
                }

                it("should return error") {
                    var model: SimulationResultModel?
                    var error = false

                    sut.getSimulationResult(model: formModel) { result in
                        switch result {
                        case .success(let response):
                            model = response
                        case .error:
                            error = true
                        }
                    }

                    expect(model).toEventually(beNil())
                    expect(error).toEventually(beTrue())
                }
            }
        }
    }
}
