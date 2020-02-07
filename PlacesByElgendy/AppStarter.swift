//
//  AppStarter.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 7.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

/// AppStarter here you can handle everything before letting your app starts
final class AppStarter {
    static let shared = AppStarter()
    
    private init() {}
    
    func start(window: UIWindow?) {
        setRootViewController(window: window)
    }

    private func setRootViewController(window: UIWindow?) {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.title = "VC"
        let rootViewController = UINavigationController(rootViewController: vc)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
