//
//  SimulationResultModelMock.swift
//  EasySimulatorTests
//

import Foundation
@testable import EasySimulator

class SimulationModel {
    static var mock: SimulationResultModel = {
        let investmentParameterMock = InvestmentParameter(investedAmount: 2000.0,
                                                          yearlyInterestRate: 6.355,
                                                          maturityTotalDays: 78,
                                                          maturityBusinessDays: 50,
                                                          maturityDate: "2018-12-25T00:00:00",
                                                          rate: 100.0,
                                                          isTaxFree: false)
        return SimulationResultModel(investmentParameter: investmentParameterMock,
                                     grossAmount: 2024.60,
                                     taxesAmount: 5.54,
                                     netAmount: 2019.06,
                                     grossAmountProfit: 24.60,
                                     netAmountProfit: 19.06,
                                     annualGrossRateProfit: 1.23,
                                     monthlyGrossRateProfit: 0.51,
                                     dailyGrossRateProfit: 0.00024452341926251,
                                     taxesRate: 22.5,
                                     rateProfit: 6.355,
                                     annualNetRateProfit: 0.95)
    }()
}
