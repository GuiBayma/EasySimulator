//
//  SuccessTableViewDataSourceSpec.swift
//  EasySimulatorTests
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots
@testable import EasySimulator

class SuccessTableViewDataSourceSpec: QuickSpec {
    override func spec() {
        describe("SuccessTableViewDataSource") {
            var sut: SuccessTableViewDataSource!
            var tableView: UITableView!

            beforeEach {
                let data = SimulationModel.mock
                sut = SuccessTableViewDataSource(model: data)

                tableView = UITableView()
                tableView.register(SuccessTableViewCell.self,
                                   forCellReuseIdentifier: SuccessTableViewCell.identifier)
                tableView.dataSource = sut
            }

            context("Number of rows and sections") {
                it("should return the correct number of rows") {
                    expect(sut.tableView(tableView, numberOfRowsInSection: 0)) == 11
                }

                it("should return the correct number of sections") {
                    expect(sut.numberOfSections(in: tableView)) == 1
                }
            }

            context("Cell views") {
                it("should return invested amount cell for indexPath.row = 0") {
                    let indexPath = IndexPath(row: 0, section: 0)

                    let cell = sut.tableView(tableView, cellForRowAt: indexPath)
                    cell.setDynamicFrame(width: 320)

                    expect(cell) == snapshot("SuccessTableViewCell_InvestedAmount")
                }

                it("should return maturity date cell for indexPath.row = 5") {
                    let indexPath = IndexPath(row: 5, section: 0)

                    let cell = sut.tableView(tableView, cellForRowAt: indexPath)
                    cell.setDynamicFrame(width: 320)

                    expect(cell) == snapshot("SuccessTableViewCell_Date")
                }

                it("should return rate profit cell for indexPath.row = 10") {
                    let indexPath = IndexPath(row: 10, section: 0)

                    let cell = sut.tableView(tableView, cellForRowAt: indexPath)
                    cell.setDynamicFrame(width: 320)

                    expect(cell) == snapshot("SuccessTableViewCell_RateProfit")
                }
            }
        }
    }
}
