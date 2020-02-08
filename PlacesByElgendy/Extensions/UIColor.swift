//
//  UIColor.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 7.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

extension UIColor {
    @nonobjc class var viewBackground: UIColor {
        return UIColor(white: 238.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var buttonBackground: UIColor {
        return UIColor(red: 0.0, green: 122.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    @nonobjc class var buttonBorder: UIColor {
        return UIColor(white: 155.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var textFieldPlaceholder: UIColor {
        return UIColor(white: 155.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var placesCellLabel: UIColor {
      return UIColor(red: 70.0 / 255.0, green: 79.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
    }
}
