//
//  AppCoordinatorMock.swift
//  EasySimulatorTests
//

import Foundation
@testable import EasySimulator

class AppCoordinatorMock: AppCoordinatorDelegate {
    var didFinishSimulation = false
    func simulationDidFinish(with model: SimulationResultModel) {
        didFinishSimulation = true
    }

    var didSimulateAgain = false
    func simulateAgain() {
        didSimulateAgain = true
    }
}
