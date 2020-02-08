//
//  UIButton+setTitle.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 7.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

extension UIButton {
    func setTitle(title: String?, for state: UIControl.State = .normal) {
        self.setTitle(title, for: state)
    }
}
