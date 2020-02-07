//
//  AppConstants.swift
//  Uber
//
//  Created by Elgendy on 5.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

struct AppContext {
    
    static var environment: Environment = .dev
        
    static func setupAppEnvironment() {
        #if DEBUG || RELEASE
            environment = .dev
        #elseif AppStore
            environment = .prod
        #endif
    }
    
}
