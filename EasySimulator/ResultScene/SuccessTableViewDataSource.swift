//
//  SuccessTableViewDataSource.swift
//  Easy Simulator
//

import UIKit

class SuccessTableViewDataSource: NSObject, UITableViewDataSource {
    let cellIdentifier = SuccessTableViewCell.identifier
    var modelArray: [(String, String)]

    init(model: SimulationResultModel) {
        self.modelArray = model.toTupleArray()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                     for: indexPath) as? SuccessTableViewCell
            else {
                return UITableViewCell()
        }

        cell.setKeyText(modelArray[indexPath.row].0)
        cell.setValueText(modelArray[indexPath.row].1)
        return cell
    }
}
