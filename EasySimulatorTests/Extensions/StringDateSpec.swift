//
//  String+DateSpec.swift
//  EasySimulatorTests
//

import Foundation
import Quick
import Nimble
@testable import EasySimulator

class StringDateSpec: QuickSpec {
    override func spec() {
        describe("String extension") {
            context("Formatting string dates") {
                it("should return the correct format for the date 08/10/2018") {
                    let initialDate = "08/10/2018"

                    let resultDate = initialDate.formatDateString(from: "dd/MM/yyyy", to: "yyyy-MM-dd")

                    expect(resultDate) == "2018-10-08"
                }

                it("should return the correct format for the date 25/12/2018") {
                    let initialDate = "2018-12-25T00:00:00"

                    let resultDate = initialDate.formatDateString(from: "yyyy-MM-dd'T'HH:mm:ss", to: "dd/MM/yyyy")

                    expect(resultDate) == "25/12/2018"
                }
            }
        }
    }
}
