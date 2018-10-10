//
//  AppDelegate.swift
//  EasySimulator
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var applicationCoordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard NSClassFromString("XCTest") == nil else { return true }

        let window = UIWindow(frame: UIScreen.main.bounds)
        let applicationCoordinator = AppCoordinator(window: window)
        self.window = window
        self.applicationCoordinator = applicationCoordinator

        applicationCoordinator.start()

        return true
    }
}
