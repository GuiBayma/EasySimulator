//
//  FormAPI.swift
//  Easy Simulator
//

import UIKit

class FormAPI {
    fileprivate let manager: SimulationManager

    init(manager: SimulationManager = RequestManager()) {
        self.manager = manager
    }

    /**
     Chamada para receber o resultado da simulação
     
     - Parameters:
     - model: Objeto do tipo `FormModel` com os dados a serem enviados
     - completion: Bloco de resultado da simulação no objeto `SimulationResultModel`
     */
    func getSimulationResult(model: FormModel, completion: @escaping (Result<SimulationResultModel>) -> Void) {
        manager.request(model: model, completion: completion)
    }
}
