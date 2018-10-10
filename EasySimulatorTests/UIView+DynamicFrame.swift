//
//  UIView+DynamicFrame.swift
//  EasySimulatorTests
//

import UIKit

extension UIView {
    func setDynamicFrame(width: CGFloat) {
        let cellSize = self.systemLayoutSizeFitting(CGSize(width: width, height: 1000),
                                                    withHorizontalFittingPriority: .required,
                                                    verticalFittingPriority: .fittingSizeLevel)
        self.frame = CGRect(origin: .zero, size: CGSize(width: width, height: cellSize.height))
    }
}
