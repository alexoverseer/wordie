//
//  AppDelegate.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/25/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var appFlowCoordinator: AppFlowCoordinator = {
        let coordinator = AppFlowCoordinator(window: window!)
        return coordinator
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        appFlowCoordinator.start()

        return true
    }
}
