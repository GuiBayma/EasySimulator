//
//  RequestManager.swift
//  Easy Simulator
//

import Foundation

enum Result<T> {
    case success(T)
    case error
}

protocol SimulationManager {
    func request(model: FormModel, completion: @escaping (_ result: Result<SimulationResultModel>) -> Void)
}

class RequestManager: SimulationManager {
    let defaultSession: URLSession
    var dataTask: URLSessionDataTask?
    var baseUrl: String

    init(configuration: URLSessionConfiguration = .default) {
        self.defaultSession = URLSession(configuration: configuration)
        self.baseUrl = "https://api-simulator-calc.easynvest.com.br/calculator/simulate"
    }

    func request(model: FormModel, completion: @escaping (_ result: Result<SimulationResultModel>) -> Void) {
        dataTask?.cancel()

        if var urlComponents = URLComponents(string: baseUrl) {
            let amount = URLQueryItem(name: "investedAmount", value: "\(model.investedAmount)")
            let index = URLQueryItem(name: "index", value: "\(model.index)")
            let rate = URLQueryItem(name: "rate", value: "\(model.rate)")
            let isTaxFree = URLQueryItem(name: "isTaxFree", value: "\(model.isTaxFree)")
            let date = URLQueryItem(name: "maturityDate", value: "\(model.maturityDate)")
            urlComponents.queryItems = [amount, index, rate, isTaxFree, date]

            guard let url = urlComponents.url else { return }

            dataTask = defaultSession.dataTask(with: url) { data, _, error in
                defer { self.dataTask = nil }

                if let error = error {
                    print(#function, error)
                    completion(Result.error)
                } else if let jsonData = data {
                    do {
                        let decoder = JSONDecoder()
                        let resultModel = try decoder.decode(SimulationResultModel.self, from: jsonData)
                        completion(Result.success(resultModel))
                    } catch {
                        completion(Result.error)
                    }
                } else {
                    completion(Result.error)
                }
            }

            dataTask?.resume()
        }
    }
}
