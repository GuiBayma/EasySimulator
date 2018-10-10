//
//  Decimal+Round.swift
//  Easy Simulator
//

import Foundation

extension Decimal {
    mutating func round(places: Int = 2, mode: NSDecimalNumber.RoundingMode = .plain) {
        let uMPtr = UnsafeMutablePointer<Decimal>.allocate(capacity: 1)
        uMPtr[0] = self
        let uPtr = UnsafePointer<Decimal>(uMPtr)
        NSDecimalRound(uMPtr, uPtr, places, mode)
        self = uMPtr.pointee as Decimal
    }
}
