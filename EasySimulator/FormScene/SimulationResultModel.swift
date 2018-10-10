//
//  SimulationResultModel.swift
//  Easy Simulator
//

import Foundation

struct SimulationResultModel: Codable {
    var investmentParameter: InvestmentParameter
    var grossAmount: Decimal
    var taxesAmount: Decimal
    var netAmount: Decimal
    var grossAmountProfit: Decimal
    var netAmountProfit: Decimal
    var annualGrossRateProfit: Decimal
    var monthlyGrossRateProfit: Decimal
    var dailyGrossRateProfit: Decimal
    var taxesRate: Decimal
    var rateProfit: Decimal
    var annualNetRateProfit: Decimal

    func roundValues() -> SimulationResultModel {
        var roundedModel = self
        roundedModel.investmentParameter.investedAmount.round()
        roundedModel.investmentParameter.yearlyInterestRate.round()
        roundedModel.investmentParameter.rate.round()
        roundedModel.grossAmount.round()
        roundedModel.taxesAmount.round()
        roundedModel.taxesRate.round()
        roundedModel.netAmount.round()
        roundedModel.grossAmountProfit.round()
        roundedModel.netAmountProfit.round()
        roundedModel.annualGrossRateProfit.round()
        roundedModel.monthlyGrossRateProfit.round()
        roundedModel.dailyGrossRateProfit.round()
        roundedModel.taxesRate.round()
        roundedModel.rateProfit.round()
        roundedModel.annualGrossRateProfit.round()
        return roundedModel
    }

    func toTupleArray() -> [(String, String)] {
        var array = [(String, String)]()

        array.append(("Valor aplicado inicialmente", "R$ \(investmentParameter.investedAmount)"))
        array.append(("Valor bruto do investimento", "R$ \(grossAmount)"))
        array.append(("Valor do rendimento", "R$ \(grossAmountProfit)"))
        array.append(("IR sobre o investimento", "R$ \(taxesAmount)(\(taxesRate) %)"))
        array.append(("Valor líquido do investimento", "R$ \(netAmount)"))
        if let stringDate = investmentParameter.maturityDate.formatDateString(from: "yyyy-MM-dd'T'HH:mm:ss",
                                                                              to: "dd/MM/yyyy") {
            array.append(("Data de resgate", "\(stringDate)"))
        }
        array.append(("Dias corridos", "\(investmentParameter.maturityTotalDays)"))
        array.append(("Rendimento mensal", "\(monthlyGrossRateProfit) %"))
        array.append(("Percentual do CDI do investimento", "\(investmentParameter.rate) %"))
        array.append(("Rentabilidade anual", "\(annualGrossRateProfit) %"))
        array.append(("Rentabilidade no período", "\(rateProfit) %"))

        return array
    }
}

struct InvestmentParameter: Codable {
    var investedAmount: Decimal
    var yearlyInterestRate: Decimal
    var maturityTotalDays: Int
    var maturityBusinessDays: Int
    var maturityDate: String
    var rate: Decimal
    var isTaxFree: Bool
}
