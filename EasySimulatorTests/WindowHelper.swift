//
//  WindowHelper.swift
//  EasySimulatorTests
//

import UIKit

enum IPhoneTestWindow {
    case iPhoneSE
    case iPhoneXSMax
}

class WindowHelper {
    static var seTestWindow: UIWindow = {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
        return window
    }()

    static var XSMaxTestWindow: UIWindow = {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 414, height: 896))
        return window
    }()

    static func showInTestWindow(viewController: UIViewController, for iPhone: IPhoneTestWindow) {
        switch iPhone {
        case .iPhoneSE:
            WindowHelper.seTestWindow.rootViewController = viewController
            WindowHelper.seTestWindow.makeKeyAndVisible()
        case .iPhoneXSMax:
            WindowHelper.XSMaxTestWindow.rootViewController = viewController
            WindowHelper.XSMaxTestWindow.makeKeyAndVisible()
        }
    }
}
