//
//  String+Date.swift
//  Easy Simulator
//

import Foundation

extension String {
    func formatDateString(from: String, to output: String) -> String? {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = from

        if let date = formatter.date(from: self) {
            formatter.dateFormat = output
            return formatter.string(from: date)
        }

        return nil
    }
}
