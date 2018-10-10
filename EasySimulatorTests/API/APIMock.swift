//
//  APIMock.swift
//  EasySimulatorTests
//

import Foundation
@testable import EasySimulator

class APIMock: SimulationManager {
    var shouldReturnError: Bool

    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }

    func request(model: FormModel, completion: @escaping (Result<SimulationResultModel>) -> Void) {
        if shouldReturnError {
            completion(Result.error)
        } else {
            let mockModel = SimulationModel.mock

            completion(Result.success(mockModel))
        }
    }
}
