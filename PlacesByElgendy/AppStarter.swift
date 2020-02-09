//
//  AppStarter.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 7.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

/// AppStarter here you can handle everything before letting your app starts
final class AppStarter {
    static let shared = AppStarter()
    
    private init() {}
    
    func start(window: UIWindow?) {
        setRootViewController(window: window)
        setupKeyboardManager()
    }

    private func setRootViewController(window: UIWindow?) {
        let vc = SearchViewController()
        let rootViewController = UINavigationController(rootViewController: vc)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
