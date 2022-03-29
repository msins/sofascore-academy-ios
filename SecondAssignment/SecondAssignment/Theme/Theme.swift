//
//  Theme.swift
//  SecondAssignment
//
//  Created by Marko Sinkovic on 28.03.2022..
//

import Foundation
import UIKit


enum Theme {
    case light, dark
    
    static var current: Theme = Theme.light
    
    static let IsLightThemeKey = "light_theme"
    
    var background: UIColor {
        switch self {
        case .light:
            return .backgroundLight
        case .dark:
            return .backgroundDark
        }
    }
    
    var primaryText: UIColor {
        switch self {
        case .light:
            return .primaryLightText
        case .dark:
            return .primaryDarkText
        }
    }
    
    var primary: UIColor {
        switch self {
        default:
            return .primary
        }
    }
}
